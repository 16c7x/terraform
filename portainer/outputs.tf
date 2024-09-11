## Outputs

output "portainer" {
    description = "portainer"
    value       = join(" ", [aws_instance.linux_node[0].public_ip, aws_instance.linux_node[0].private_dns])
}
