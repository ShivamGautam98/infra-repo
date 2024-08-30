variable "GCP_PROJECT_ID" {
  type = string
}

variable "GCP_SA_KEY" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-c"
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}
variable "ssh_key" {
  type = string
}

variable "project" {
  type = string
  default = "celtic-music-434007-r1"
}
