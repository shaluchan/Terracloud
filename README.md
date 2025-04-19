# Terracloud - Modular VPC Setup with Terraform

This project helps you spin up a modular and production-ready VPC infrastructure using **Terraform**. The setup includes networking components, compute resources, IAM roles, bastion hosts, a load balancer, a transit gateway, and an HTML-based web app.

---

## 🧱 Modules & Components

This repo is structured using modular Terraform code and includes:

- `app_vpc.tf` - Application VPC resources  
- `bastion_vpc.tf` - Bastion VPC for secure access  
- `bucket.tf` - S3 bucket module  
- `ec2.tf` - EC2 instance module  
- `golden_ami.tf` - AMI generation using Packer-style golden image  
- `IAM_role.tf` - IAM roles for EC2 and services  
- `load_balancer.tf` - Load balancer module  
- `nat.tf` - NAT gateway configuration  
- `sg.tf` - Security groups  
- `ssh_keys.tf` - SSH key pair generation  
- `transit_gateway.tf` - Transit gateway config  
- `upload.tf` - Upload related configurations (likely for S3 or EC2)  
- `html-web-app/` - Sample frontend for deployment

---

## 🚀 Getting Started

### 🔧 Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0  
- AWS CLI configured (`aws configure`)  
- An AWS account with permissions to create infrastructure  

---

## 🗂️ Folder Structure

```bash
.
├── html-web-app/
├── IAM_role.tf
├── app_vpc.tf
├── bastion_vpc.tf
├── bucket.tf
├── ec2.tf
├── golden_ami.tf
├── load_balancer.tf
├── nat.tf
├── sg.tf
├── ssh_keys.tf
├── transit_gateway.tf
├── upload.tf
└── README.md

```
## ⚙️ How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/shaluchan/Terracloud.git
cd Terracloud
```
### 2. Initialize Terraform

```bash
terraform init
```
### 3. Preview the Plan

```bash
terraform plan
```
### 4. Apply the Infrastructure
```bash
terraform apply
```
Confirm with yes when prompted.

## 🧹 Tear Down
To destroy all created resources:
```bash
terraform destroy
```
## 🧠 Learn More

This project is a great foundation for:

Multi-tier architecture deployments

Golden AMI pipeline practice

Load-balanced apps on AWS

Exploring Terraform modules and infrastructure as code (IaC)

## 🧑‍💻 Author
Built with ❤️ by Shalu

## 📜 License
This project is licensed under the MIT License. See the LICENSE file for details.




