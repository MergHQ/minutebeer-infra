resource "google_sql_database_instance" "master" {
  name = "minutebeer-master-instance"
  database_version = "POSTGRES_9_6"
  region = "${var.region}"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "user" {
  name     = "root"
  instance = "${google_sql_database_instance.master.name}"
  password = "${var.db-password}"
}

output "database_user" {
  value = "${google_sql_user.user.name}"
}

output "database_password" {
  value = "${google_sql_user.user.password}"
  sensitive = true
}

output "database_host" {
  value = "${google_sql_database_instance.master.self_link}"
}

