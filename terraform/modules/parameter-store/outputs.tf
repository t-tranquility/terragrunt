output "parameter_arns" {
  value = { for p in aws_ssm_parameter.this : p.name => p.arn }
}
