variable "domain" {
  description = "The full name of the domain, ex. mydomain.example.com"
}

variable "fqdd" {
  description = "The FQDD for the domain (used with hosted zone), ex. domain.com"
}

variable "certificate_domain" {
  description = "The domain name the certificate war created under, ex. *.example.com"
}
