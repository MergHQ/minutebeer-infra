variable "username" {
  default = "admin"
}
variable "password" {}

variable "project" {
  type    = "string"
  default = "double-fusion-258215"
}

variable "db-password" {}
variable "github-sha" {}
variable "jwt-secret" {}


module "gcp" {
  source      = "./gcp"
  region      = "europe-north1"
  project     = "${var.project}"
  zone        = "europe-north1-a"
  username    = "${var.username}"
  password    = "${var.password}"
  db-password = "${var.db-password}"
}

 module "k8s" {
  source   = "./k8s"
  host     = "${module.gcp.host}"
  username = "${var.username}"
  password = "${var.password}"

  client_certificate     = "${module.gcp.client_certificate}"
  client_key             = "${module.gcp.client_key}"
  cluster_ca_certificate = "${module.gcp.cluster_ca_certificate}"
  database_user          = "${module.gcp.database_user}"
  database_host          = "${module.gcp.database_host}"
  database_password      = "${module.gcp.database_password}"
  jwt-secret             = "${var.jwt-secret}"
  github-sha             = "${var.github-sha}"
}
