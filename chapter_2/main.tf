# Providers (plugins) want TF download + region to create infrastructure in
provider "aws" {
    region = "us-east-1"
}

# EC2 resource want TF to create
resource "aws_instance" "example" {
    ami           = "ami-04a81a99f5ec58529"
    instance_type = "t2.micro"

    vpc_security_group_ids = [aws_security_group.instance.id]

    # Basic web server using busybox on Ubuntu
    user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World!" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF

    user_data_replace_on_change = true

    tags = {
        Name = "terraform-example"
    }
}

# Security group needed to allow inbound/outbound traffic in AWS
resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
