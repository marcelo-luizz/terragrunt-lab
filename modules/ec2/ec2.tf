
resource "aws_instance" "example" {
  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${var.sg_id}"]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}