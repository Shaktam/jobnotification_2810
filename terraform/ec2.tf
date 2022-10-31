resource "aws_instance" "jobportal" {

  ami                         = "ami-0d593311db5abb72b"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                  = aws_subnet.public_subnet_a.id
  vpc_security_group_ids     = [aws_security_group.sg.id]
  key_name                   = "vockey"
  user_data                  = file("./script/userdata1.sh")
  tags = {
    Name = "Job Notifier"
  }
}
# OUTPUT
output "ec2_public_ip" {
  value = aws_instance.jobportal.public_ip
}
