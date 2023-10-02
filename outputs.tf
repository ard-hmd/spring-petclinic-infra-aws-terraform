output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.aws_vpc.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR of the VPC."
  value       = module.aws_vpc.vpc_cidr
}

output "public_subnets_ids" {
  description = "The IDs of the public subnets."
  value       = module.aws_vpc.public_subnets_ids
}

output "private_subnets_ids" {
  description = "The IDs of the private subnets."
  value       = module.aws_vpc.private_subnets_ids
}

output "rds_subnet_group_name" {
  description = "The name of the RDS subnet group."
  value       = module.aws_vpc.rds_subnet_group_name
}

output "public_route_table_ids" {
  description = "The ID of the public route table."
  value       = module.aws_vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "The IDs of the private route tables."
  value       = module.aws_vpc.private_route_table_ids
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway."
  value       = module.aws_vpc.internet_gateway_id
}

output "nat_gateways_ids" {
  description = "The IDs of the NAT gateways."
  value       = module.aws_vpc.nat_gateways_ids
}

output "elastic_ips" {
  description = "The Elastic IPs associated with the NAT gateways."
  value       = module.aws_vpc.elastic_ips
}

# output "db_instance_arns" {
#  description = "The ARNs of the RDS instances"
#  value       = module.rds_instances.db_instance_arn
# }

# output "db_instance_endpoints" {
#  description = "The connection endpoints of the RDS instances"
#  value       = module.rds_instances.db_instance_endpoint
# }

# output "db_instance_identifiers" {
#  description = "The identifiers of the RDS instances"
#  value       = module.rds_instances.db_instance_identifier
# }

# output "replica_db_instance_identifier" {
#   description = "The identifiers of the RDS replica instances"
#   value       = module.rds_replicas.replica_db_instance_identifier
# }

# output "replica_db_instance_endpoint" {
#   description = "The endpoint of the RDS replica instances"
#   value       = module.rds_replicas.replica_db_instance_endpoint
# }

# output "replica_db_instance_arn" {
#   description = "The ARN of the RDS replica instances"
#   value       = module.rds_replicas.replica_db_instance_arn
# }

output "main_eks_cluster_name" {
  description = "The name of the EKS cluster from the main configuration"
  value       = module.eks_cluster.eks_cluster_name
}

# output "rds_security_group_ids" {
#  description = "The IDs of the Security Groups associated with the RDS instances."
#  value       = module.rds_instances.rds_security_group_ids
# }

# output "rds_security_group_names" {
#  description = "The names of the Security Groups associated with the RDS instances."
#  value       = module.rds_instances.rds_security_group_names
# }

# output "rds_security_group_descriptions" {
#  description = "The descriptions of the Security Groups associated with the RDS instances."
#  value       = module.rds_instances.rds_security_group_descriptions
# }



// outputs.tf dans le module RDS

// outputs.tf dans le module principal

output "master_db_instance_arn" {
  value = module.rds_module.master_db_instance_arn
}

output "master_db_instance_endpoint" {
  value = module.rds_module.master_db_instance_endpoint
}

output "master_db_instance_identifier" {
  value = module.rds_module.master_db_instance_identifier
}

output "replica_db_instance_arn" {
  value = module.rds_module.replica_db_instance_arn
}

output "replica_db_instance_endpoint" {
  value = module.rds_module.replica_db_instance_endpoint
}

output "replica_db_instance_identifier" {
  value = module.rds_module.replica_db_instance_identifier
}

