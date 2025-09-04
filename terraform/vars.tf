variable "resource_group_name" {
    type = string
    default = "k8s_rg2"
}

variable "frontend_image_tag" {
    type = string
}

variable "backend_image_tag" {
    type = string
}

variable "cr_username" {
    type = string
    sensitive = true
}

variable "cr_password" {
    type = string
    sensitive = true
}