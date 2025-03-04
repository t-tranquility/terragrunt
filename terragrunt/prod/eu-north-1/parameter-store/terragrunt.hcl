include "root" {
  path = find_in_parent_folders()
  expose = true
}

dependency "s3_media" {
  config_path = "../../../dev/eu-north-1/s3_media"
}

terraform {
  source = "../../../../terraform/modules/parameter-store"
}

inputs = {
  parameters = {
    s3_media = dependency.s3_media.outputs.bucket_id
  }
}