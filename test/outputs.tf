## Outputs

output "node0" {
    description = "node0"
    value       = join(" ", [aws_instance.linux_node[0].public_ip, aws_instance.linux_node[0].private_dns])
}

output "node1" {
    description = "node1"
    value       = join(" ", [aws_instance.linux_node[1].public_ip, aws_instance.linux_node[1].private_dns])
}

output "node2" {
    description = "node2"
    value       = join(" ", [aws_instance.linux_node[2].public_ip, aws_instance.linux_node[2].private_dns])
}