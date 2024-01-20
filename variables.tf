variable "apigw_name" {
  default = "apigw1"
  type = string
}

variable "apigw_description" {
  default = "api gw description"
  type = string
}
variable "openapi_filename" {
  default = "finapp.json"
  type = string
}
variable "get_integration_type" {
  type = string
  default = "AWS"
}
variable "post_integration_type" {
  type = string
  default = "AWS"
}

variable "endpoint_configuration_types" {
  default = ["REGIONAL"]
  type=list(string)
}

variable "stage_name"{
  type = string
  default = "dev"
}

variable "cw_log_name" {
  default = "apigw1"

}