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


This runs terraform init and terraform apply -auto-approve. After completion the ALB DNS will be printed.

Test

Once deployed:

ALB=$(cd terraform && terraform output -raw alb_dns)
curl http://$ALB/        # should return 'hello from oneclick'
curl http://$ALB/health # should return 'ok'

Teardown
./scripts/destroy.sh

Notes & security

Instances have no public IPs and use a NAT Gateway for outbound internet.

Instances have an IAM role limited to CloudWatch Logs and SSM actions (no secrets).

SSH is not opened by default. Use SSM Session Manager if you need shell access.

The app runs on port 8080; ALB health check uses /health.

See terraform/modules/* for modular code.


---

# 10) Implementation notes & security considerations
- No secrets are hardcoded in Terraform files. If you need to pass secrets to app, use AWS Secrets Manager and appropriate IAM policies (not included here).
- For production, create multiple NAT gateways in different AZs and add more robust monitoring/ALB HTTPS with ACM certs.
- This code uses the Amazon Linux 2 AMI via a `data "aws_ami"` lookup so AMI ID is always current.
- Instances are registered with ALB target group via ASG and Launch Template; health checks hit `/health`.
- SSM is allowed via IAM policy; you can use Session Manager to connect without SSH.

---

# 11) Quick deploy checklist
1. Put all files in the tree above. Ensure `app/user-data.sh.tpl` path is correct relative to `terraform` (I used `file("${path.module}/../app/user-data.sh.tpl")` in root as example).
2. `cd terraform && terraform init` (deploy script does this).
3. `./scripts/deploy.sh`
4. Wait until apply finishes and then `curl` the ALB DNS root and `/health`.

---

If you want, I can:
- paste-ready zipped files (one-shot) or create a single `main.tf` monolithic file (you earlier asked for modular structure so I kept modules), or
- add HTTPS via ACM + listener redirect, or
- add CloudWatch Agent to ship logs to CloudWatch Logs (I already gave the IAM perms).

Tell me which extra feature to add (ACM/HTTPS, Route53 record, or CloudWatch log agent) and I’ll extend the Terraform modules in the same style. No filler — I’ll implement it directly.
