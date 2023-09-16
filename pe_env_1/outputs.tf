## Outputs

output "pe_server_hostname" {
  value = join(" ", [aws_eip.one.public_ip, aws_eip.one.private_dns])
}
