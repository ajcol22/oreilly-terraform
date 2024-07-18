# Providers (plugins) want TF download and region to create infrastructure
provider "aws" {
    region = "us-east-1"
}

# Resource want TF to create
resource "aws_instance" "example" {
    ami           = "ami-04a81a99f5ec58529"
    instance_type = "t2.micro"
}