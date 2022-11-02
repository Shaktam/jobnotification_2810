
resource "aws_launch_template" "job-portal-template" {
  name = "launch-job-portal-template-terraform"

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  image_id = "ami-0d593311db5abb72b"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"


  key_name = "vockey"

  vpc_security_group_ids = [aws_security_group.allow_http.id]


  user_data = filebase64("./script/userdata1.sh")
}

resource "aws_autoscaling_group" "autoscale_job_portal" {
  vpc_zone_identifier = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1

  launch_template {
    id      = aws_launch_template.job-portal-template.id
    version = "$Latest"
  }
  depends_on = [
    aws_nat_gateway.natgw
  ]
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.autoscale_job_portal.id
  lb_target_group_arn    = aws_lb_target_group.job_tg.arn
}