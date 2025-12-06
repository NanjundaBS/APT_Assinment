#!/usr/bin/env bash
cd terraform
ALB=$(terraform output -raw alb_dns 2>/dev/null || true)
if [ -z "$ALB" ]; then
  echo "ALB dns not found from terraform outputs"
  exit 1
fi
echo "Testing /health"
curl -sS "http://$ALB/health" || true
echo ""
echo "Testing /"
curl -sS "http://$ALB/" || true
echo ""
