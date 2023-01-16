output "worker_public_ip" {
  value = "ssh -i ~/.ssh/hcp-demo ubuntu@${aws_instance.worker.public_ip}"
}
  
