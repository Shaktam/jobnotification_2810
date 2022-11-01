resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "Http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_http_lb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_instance" "jobportal" {
  ami                         = "ami-0d593311db5abb72b"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                  = aws_subnet.public_subnet.id
  vpc_security_group_ids     = [aws_security_group.allow_http_ssh.id]
  key_name                   = "vockey"
  user_data                  = file("./script/userdata1.sh")
  iam_instance_profile       ="LabInstanceProfile"
  tags = {
    Name = "Job Notifier"
  }
}
# OUTPUT
output "ec2_public_ip" {
  value = aws_instance.jobportal.public_ip
  description = "Public ip address"
}
