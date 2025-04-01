provider "aws" {
  region = "ap-south-1" # Set your desired AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-076c6dbba59aa92e6" # Specify an appropriate AMI ID
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d4e2e25864d04150"
}
