output "ide_url" {
  value = "https://${data.aws_region.current.name}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.environment.id}"
}

output "id" {
  value = aws_cloud9_environment_ec2.environment.id
}

output "arn" {
  value = aws_cloud9_environment_ec2.environment.arn
}

output "type" {
  value = aws_cloud9_environment_ec2.environment.type
}
