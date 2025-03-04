variable "bucket_name" {
  description = "The name of the S3 bucket"
  nullable    = false
  type        = string
}

variable "enable_versioning" {
  description = "Flag to enable or disable versioning"
  nullable    = false
  type        = bool
  default     = false
}

variable "enable_access_logs" {
  description = "Flag to enable or disable access logs"
  nullable    = false
  type        = bool
  default     = false
}
