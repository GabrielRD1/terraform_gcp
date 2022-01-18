// Configure the Google Cloud provider
/* provider "google" {
 credentials = file("terraform-338212-6a8757c53c45.json")
 project     = "terraform-338212"
 region      = "us-west1"
} */

/* terraform {
  backend "remote" {
    bucket      = "backend_bucket"
    prefix      = "backend"
    credentials = "terraform-338212-6a8757c53c45.json"
  }
} */

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "grd"
    workspaces {
      name = "teste"
    }
  }
}
