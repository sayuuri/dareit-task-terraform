resource "google_compute_instance" "dareit-vm-sr-1" {
  name         = "dareit-vm-tf-sr-1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"


  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
resource "google_storage_bucket" "dareit-bucket-sr-1" {
 project       = "crucial-inn-377821"
 name          = "dareit-bucket-tf-sr-1"
 location      = "US"
 storage_class = "STANDARD"

uniform_bucket_level_access = false

force_destroy = true
  public {
  main_page_suffix = "index.html"
  }
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
}
}

resource "google_storage_bucket_object" "dareit-bucket-sr-src-1" {
  name   = "index.html"
  source = "public/index.html"
  bucket = google_storage_bucket.dareit-bucket-sr-1.name
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.dareit-bucket-sr-1.id
  role   = "READER"
  entity = "allUsers"

}

resource "google_storage_bucket_object" "dareit-bucket-sr-src-2" {
  name   = "picture.jpg"
  source = "images/picture.jpg"
  bucket = google_storage_bucket.dareit-bucket-sr-1.name
}

resource "google_storage_bucket" "dareit-bucket-sr-2" {
 project       = "crucial-inn-377821"
 name          = "dareit-bucket-tf-sr-2"
 location      = "US"
 storage_class = "STANDARD"

uniform_bucket_level_access = false
}

resource "google_storage_bucket_access_control" "public_rule_2" {
  bucket = google_storage_bucket.dareit-bucket-sr-2.id
  role   = "READER"
  entity = "allUsers"

}