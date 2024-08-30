# Create VPC Network
resource "google_compute_network" "vpc_network" {
  name = "abc-vpc-network"
}

# Create Subnetwork
resource "google_compute_subnetwork" "subnetwork" {
  name          = "abc-subnetwork"
  ip_cidr_range  = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

# Create Cloud SQL Instance with Private IP
resource "google_sql_database_instance" "db_instance" {
  name             = "abc-sql-instance"
  database_version = "MYSQL_8_0"
  region           = var.region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.self_link
    }
  }
}

# Create a user for the Cloud SQL instance
resource "google_sql_user" "db_user" {
  name     = var.db_user
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password            # Replace with your desired password
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 1000
  target_tags    = ["http-server"]
}


resource "google_compute_instance" "vm_instance" {
  name         = "springboot-app"
  machine_type = "e2-micro"
  zone         = var.zone
  allow_stopping_for_update = true
  deletion_protection = false
  tags = ["http-server"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    } 
  }
   network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
     access_config {
      // Ephemeral public IP will be automatically assigned
    }
  }
  service_account {
    email  = google_service_account.service_account.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# Create Service Account
resource "google_service_account" "service_account" {
  account_id   = "abc-service-account"
  display_name = "Service Account for Compute Engine"
}

