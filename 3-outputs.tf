
# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT THE IP OF THE INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

output "master_node_ip" {
  value = "${aws_instance.master.public_ip}"
}

output "worker_node_public_ip" {
  value = "${aws_instance.worker.*.public_ip}"
}

output "worker_node_private_ip" {
  value = "${aws_instance.worker.*.private_ip}"
}