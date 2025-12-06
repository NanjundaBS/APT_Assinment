data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { 
        type = "Service" 
        identifiers = ["ec2.amazonaws.com"] 
        }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.project}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
  tags = { Name = "${var.project}-ec2-role" }
}

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ssm:UpdateInstanceInformation",
      "ssm:DescribeInstanceInformation",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:DescribeInstanceProperties",
      "ec2:DescribeInstances",
      "ec2:DescribeTags"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ec2_policy_attach" {
  name   = "${var.project}-ec2-policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2_policy.json
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project}-instance-profile"
  role = aws_iam_role.ec2_role.name
}

output "instance_profile_name" { value = aws_iam_instance_profile.ec2_profile.name }
