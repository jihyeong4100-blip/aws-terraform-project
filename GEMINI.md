# GEMINI.md - Project Context for AWS Terraform Project

## Project Overview

This project is an Infrastructure as Code (IaC) solution utilizing Terraform to automate the deployment of a scalable and observable infrastructure on Amazon Web Services (AWS). It is designed to provision essential AWS services, including a Virtual Private Cloud (VPC) with appropriate networking, EC2 instances configured with a Docker environment and integrated Amazon SSM and CloudWatch agents, an RDS MySQL database, an Elastic Container Registry (ECR) for Docker images, and a comprehensive CloudWatch Dashboard for real-time monitoring of deployed resources. The goal is to allow developers to focus on application development by providing a fully automated and pre-configured infrastructure.

## Building and Running

This project uses Terraform for infrastructure management.

### Prerequisites

*   **AWS CLI:** Must be installed and configured with appropriate credentials (`aws configure`).
*   **Terraform:** Must be installed on your local machine.
*   **SSH Key:** An SSH public key file named `jjh-key.pub` is required and must be located in the root directory of this project. This key is used for secure access to the EC2 instances.

### Execution Guide

1.  **Initialize Terraform:**
    Navigate to the project directory and initialize Terraform. This command downloads the necessary providers and modules.
    ```bash
    terraform init
    ```

2.  **Review Execution Plan:**
    Generate and review an execution plan to see the changes Terraform will make to your AWS infrastructure without applying them. You must provide a value for `db_password` as a variable.
    ```bash
    terraform plan -var="db_password=your_secure_password"
    ```
    **Note:** Replace `your_secure_password` with your desired secure password for the RDS database. You may also define this in a `terraform.tfvars` file.

3.  **Apply Infrastructure Changes:**
    Apply the planned changes to provision the AWS infrastructure. The `-auto-approve` flag bypasses the interactive confirmation prompt.
    ```bash
    terraform apply -var="db_password=your_secure_password" -auto-approve
    ```
    **Note:** Again, replace `your_secure_password` with your database password.

4.  **Destroy Infrastructure (Use with Caution):**
    To de-provision all resources created by this Terraform configuration, use the destroy command.
    ```bash
    terraform destroy -var="db_password=your_secure_password" -auto-approve
    ```
    **Warning:** This command will permanently delete all resources provisioned by this project.

### Outputs

After `terraform apply`, the following outputs will be available:
*   `public_ip`: The public IP address of the deployed EC2 instance.
*   `ssh_command`: An example SSH command to connect to the EC2 instance.
*   `instance_id`: The ID of the EC2 instance.
*   `ecr_repository_url`: The URL of the ECR repository.
*   `rds_endpoint`: The endpoint for the RDS MySQL database.

## Development Conventions

*   **Infrastructure as Code (IaC):** The project strictly adheres to IaC principles, managing all AWS infrastructure components through Terraform configuration files. This ensures reproducibility, version control, and streamlined changes.
*   **Centralized Configuration:** All infrastructure resources are currently defined within a single `main.tf` file. For larger or more complex projects, it is a common practice to modularize Terraform code into separate files (e.g., `vpc.tf`, `ec2.tf`, `rds.tf`) or even separate modules.
*   **Resource Naming:** Resources and tags follow a consistent naming convention, often prefixed with `jjh-` (e.g., `jjh-vpc`, `jjh-ec2-sg`, `jjh-db`), aiding in resource identification and organization within AWS.
*   **Automated EC2 Setup:** EC2 instances leverage `user_data` scripts to automatically install and configure essential software (Docker, Docker Compose, AWS CLI v2, Amazon SSM Agent, CloudWatch Agent) upon launch, preparing them for application deployment and enabling enhanced monitoring and remote management.
*   **Least Privilege IAM:** AWS IAM roles are defined and attached to resources (e.g., EC2 instances) with policies that grant only the necessary permissions (e.g., for SSM, ECR, CloudWatch), adhering to the principle of least privilege for security.
*   **Network Security:** Granular security groups are implemented for different service types (EC2, RDS) to control inbound and outbound network traffic, enhancing the security posture of the infrastructure.
*   **Integrated Monitoring:** A CloudWatch Dashboard is pre-configured within the Terraform deployment to provide immediate, visual insights into the operational status and performance metrics (CPU, Memory, Database connections) of the EC2 and RDS instances.
