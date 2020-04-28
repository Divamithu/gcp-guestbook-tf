resource "google_storage_bucket" "image-store" {
  name     = "${var.bucket_name}"
  location = "${var.bucket_location}"
  storage_class = "${var.bucket_storage_class}"
  versioning {
    enabled = "${var.bucket_versioning}"
  }
}
