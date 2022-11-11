## Outputs

output "pe_server_ip" {
    value = aws_eip.one.public_ip 
}

output "pe_server_hostname" {
    value = aws_eip.one.private_dns
}

