variable "aws_account_id" {
  type        = string
  description = "AWS Account ID"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "AWS Account ID"
  default     = "thrive-eks"
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket for Terraform state"
  default     = "tf-backend-19561"
}

variable "s3_key" {
  type        = string
  description = "S3 key for Terraform state file"
  default     = "thrive/terrafrom.tfstate"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "thrive-take-home"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cluster_service_cidr" {
  type        = string
  description = "CIDR for Kubernetes Service IPs"
  default     = "172.20.0.0/16"
}

variable "az_count" {
  type    = number
  default = 2
}

variable "github_owner" {
  type        = string
  description = "GitHub org/user"
  default     = "Future-Jim"
}

variable "github_repo" {
  type        = string
  description = "Repo name"
  default     = "thrive-take-home"
}

variable "branch" {
  type    = string
  default = "main"
}

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "desired_size" {
  type    = number
  default = 1
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 3
}

variable "git_repo_url" {
  type    = string
  default = null
}