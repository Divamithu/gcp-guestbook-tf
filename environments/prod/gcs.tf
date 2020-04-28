terraform {
  backend "gcs" {
    bucket  = "barcamp2019-states"
    prefix  = "terraform/prod"
    credentials = "account.json"
  }
}
