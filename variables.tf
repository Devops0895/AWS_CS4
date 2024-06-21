#218453391514
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "subnet_names" {
  type    = list(string)
  default = ["subnet-1", "subnet-2", "subnet-3"]
}

variable "instance_names" {
  type    = list(string)
  default = ["one", "two", "three"]
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "mybucket1995083"
  # Add any additional configuration options as needed
}
