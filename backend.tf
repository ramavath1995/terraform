resource "aws_db_subnet_group" "db-subnets" {
  name = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    name = "database-subnetgroup"
  }
}

resource "aws_elasticache_subnet_group" "cache-subnets" {
  name = "cache"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    name = "elasticache-subnetgroup"
  }
}

resource "aws_db_instance" "db-instance" {
    allocated_storage    = 20
    storage_type = "gp2"
    db_name              = var.BDNAME
    engine               = "mysql"
    engine_version       = "5.6.34"
    instance_class       = "db.t2.micro"
    username             = var.BDUSER
    password             = var.BDPASS
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    multi_az = false
    publicly_accessible = "false"
    db_subnet_group_name = aws_db_subnet_group.db-subnets.id
    vpc_security_group_ids = [aws_security_group.backend-sg.id]
  
}

resource "aws_elasticache_cluster" "example" {
  cluster_id           = "vprofile"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  port                 = 11211
  subnet_group_name = aws_elasticache_subnet_group.cache-subnets.id
  security_group_ids = [aws_security_group.backend-sg.id]
}

resource "aws_mq_broker" "broker" {
  broker_name = "rmq"

  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.backend-sg.id]
  subnet_ids = [module.vpc.private_subnets[0]]

  user {
    username = var.RABBITUSER
    password = var.RABBITPASS
  }
}