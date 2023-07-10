variable "no_of_instances" {
  type        = number
  description = "The number of instances to be created."
}
variable "name_of_instances" {
  type        = list(string)
  description = "The name of instances to be created."
}
variable "zone" {
  type        = string
  description = "The zone of the VM."
}
variable "project" {
  type        = string
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}
variable "mi_self_link" {
  type        = string
  description = "Self link of the machine image from which we create the VMs."
}
variable "allow_stopping_for_update" {
  type        = bool
}
variable "enable_oslogin" {
  type        = string
}
variable "is_os_linux" {
  type        = bool
  description = "Executes different metadata scripts on this basis."
}
variable "create_service_account" {
  type        = bool
  description = "Create service account for the compute instance"
  default     = false
}
variable "address_type" {
  type        = string
  description = "The type of address to reserve. Default value is EXTERNAL. Possible values are INTERNAL and EXTERNAL"
}
variable "address" {
  type        = string
  description = "The private ip of the compute-instance"
  default      = ""
}
variable "compute_address_region" {
  type        = string
  description = "The region that the compute address should be created in. If it is not provided, the provider zone is used."
}
variable "compute_address_project" {
  type        = string
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}
variable "subnetwork" {
  type        = string
  description = "The name or self_link of the subnetwork to attach this interface to. Either network or subnetwork must be provided."
}

variable "min_cpu_platform" {
  type        = string
  description = "Intel Skylake or Intel Haswell"
}
variable "enable_nested_virtualization" {
  type        = bool
  description = "enable_nested_virtualization"
}
variable "threads_per_core" {
  type        = number
  description = "the number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1"
}
# variable "enable_secure_boot" {
#   type        = bool
# }

# variable "enable_integrity_monitoring" {
#   type        = bool
# }