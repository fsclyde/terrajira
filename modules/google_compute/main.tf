  // Google cloud
data "google_project" "current" {}
data "google_compute_default_service_account" "default" {}

// Google cloud network
resource "google_compute_network" "default" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "default" {
  name                     = "${var.network_name}"
  ip_cidr_range            = "${var.network_cidr}"
  network                  = "${google_compute_network.default.self_link}"
  region                   = "${var.region}"
  private_ip_google_access = true
}

// Google compute instance
resource "google_compute_instance" "default" {
  name                      = "${var.name}"
  zone                      = "${var.zone}"
  machine_type              = "${var.machine_type}"
  min_cpu_platform          = "${var.min_cpu_platform}"
  allow_stopping_for_update = true

  tags = ["sde", "jira"]

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size  = "${var.disk_size_gb}"
      type  = "${var.disk_type}"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  // Install Jira Software
  metadata_startup_script = "${file("modules/google_compute/jira/userdata.sh")}"

  service_account {
    email  = "${var.service_account_email == "" ? data.google_compute_default_service_account.default.email : var.service_account_email }"
    scopes = ["${var.service_account_scopes}"]
  }

}

// google network Firewall
resource "google_compute_firewall" "ssh" {
  name    = "${var.name}-ssh"
  network = "${google_compute_subnetwork.default.name}"

  allow {
    protocol = "tcp"
    ports    = ["22","80","8080"]
  }

  source_ranges = ["${var.ssh_source}"]
  target_tags = ["${var.name}-ssh"]
}

output "public_ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.assigned_nat_ip}"
}
