output "user_name" {
    value = module.ducky-user.name
}

output "user_password" {
    value = module.ducky-user.password
}

output "instance_public_ip_address" {
    value = module.dev-instance.public_ip_address
}
