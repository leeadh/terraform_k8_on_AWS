
# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE EC2 INSTANCE WITH A PUBLIC IP
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "worker" {
  
  ami                    ="${var.ami_image}"
  count                  = "${var.number_of_worker}"
  instance_type          = "${var.image_size}"
  security_groups        = ["${aws_security_group.worker-ingress.name}"]
  key_name               = "${var.pub_key_name}"
  user_data              = "${data.template_file.worker-userdata.rendered}"
  # This EC2 Instance has a public IP and will be accessible directly from the public Internet
  associate_public_ip_address = true
  tags ={
    Name = "${var.worker_name}-${count.index}"
  }

}