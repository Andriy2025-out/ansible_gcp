# Ansible Nginx Configuration with Terraform on GCP

This project automates the setup of Nginx web servers on Google Cloud Platform (GCP) using Terraform and Ansible. It supports both Debian and RHEL-based systems.

## Features
- Creates Debian and RHEL VMs on GCP using Terraform.
- Sets up Nginx on both Debian and RHEL-based VMs using Ansible.
- Configures Nginx to serve an index page with machine details and neighbor links.
- Automatically handles differences in configuration paths between Debian and RHEL.
- Enables Nginx to start on boot and ensures the service is running.

## Prerequisites
- Terraform (>= 1.0)
- Ansible (>= 2.9)
- GCP account with necessary permissions
- SSH keys configured for OS Login

## Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/nginx-gcp-setup.git
   cd nginx-gcp-setup
   ```
2. Configure your GCP credentials and set the required variables in `terraform.tfvars`.

## Usage
### Deploy Infrastructure with Terraform
```bash
terraform init
terraform apply -auto-approve
```

### Run Ansible Playbook
```bash
ansible-playbook -i inventory.ini playbook.yml
```

## Verifying Deployment
1. Access the public IP of each VM in your browser:
   - Debian VM: `http://<debian-vm-ip>`
   - RHEL VM: `http://<rhel-vm-ip>`
2. The index page should display machine details, IP address, and neighbor links.

## Troubleshooting
- Use the following command to check Nginx status:
  ```bash
  sudo systemctl status nginx
  ```
- To check the configuration:
  ```bash
  nginx -t
  ```

## Cleaning Up
To remove all resources, run:
```bash
terraform destroy -auto-approve
```
