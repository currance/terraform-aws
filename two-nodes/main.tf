provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_instance" "node1" {
  ami           = "ami-2757f631"
  instance_type = "t2.nano"
  key_name      = "ubuntu-kvm1"
  tags {
    Name = "Demo - Node1" 
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get -y dist-upgrade | tee -a /tmp/build-apt.out",
      "sudo apt-get -y autoremove | tee -a /tmp/build-apt.out",
      "sudo reboot",
    ]
  }
}

resource "aws_instance" "node2" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name      = "ubuntu-kvm1"
  tags {
    Name = "Demo - Node2" 
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("/home/ubuntu/.ssh/id_rsa")}"
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get -y dist-upgrade | tee -a /tmp/build-apt.out",
      "sudo apt-get -y autoremove | tee -a /tmp/build-apt.out",
      "sudo reboot",
    ]
  }
}
