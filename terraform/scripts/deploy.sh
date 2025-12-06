#!/usr/bin/env bash
set -e
cd terraform
terraform init -input=false
terraform apply -auto-approve
