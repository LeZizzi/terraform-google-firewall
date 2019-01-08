variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    type        = "string"
    default     = ""
}

variable "vpc" {
    description = "Name of VPC"
    type        = "string"
}

/* Maps with all the configurations */
variable "egress" {
    description = "Configurtion for egress rules"
    type        = "map"
    default     = {}
}

variable "ingress" {
    description = "Configurtion for ingress rules"
    type        = "map"
    default     = {}
}