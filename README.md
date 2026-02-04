# AWS EC2 Infrastructure for Strapi CMS

This repository contains a modular Terraform configuration to automate the provisioning of an AWS EC2 instance and the installation of Strapi CMS.

## Project Structure
The project follows a modular approach to ensure reusability and clean code.

- **Root Directory**: Contains the provider configuration and calls the modules.
- **Modules/EC2 instance**: Contains the core logic for instance creation, security groups, and key management.

## Features
- **Automated Key Management**: Uses the `tls_private_key` resource to generate a private RSA key and saves it as a `.pem` file locally.
- **Security Group**: Configured to allow SSH (Port 22) and Strapi Dashboard (Port 1337) traffic.
- **Automated Deployment**: Uses EC2 `user_data` to install Node.js and initialize a Strapi project upon instance launch.
- **Modular Design**: Separates concerns using Terraform modules for better scalability.

## Prerequisites
- Terraform installed locally.
- AWS CLI configured with valid credentials.
