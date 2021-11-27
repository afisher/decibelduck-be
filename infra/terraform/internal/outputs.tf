output "database_info" {
  sensitive = true
  value = {
    host     = module.dev-instance.public_ip_address
    user     = module.ducky-user.name
    password = module.ducky-user.password
    connect  = "postgres://${module.ducky-user.name}:${module.ducky-user.password}@${module.dev-instance.public_ip_address}/postgres"
  }
}

output "env" {
  sensitive = true
  value     = "PGDATABASE = \nPGHOST = ${module.dev-instance.public_ip_address}\nPGUSER = ${module.ducky-user.name}\nPGPASSWORD = ${module.ducky-user.password}\n"
}