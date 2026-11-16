data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              dnf install -y httpd
              systemctl enable httpd
              cat > /var/www/html/index.html <<'HTML'
              <!doctype html>
              <html>
                <head><title>Three-Tier AWS Application</title></head>
                <body>
                  <h1>Three-Tier Web Application on AWS</h1>
                  <p>Web tier is running successfully.</p>
                </body>
              </html>
              HTML
              systemctl start httpd
              EOF

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-web-ec2"
    Tier = "web"
  })
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.app_private[0].id
  vpc_security_group_ids = [aws_security_group.app.id]

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-ec2"
    Tier = "application"
  })
}
