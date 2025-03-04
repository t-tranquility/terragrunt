include "root" {
  path = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../terraform/modules/s3"
}

inputs = {
  bucket_name_prefix = "${include.root.locals.account_vars.locals.account_name}-${include.root.locals.organization.name}-media"
  enable_versioning = false
  enable_access_logs = true
}