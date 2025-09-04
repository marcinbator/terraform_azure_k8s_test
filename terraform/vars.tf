variable "resource_group_name" {
    type = string
    default = "k8s_rg"
}

variable "frontend_image_tag" {
    type = string
}

variable "backend_image_tag" {
    type = string
}