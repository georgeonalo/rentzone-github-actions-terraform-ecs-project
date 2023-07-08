# Rentzone GitHub Actions Terraform ECS Project

In this cap stone project, i deployed a dynamic car rental web application called Rentzone in AWS using CI/CD pipelines and GitHub Actions.


## Project reference architecture

![GitHub Action CI_CD project](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/08ca2709-f24d-4ec4-b69a-f659eaceb53c)



## Summary of Jobs built in my pipeline to complete this project.

A Build is triggered in my pipeline when a git commit is pushed into my github repository, and below are the different jobs that is build in the pipeline.

**(1)** **Configure AWS credentials;** The first job configure AWS credentials for GitHub Actions to access and create resources in my AWS account.

**(2)** **Build AWS infrastructure with terraform;** The second job deploys infrastructure in AWS using Terraform and creates a VPC with public and private subnets, internet gateway, security groups, nat gateways, application load balancer, Rds instance, IAM role, S3 bucket, Record set in Route 
53, Request and ssl certificate to encrypt data in transit, ECS cluster, ECS task defination and ECS service in auto scaling 
groups.
  
**(3)** **Start self-hosted EC2 runner;** After building the infrastructure in AWS, the next job in my pipeline  starts a self-hosted runner and **Create an Amazon ECR
repository** to store the docker image for my application
 
**(4)** **Build and push Docker image into ECR;** The fourth job setup Docker on the self-hosted runner and build the image for my application and push the image to the Amazon ECR repository
  
**(5)** **Create environment file and export to s3;** The next job will export environment variables for the fargate containers into a file and copy the file into the s3 bucket
  
**(6)** **Migrate data into RDS database with Flyway;** Parallel to the Job above, another job will use flyway to migrate the sql script for the application into Rds database

**(7)** **Stop self-hosted EC2 runner;** The next job terminates the self-hosted runner.
  
**(8)** **Create new task definition revision;** The eight job creates a new ECS task defination revison
   
**(9)** **Restart ECS Fargate service;** The last job in the pipeline uses the new revision of the ECS task defination to update the ECS service making the application available to end users



  
### This project covers all the crucial skills and experiences required by a Cloud/DevOps Engineer.

### In this project, i demonsrated my proficiency in:

1. Deploying dynamic web applications in AWS using CI/CD pipelines and GitHub Actions
2. Utilizing core AWS services such as;
   - VPC with public and private subnets
   - Internet Gateway
   - Security Groups
   - Nat Gateway
   - Application Load Balancer
   - ECS Fargate
   - ECR
   - Route 53
   - Auto Scaling Groups and more.

3. Containerizing applications with Docker and pushing the image to registries like Amazon ECR.
   
4. Building applications in AWS using infrastrucure as code tools like, TERRAFORM.
 
5. Migrating data for dynamic applications into RDS with tools like Flyway.
 
6. And finally, this project showcases my ability to secure and manage secrets with credential management tools like;
   - AWS secrete manager and
   - GitHub Actions repository secrets.



#### In summary, this project highlights my expertise with cloud service providers like: AWS and my familiarity with DevOps tools and processes such as;
- CI/CD pipelines
- GitHub Actions
- Linux
- Terraform
- Docker
- Git
- GitHub
- Bash Scripting
- AWS CLI
- Flyway
- and Visual Studio Code





  

## Below are screenshots of some of the infrastructure deployed by my pipeline



![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/9251ee38-b1cc-4a45-89d0-6f784924403f)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/e6d95e25-4b76-419c-9e58-60fd10bc01eb)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/740554ff-5073-4a08-8088-5fbe335326ac)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/4141057c-1755-4dae-b145-c423309ac750)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/ff18f126-ca0e-42ba-9896-a11ae3ebe31f)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/0e4e30dd-ded5-4f9c-a278-5314dbcb0cc5)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/f6576c11-aae7-4874-8e35-b828d73cfd1f)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/81730d45-c922-40f5-b0f4-67a87770721f)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/1edceb4a-d046-4103-8d61-f1977311b41e)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/3b765b40-b636-402b-8221-a02277ee56db)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/2ad1bb7b-7221-428f-909a-a21413cecfed)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/ae9ae877-53ee-47e6-9f77-d99c6b7d30a5)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/ef4576b9-02e8-420e-9273-c55e4f175ff8)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/7dd021e2-bdb9-4bfb-a456-0195bec1989b)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/04f51f7e-154a-482c-9b15-86cfb9bfd8f5)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/36be4bce-048b-47a7-bc69-7a10bed06bbb)

![image](https://github.com/georgeonalo/rentzone-github-actions-terraform-ecs-project/assets/115881685/6822e464-39b8-4ab7-9950-b6be5e48ad5a)




   

Repository for GitHub Actions Project
