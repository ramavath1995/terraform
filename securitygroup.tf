resource "aws_security_group" "benstack-elb-sg" {
    name = "bean-elb-sg"
    description = "Security Group for beanstack elastic load balancer"
    vpc_id = module.vpc.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}

resource "aws_security_group" "bastion-sg" {
    name = "bastion-host-SG"
    description = "Security Group for bastion host"
    vpc_id = module.vpc.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ var.MYIP ]
    }
  
}

resource "aws_security_group" "benstack-instance" {
    name = "beanstack-instance-sg"
    description = "Security Group for beanstack instances"
    vpc_id = module.vpc.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ aws_security_group.bastion-sg.id ]
    }
  
}

resource "aws_security_group" "backend-sg" {
    name = "SG-Backend"
    description = "security group for backend instances"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0"  ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = [ aws_security_group.benstack-instance.id ]
    }
  
}

resource "aws_security_group_rule" "self-backend" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = aws_security_group.backend-sg.id
  source_security_group_id = aws_security_group.backend-sg.id
}