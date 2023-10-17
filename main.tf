# VPC Configuration
module "aws_vpc" {
  source      = "github.com/ard-hmd/terraform-aws-vpc.git"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

# EKS Cluster Configuration
module "eks_cluster" {
  source = "github.com/ard-hmd/terraform-aws-eks-cluster.git"
  cluster_config = {
    name    = "eks-cluster-spring-petclinic"
    version = "1.28"
  }
  public_subnets_ids  = module.aws_vpc.public_subnets_ids
  private_subnets_ids = module.aws_vpc.private_subnets_ids
}

# EKS Cluster Node Group Configuration
module "eks_cluster_nodegroup" {
  source              = "github.com/ard-hmd/terraform-aws-eks-nodegroup.git"
  public_subnets_ids  = module.aws_vpc.public_subnets_ids
  private_subnets_ids = module.aws_vpc.private_subnets_ids
  eks_cluster_name    = module.eks_cluster.eks_cluster_name

  # Node Group Details
  node_groups = [
    {
      name           = "nodegroup-ondemand-1"
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      disk_size      = 20
      scaling_config = {
        desired_size = 3
        max_size     = 3
        min_size     = 1
      }
    }
  ]

  depends_on = [module.eks_cluster]
}


module "rds_instance" {
  source     = "github.com/ard-hmd/terraform-aws-rds-with-replica.git"
  aws_region = var.aws_region

  database_configurations = [
    {
      identifier              = "customersdb"
      allocated_storage       = 10
      engine_version          = "8.0"
      instance_class          = "db.t3.micro"
      db_name                 = "customersdb"
      db_username             = "admin"
      db_password             = var.customersdb_password
      parameter_group_name    = "default.mysql8.0"
      db_subnet_group_name    = module.aws_vpc.rds_subnet_group_name
      skip_final_snapshot     = true
      publicly_accessible     = false
      backup_retention_period = 0
      vpc_id                  = module.aws_vpc.vpc_id
      allowed_cidrs           = [module.aws_vpc.vpc_cidr]
      multi_az                = true
      sg_name                 = "customers-db-sg"
      sg_description          = "Security Group for customersdb"
    },
    # Vets Database Configuration
    {
      identifier              = "vetsdb"
      allocated_storage       = 10
      engine_version          = "8.0"
      instance_class          = "db.t3.micro"
      db_name                 = "vetsdb"
      db_username             = "admin"
      db_password             = var.vetsdb_password
      parameter_group_name    = "default.mysql8.0"
      db_subnet_group_name    = module.aws_vpc.rds_subnet_group_name
      skip_final_snapshot     = true
      publicly_accessible     = false
      backup_retention_period = 0
      vpc_id                  = module.aws_vpc.vpc_id
      allowed_cidrs           = [module.aws_vpc.vpc_cidr]
      multi_az                = true
      sg_name                 = "vets-db-sg"
      sg_description          = "Security Group for vetsdb"
    },
    # Visits Database Configuration
    {
      identifier              = "visitsdb"
      allocated_storage       = 10
      engine_version          = "8.0"
      instance_class          = "db.t3.micro"
      db_name                 = "visitsdb"
      db_username             = "admin"
      db_password             = var.visitsdb_password
      parameter_group_name    = "default.mysql8.0"
      db_subnet_group_name    = module.aws_vpc.rds_subnet_group_name
      skip_final_snapshot     = true
      publicly_accessible     = false
      backup_retention_period = 0
      vpc_id                  = module.aws_vpc.vpc_id
      allowed_cidrs           = [module.aws_vpc.vpc_cidr]
      multi_az                = true
      sg_name                 = "visits-db-sg"
      sg_description          = "Security Group for visitsdb"
    },
  ]
  create_replica = false
}
