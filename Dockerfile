# ================================
# BUILD STAGE
# ================================
FROM amazonlinux:2 AS builder

# Set build arguments
ARG PERSONAL_ACCESS_TOKEN
ARG GITHUB_USERNAME
ARG REPOSITORY_NAME
ARG WEB_FILE_ZIP
ARG WEB_FILE_UNZIP
ARG DOMAIN_NAME
ARG RDS_ENDPOINT
ARG RDS_DB_NAME
ARG RDS_DB_USERNAME
ARG RDS_DB_PASSWORD

# Install only necessary packages for building
RUN yum update -y && \
    yum install -y unzip wget git && \
    yum clean all

# Set working directory for build operations
WORKDIR /build

# Clone the repository and extract files
RUN git clone https://${PERSONAL_ACCESS_TOKEN}@github.com/${GITHUB_USERNAME}/${REPOSITORY_NAME}.git && \
    unzip ${REPOSITORY_NAME}/${WEB_FILE_ZIP} -d ${REPOSITORY_NAME}/ && \
    cp -av ${REPOSITORY_NAME}/${WEB_FILE_UNZIP}/. /build/webfiles/ && \
    rm -rf ${REPOSITORY_NAME}

# Configure environment file
WORKDIR /build/webfiles
RUN sed -i '/^APP_ENV=/ s/=.*$/=production/' .env && \
    sed -i "/^APP_URL=/ s/=.*$/=https:\/\/${DOMAIN_NAME}\//" .env && \
    sed -i "/^DB_HOST=/ s/=.*$/=${RDS_ENDPOINT}/" .env && \
    sed -i "/^DB_DATABASE=/ s/=.*$/=${RDS_DB_NAME}/" .env && \
    sed -i "/^DB_USERNAME=/ s/=.*$/=${RDS_DB_USERNAME}/" .env && \
    sed -i "/^DB_PASSWORD=/ s/=.*$/=${RDS_DB_PASSWORD}/" .env

# ================================
# RUNTIME STAGE
# ================================
FROM amazonlinux:2 AS runtime

# Install only runtime dependencies
RUN yum update -y && \
    amazon-linux-extras enable php7.4 && \
    yum clean metadata && \
    yum install -y \
        httpd \
        php \
        php-common \
        php-pear \
        php-cgi \
        php-curl \
        php-mbstring \
        php-gd \
        php-mysqlnd \
        php-gettext \
        php-json \
        php-xml \
        php-fpm \
        php-intl \
        php-zip \
        wget && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install MySQL client (smaller footprint than full server)
RUN wget https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm && \
    rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 && \
    yum localinstall mysql80-community-release-el7-3.noarch.rpm -y && \
    yum install mysql-community-client -y && \
    yum clean all && \
    rm -rf /var/cache/yum mysql80-community-release-el7-3.noarch.rpm

# Set working directory
WORKDIR /var/www/html

# Copy web files from build stage
COPY --from=builder /build/webfiles/ /var/www/html/

# Copy AppServiceProvider from host (this needs to be in build context)
COPY AppServiceProvider.php app/Providers/AppServiceProvider.php

# Configure Apache
RUN sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

# Set proper permissions
RUN chmod -R 755 /var/www/html && \
    chmod -R 777 storage/ && \
    chown -R apache:apache /var/www/html

# Create a non-root user for better security
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Expose only necessary port (removed MySQL port since we're using external RDS)
EXPOSE 80

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start Apache in foreground
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
