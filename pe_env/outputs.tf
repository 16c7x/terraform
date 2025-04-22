## Outputs
output "hosts_file_entries" {
  description = "Entries to paste into /etc/hosts"
  value = join("\n", [
    join(" ", [aws_instance.linux_node[0].public_ip, aws_instance.linux_node[0].private_dns, "node2"]),
    join(" ", [aws_instance.linux_node[1].public_ip, aws_instance.linux_node[1].private_dns, "node1"]),
    join(" ", [aws_instance.pe-server[0].public_ip, aws_instance.pe-server[0].private_dns, "pe"])
  ])
}