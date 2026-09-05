variable "lb_name" {
  type        = string
  description = "Name of the Load Balancer"
}

variable "lb_type" {
  type        = string
  description = "Type of the Load Balancer (application, network or gateway)"
  default     = "application"

  validation {
    condition     = contains(["application", "network", "gateway"], var.lb_type)
    error_message = "lb_type must be either 'application', 'network' or 'gateway'"
  }
}

variable "is_internal" {
  type        = bool
  description = "Define if the Load Balancer is public or private"
  default     = false
}

variable "subnets_ids" {
  type        = list(string)
  description = "List of subnet IDs where the Load Balancer will be deployed"
}

# --- Listener Variables ---
variable "listener_port" {
  type        = number
  description = "Port for the Load Balancer listener"
  default     = 80
}

variable "listener_protocol" {
  type        = string
  description = "Protocol for the Load Balancer listener"
  default     = "HTTP"
}

# --- Common Variables ---
variable "tags" {
  type        = map(string)
  description = "General tags for the deployed resources"
  default     = {}
}
