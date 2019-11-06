provider "google" {
  credentials = "${file("~/key.json")}"
  region      = "${var.region}"
  project     = "${var.project}"
  zone        = "${var.zone}"
}
