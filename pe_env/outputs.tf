## Outputs

output "pe_server" {
    description = "This will return the entry for the /etc/hosts file to access the console"
    value       = join(" ", [aws_instance.pe-server[0].public_ip, aws_instance.pe-server[0].private_dns])
}

## This presumes we will always build 2 Linux nodes, expect an error if you build less

output "node1" {
    description = "node1"
    value       = join(" ", [aws_instance.linux_node[0].public_ip, aws_instance.linux_node[0].private_dns])
}

output "node2" {
    description = "node2"
    value       = join(" ", [aws_instance.linux_node[1].public_ip, aws_instance.linux_node[1].private_dns])
}