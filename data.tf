# data template
data "template_file" "master-userdata" {
    template = "${file("scripts/master.tpl")}"
}

data "template_file" "worker-userdata" {
    template = "${file("scripts/worker.tpl")}"

    vars {
        masterIP = "${aws_instance.master.private_ip}"
    }
}

data "aws_ami" "ec2_ami" {
  most_recent = true
  owners=["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["*-ubuntu-*"]
  }
}