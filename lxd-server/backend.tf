terraform {
  backend "s3" {
    bucket = "remote-states"
    key    = "lxd-server/terraform.tfstate"
    region = "main"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}