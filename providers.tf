terraform { 
  cloud { 
    
    organization = "bsw" 

    workspaces { 
      name = "test" 
    } 
  } 
}
provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.region
  credentials = var.GCP_SA_KEY
}