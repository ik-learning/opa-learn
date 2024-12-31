resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Beispiel Sicherheitsgruppe"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  ipv6_cidr_blocks = [ "::/0" ]
  security_group_id = aws_security_group.example.id
}
