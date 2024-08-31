# Infrastructure Deployment with Terraform

This repository contains the Infrastructure as Code (IaC) necessary to deploy a Spring Boot application on Google Cloud Platform (GCP). The deployment process includes the following:

- **Terraform Cloud**: Manages the infrastructure.
- **GitHub Actions**: Automates the deployment process.
- **Secret Management**: Secrets are handled using Terraform Cloud variables and GitHub secrets.

For production environments, advanced secret management solutions like HashiCorp Vault, CyberArk Conjur, Google Secret Manager can be used.

### Deployment Workflow

- **Terraform Cloud** is used for managing the infrastructure.
- **GitHub Actions** automates deployment.
- **Apply** operations are triggered only on pushes to the `main` branch.
- **Outputs**: 
  - Public IP of the Compute Engine instance.
  - Private IP of the Cloud SQL instance.

### Infrastructure Components

1. **VPC Network**
   - **Name**: `abc-vpc-network`
   - A custom VPC network for connecting resources within GCP.

2. **Subnetwork**
   - **Name**: `abc-subnetwork`
   - **IP Range**: `10.0.1.0/24`
   - A subnetwork within the VPC network, providing IP addresses for resources.

3. **Cloud SQL Instance**
   - **Name**: `abc-sql-instance`
   - **Database**: MySQL 8.0, with private IP access within the VPC.
   - **Region**: Defined by `var.region`.

4. **Cloud SQL User**
   - **Name**: Defined by `var.db_user`.
   - **Instance**: `abc-sql-instance`
   - A user is created for the MySQL instance.

5. **Firewall Rule**
   - **Name**: `allow-ssh`
   - Allows SSH access (TCP port 22) from any IP address to instances tagged with `http-server`.

6. **Compute Engine Instance**
   - **Name**: `springboot-app`
   - **Type**: `e2-micro`, running Ubuntu 20.04 LTS.
   - **Network**: Uses the VPC and subnetwork, with an ephemeral public IP.
   - **Tags**: `http-server`

7. **Service Account**
   - **Name**: `abc-service-account`
   - A custom service account for the Compute Engine instance with Cloud Platform access.

This setup provisions a Spring Boot application on a VM instance and a private MySQL Cloud SQL instance, all connected through a custom VPC network.
