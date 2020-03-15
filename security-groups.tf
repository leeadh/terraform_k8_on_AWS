# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP TO CONTROL WHAT REQUESTS CAN GO IN AND OUT OF THE K8 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "master-ingress" {
  name = "master-ingress"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port   = "${var.ssh_port}"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = "0"
    to_port   = "80"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "6443"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "443"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "worker-ingress" {
  name = "worker-ingress"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port   = "${var.ssh_port}"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = "0"
    to_port   = "80"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "6443"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "443"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "10250"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "27019"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "30000"
    to_port   = "32767"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}