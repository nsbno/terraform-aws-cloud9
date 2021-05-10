data "aws_region" "current" {}

resource "aws_cloud9_environment_ec2" "environment" {
  name = var.name
  instance_type = var.instance_type
  owner_arn = var.owner_arn
  subnet_id = var.subnet_id
  tags = var.tags
}
