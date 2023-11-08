## Outputs

output "pe_server" {
    description = "This will return the entry for the /etc/hosts file to access the console"
    value       = join(" ", [aws_instance.pe-server[0].public_ip, aws_instance.pe-server[0].private_dns])
}