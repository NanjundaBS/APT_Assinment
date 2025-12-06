# One-Click ALB → ASG (private EC2) Terraform

Implements the Apt DevOps assignment: a public ALB in public subnets routing to an Auto Scaling Group of private EC2s (no public IPs) with NAT gateway for egress. App is a tiny Flask app on port 8080.

## Prereqs
- Terraform >= 1.0
- AWS CLI configured (credentials in env or ~/.aws/credentials)
- aws account and permission to create VPC/EC2/ALB/ASG/IAM/NAT/EIP

## Deploy (one command)
From repo root:
```bash
./scripts/deploy.sh
