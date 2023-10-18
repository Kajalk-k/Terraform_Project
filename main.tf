resource "aws_vpc" "terraform-project" {
  cidr_block = var.cidr
}
resource "aws_subnet" "terr-pro-sub1" {
  vpc_id                  = aws_vpc.terraform-project.id
  cidr_block              = var.sub1-cidr
  availability_zone       = "ap-southeast-2c"
  map_public_ip_on_launch = "true"
}
resource "aws_subnet" "terr-pro-sub2" {
  vpc_id                  = aws_vpc.terraform-project.id
  cidr_block              = var.sub2-cidr
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = "true"
}
resource "aws_subnet" "terr-pro-sub3" {
  vpc_id                  = aws_vpc.terraform-project.id
  cidr_block              = var.sub3-cidr
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = "true"
}
resource "aws_internet_gateway" "terra-ig" {
  vpc_id = aws_vpc.terraform-project.id
}

resource "aws_route_table" "terra-route-table" {
  vpc_id = aws_vpc.terraform-project.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-ig.id
  }
}

resource "aws_route_table_association" "terra-route-asso1" {
  subnet_id      = aws_subnet.terr-pro-sub1.id
  route_table_id = aws_route_table.terra-route-table.id
}

resource "aws_route_table_association" "terra-route-asso2" {
  subnet_id      = aws_subnet.terr-pro-sub2.id
  route_table_id = aws_route_table.terra-route-table.id
}

resource "aws_route_table_association" "terra-route-asso3" {
  subnet_id      = aws_subnet.terr-pro-sub3.id
  route_table_id = aws_route_table.terra-route-table.id
}

resource "aws_security_group" "terra-web-sg" {
  name        = "http"
  description = "Allow http for web server"
  vpc_id      = aws_vpc.terraform-project.id

  ingress {
    description = "HTTP requests"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terra-web-sg"
  }
}

resource "aws_s3_bucket" "terra-bucket" {
  bucket = "terra-s3-bucket-15-10-2023"
}

resource "aws_instance" "terra-web-1" {
  ami                    = var.ami1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terra-web-sg.id]
  subnet_id              = aws_subnet.terr-pro-sub1.id
  user_data              = base64encode(file("web1.sh"))
}

resource "aws_instance" "terra-web-2" {
  ami                    = var.ami1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terra-web-sg.id]
  subnet_id              = aws_subnet.terr-pro-sub2.id
  user_data              = base64encode(file("web2.sh"))
}

resource "aws_instance" "terra-web-3" {
  ami                    = var.ami1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terra-web-sg.id]
  subnet_id              = aws_subnet.terr-pro-sub3.id
  user_data              = base64encode(file("web3.sh"))
}

resource "aws_lb" "terra-alb" {
  name               = "terra-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terra-web-sg.id]
  subnets            = [aws_subnet.terr-pro-sub1.id , aws_subnet.terr-pro-sub2.id , aws_subnet.terr-pro-sub3.id]
}

resource "aws_lb_target_group" "terra-target-gp" {
  name     = "terra-target-gp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-project.id

  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_lb_target_group_attachment" "terra-target-gp-att1" {
  target_group_arn = aws_lb_target_group.terra-target-gp.arn
  target_id        = aws_instance.terra-web-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "terra-target-gp-att2" {
  target_group_arn = aws_lb_target_group.terra-target-gp.arn
  target_id        = aws_instance.terra-web-2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "terra-target-gp-att3" {
  target_group_arn = aws_lb_target_group.terra-target-gp.arn
  target_id        = aws_instance.terra-web-3.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.terra-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.terra-target-gp.arn
    type             = "forward"
  }

}

output "lb_dns" {
  value = aws_lb.terra-alb.dns_name

}
