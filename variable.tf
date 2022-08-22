# Database variables

variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "access_key" {
  description = "aws access key"
  type = string
}

variable "secret_key" {
  description = "aws secret key"
  type = string
}
