
# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE EC2 INSTANCE WITH A PUBLIC IP
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "master" {
  
  ami                    ="${var.ami_image}"
  instance_type          = "${var.image_size}"
  security_groups        = ["${aws_security_group.master-ingress.name}"]
  key_name               = "${var.pub_key_name}"
  user_data              = "${data.template_file.master-userdata.rendered}"
  associate_public_ip_address = true
  tags ={
    Name = "${var.master_name}"
  }

}


