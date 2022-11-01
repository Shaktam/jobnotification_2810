resource "aws_lb_target_group" "job_tg" {
  name     = "job-tg"
  port     = 8000
  protocol = "custom"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_target_group_attachment" "job_tg_attach" {
  target_group_arn = aws_lb_target_group.job_tg.arn
  target_id        = aws_instance.jobportal.id
  port             = 8000
}

resource "aws_security_group" "allow_http_lb" {
  name        = "allow_http_lb"
  description = "Allow http_lb"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "Http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "custom"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http_lb"
  }
}

resource "aws_lb" "job_lb" {
  name               = "job-notifier-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_lb.id]
  subnets            = [aws_subnet.public_subnet_a.id,aws_subnet.public_subnet_b.id]
}
resource "aws_lb_listener" "jobportal_listener" {
  load_balancer_arn = aws_lb.job_lb.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.job_tg.arn
  }
}

# OUTPUT
output "load_balancer_dns" {
  value       = aws_lb.job_lb.dns_name
  description = "Dns name of lb"
}