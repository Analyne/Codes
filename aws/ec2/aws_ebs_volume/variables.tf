# -- resouce count argument, count argument has to be specified within the resouce not the module.

variable "instance_count" {
  description = "The number of instanses to iterate through, if 0 and az is provided it will just create one."
  type        = number
  default     = 0
}