/*resource "google_compute_ssl_certificate" "default" {
  name_prefix = "my-certificate-"
  description = "a description"
  private_key = file("path/to/private.key")
  certificate = file("path/to/certificate.crt")

  lifecycle {
    create_before_destroy = true
  }
}*/