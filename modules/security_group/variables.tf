# variable "cidr_tgw" {
#   type = string
# }

variable "cidr_vpc" {
  type = string

}
  

variable "vpc_id" {
    type = string
  
}
variable "sg_name" {
  type = string
  
}

variable "port" {
  type = number
  default = "5432"
    
}

variable "protocol" {
  type = string
  default = "tcp"
  
}

