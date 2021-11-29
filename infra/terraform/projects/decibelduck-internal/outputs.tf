output "database_info" {
  sensitive = true
  value = {
    host     = module.decibelduck-internal.instance_public_ip_address
    user     = module.decibelduck-internal.user_name
    password = module.decibelduck-internal.user_password
    psql  = "postgres://${module.decibelduck-internal.user_name}:${module.decibelduck-internal.user_password}@${module.decibelduck-internal.instance_public_ip_address}/postgres"
  }
}

output "env" {
  sensitive = true
  value     = "PGDATABASE = \nPGHOST = ${module.decibelduck-internal.instance_public_ip_address}\nPGUSER = ${module.decibelduck-internal.user_name}\nPGPASSWORD = ${module.decibelduck-internal.user_password}\n"
}
