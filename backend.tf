// Configure the Google Cloud provider
/* provider "google" {
 credentials = file("terraform-338212-6a8757c53c45.json")
 project     = "terraform-338212"
 region      = "us-west1"
} */

terraform {
  backend "gcs" {
    bucket      = "backend_bucket"
    prefix      = "backend"
    credentials = "terraform-338212-6a8757c53c45.json"
  }
}
