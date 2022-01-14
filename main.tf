// Configure the Google Cloud provider
provider "google" {
 credentials = file("terraform-338212-6a8757c53c45.json")
 project     = "terraform-338212"
 region      = "us-west1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "flask-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }

 metadata = {
   ssh-keys = "gabrielrosadias:${file("~/.ssh/instace_gcp.pub")}"
 }

 
}

resource "google_compute_firewall" "default" {
 name    = "flask-app-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["5000"]
 }
 source_tags = ["mynetwork"]
}

// A variable for extracting the external IP address of the instance
output "ip" {
 value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

/* resource "google_storage_bucket" "tf-bucket" {
  #project       = var.gcp_project
  name          = "backend_bucket"
  location      = "US"
  force_destroy = true
  #storage_class = var.storage-class
  versioning {
    enabled = true
  }
} */

