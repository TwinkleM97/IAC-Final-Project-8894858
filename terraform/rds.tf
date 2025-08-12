resource "aws_security_group" "rds" {
  name        = "rds-${var.student_id}"
  description = "MySQL from EC2 SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "rds-${var.student_id}" }
}

resource "aws_db_subnet_group" "db" {
  name       = "dbsubnet-${var.student_id}"
  subnet_ids = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  tags       = { Name = "dbsubnet-${var.student_id}" }
}

resource "aws_db_instance" "mysql" {
  identifier_prefix    = "tm-${var.student_id}-"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = var.db_allocated_storage
  db_subnet_group_name = aws_db_subnet_group.db.name

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name    = "rds-${var.student_id}"
    Project = "PROG8870"
  }
}
