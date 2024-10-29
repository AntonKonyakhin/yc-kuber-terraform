# id образа ubuntu 24.04
variable "image_id" {
  description = "image id"
  type = string
  default = "fd8k2ed4jspu35gfde1u"
}

# тип виртуальной машины: прерываемая или нет
variable "interruptable" {
  description = "type of vm"
  type = string
  default = false
}

variable "fract_cpu" {
  description = "type cpu of vm"
  type = number
  default = 100
}

# почта для получения сертификата
variable "email" {
  description = "letsencrypt_email"
  type =  string
  default = "a.konyakhin@gmail.com"
}
