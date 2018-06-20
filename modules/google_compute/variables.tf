// Google Cloud variables
variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-b"
}

variable "machine_type" {
  description = "In the form of custom-CPUS-MEM, number of CPUs and memory for custom machine. https://cloud.google.com/compute/docs/instances/creating-instance-with-custom-machine-type#specifications"
  default     = "custom-6-65536-ext"
}

variable "name" {
  description = "Name prefix for the nodes"
  default     = "jira"
}

variable "image_family" {
  default = "debian-8"
}

variable "image_project" {
  default = "debian-cloud"
}

variable "disk_type" {
  description = "The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard."
  default     = "pd-ssd"
}

variable "min_cpu_platform" {
  description = "Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms, such as Intel Haswell or Intel Skylake. https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform"
  default     = "Automatic"
}

variable "disk_size_gb" {
  description = "The size of the image in gigabytes."
  default     = 10
}

variable "service_account_email" {
  description = "The email of the service account for the instance template."
  default     = ""
}

variable "service_account_scopes" {
  description = "List of scopes for the instance template service account"
  type        = "list"

  default = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/devstorage.full_control",
  ]
}

// network informations
variable "network_cidr" {
  default = "10.127.0.0/20"
}

variable "network_name" {
  default = "tf-jira-network"
}

variable "ssh_source" {
  default = "0.0.0.0/0"
}


