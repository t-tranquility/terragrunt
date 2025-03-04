resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name   = each.key
  type   = "SecureString"
  key_id = "alias/aws/ssm"
  value  = each.value
}
