# Output public IP of VM Instance
output "vm_public_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

# Output private IP of Cloud SQL Instance
output "sql_private_ip" {
  value = google_sql_database_instance.db_instance.private_ip_address
}