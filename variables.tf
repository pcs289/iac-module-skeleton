variable "instanceName" {
  description = "Name of the instance"
}

variable "instanceType" {
  description = "Instance Type"
  default = "t2.micro"
}

variable "diskSize" {
  description = "Volume Size"
  default = "8"
}

variable "diskType" {
  description = "Volume Type"
  default = "gp2"
}

variable "diskEncrypted" {
  description = "Volume Encrypted"
  default = true
}

variable "diskTermination" {
  description = "Volume Termination"
  default = true
}