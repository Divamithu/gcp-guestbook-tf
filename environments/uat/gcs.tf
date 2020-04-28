terraform {
  backend "gcs" {
    bucket  = "barcamp2019-states"
    prefix  = "terraform/uat"
    credentials = "account.json"
  }
}
