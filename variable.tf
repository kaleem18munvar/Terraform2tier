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
  default = "AKIA4JQ4B57YR6LVZXWH"
}

variable "secret_key" {
  description = "aws secret key"
  type = string
  default = "5APeA9l7qB5pfRIlJK8q/EgUnRuk0ZaRA1YDPDMK"
}