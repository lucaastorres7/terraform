resource "aws_lb" "web-app-alb" {
  name               = "web-app-lb"
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"

  subnets = data.aws_subnets.default-subnets.ids

  security_groups = [aws_security_group.web-lb-sg.id]
  
  tags = {
    project = "terraform"
  }
}

# -- Target Group --
resource "aws_lb_target_group" "web-app-tg" {
  name        = "web-app-tg"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 8080
  vpc_id      = data.aws_vpc.default-vpc.id

  health_check {
    enabled  = true
    path     = "/"
    protocol = "HTTP"
    matcher  = "200"

    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 15
    timeout             = 10
  }

  tags = {
    project = "terraform"
  }
}

resource "aws_lb_target_group_attachment" "web-app-1" {
  target_group_arn = aws_lb_target_group.web-app-tg.arn
  target_id        = aws_instance.web-app-1.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "web-app-2" {
  target_group_arn = aws_lb_target_group.web-app-tg.arn
  target_id        = aws_instance.web-app-2.id
  port             = 8080
}

# -- Listener --
resource "aws_lb_listener" "web-app-listener" {
  load_balancer_arn = aws_lb.web-app-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Page not found"
      status_code  = 404
    }
  }

  tags = {
    project = "terraform"
  }
}

resource "aws_lb_listener_rule" "instances-forward" {
  listener_arn = aws_lb_listener.web-app-listener.arn

  action {
    type = "forward"

    forward {
      # Define um bloco de target_group por tg que tivermos
      target_group {
        arn    = aws_lb_target_group.web-app-tg.arn
        weight = 10
      }
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  tags = {
    project = "terraform"
  }
}