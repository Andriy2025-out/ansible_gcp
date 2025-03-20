# GCP Nginx Web Server Configuration with Terraform and Ansible

This project sets up Nginx web servers on Google Cloud Platform (GCP) using Terraform and Ansible. The infrastructure includes both Debian and RHEL-based virtual machines. Nginx is configured to serve a default web page and handle HTTP traffic. The configuration is managed through Ansible playbooks.

## Prerequisites
- GCP account and project
- Terraform installed
- Ansible installed
- SSH keys configured for GCP access
- Python 3.9

## Project Structure
```
├── terraform
│   ├── main.tf       # Terraform configuration
│   ├── variables.tf  # Terraform variables
├── ansible
│   ├── playbook.yml  # Ansible playbook for configuring Nginx
│   ├── templates
│       ├── index.html.j2  # HTML template for default page
│       ├── nginx-vhost.conf.j2  # Nginx virtual host configuration
├── README.md
```

## Usage
### Step 1: Clone the Repository
```
git clone https://github.com/username/gcp-nginx-webserver.git
cd gcp-nginx-webserver
```

### Step 2: Configure GCP Project and Terraform Variables
Update the `terraform/variables.tf` file with your GCP project details.

### Step 3: Deploy Infrastructure with Terraform
```
cd terraform
terraform init
terraform apply
```

### Step 4: Configure Nginx with Ansible
Update the Ansible inventory file with the IP addresses of the VMs:
```
[webservers]
debian-vm ansible_host=<debian-vm-ip> ansible_user=<username>
rhel-vm ansible_host=<rhel-vm-ip> ansible_user=<username>
```

Run the playbook:
```
ansible-playbook -i inventory playbook.yml
```

### Step 5: Test the Setup
Visit the IP addresses of the VMs in a browser:
```
http://<debian-vm-ip>
http://<rhel-vm-ip>
```

## Troubleshooting
- Ensure firewall rules are configured to allow HTTP and SSH traffic.
- Check the status of Nginx with:
  ```
sudo systemctl status nginx
  ```
- Inspect Nginx configuration with:
  ```
nginx -t
  ```

## Cleanup
To delete the resources, run:
```
cd terraform
terraform destroy
```
