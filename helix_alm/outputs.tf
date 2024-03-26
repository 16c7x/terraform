## Outputs

output "node0" {
    description = "HelixALM"
    value       = join(" ", [aws_instance.helix_alm[0].public_ip, aws_instance.helix_alm[0].private_dns])
}
