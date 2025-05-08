## Outputs

output "portainer" {
    description = "portainer"
    value       = join(" ", [aws_instance.docker_server[0].public_ip, aws_instance.docker_server[0].private_dns])
}

output "pe_server" {
    description = "pe_server"
    value       = join(" ", [aws_instance.pe_server[0].public_ip, aws_instance.pe_server[0].private_dns])
}