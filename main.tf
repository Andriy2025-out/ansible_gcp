provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Get the current user’s email address
data "google_client_openid_userinfo" "me" {}

# Upload the SSH public key to OS Login
resource "google_os_login_ssh_public_key" "default" {
  user = data.google_client_openid_userinfo.me.email
  key  = file("~/.ssh/gcp.pub")
}

# Debian-based VM
resource "google_compute_instance" "debian_vm" {
  name         = "debian-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  # Enable OS Login on the VM
  metadata = {
    enable-oslogin = "TRUE"
  }

  tags = ["http-server", "ssh-server"]
}

# RHEL-based VM
resource "google_compute_instance" "rhel_vm" {
  name         = "rhel-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-8"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  tags = ["http-server", "ssh-server"]
}

# Firewall rule for HTTP access
resource "google_compute_firewall" "http_firewall" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# Firewall rule for SSH access
resource "google_compute_firewall" "ssh_firewall" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-server"]
}

# Output IP addresses for Ansible inventory
output "debian_vm_ip" {
  value = google_compute_instance.debian_vm.network_interface[0].access_config[0].nat_ip
}

output "rhel_vm_ip" {
  value = google_compute_instance.rhel_vm.network_interface[0].access_config[0].nat_ip
}
