variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "name" {
  type = string
  description = "The name of the Cloud9 environment"
}

variable "automatic_stop_time_minutes" {
  type = number
  description = "Minutes until the instance is shut down after inactivity"
  default = 60
}

variable "owner_arn" {
  type = string
  description = "The IAM principal for the environment"
}

variable "subnet_id" {
  type = string
  description = "The subnet to place the Cloud9 instance in"
}

variable "tags" {
  type = map(string)
  default = {}
}
