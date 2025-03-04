variable "parameters" {
  description = "Map of parameters in SSM Parameter Store"
  nullable    = false
  type        = map(string)
}

