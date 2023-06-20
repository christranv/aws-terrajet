resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.vpc.id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${var.region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_vpc_endpoint_route_association" {
  route_table_id  = aws_route_table.private_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}

# resource "aws_vpc_endpoint" "sns_endpoint" {
#   vpc_id            = aws_vpc.vpc.id
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = local.subnet_ids
#   service_name      = "com.amazonaws.${var.region}.sns"
#   # private_dns_enabled = true
# }

# resource "aws_vpc_endpoint" "elasticache_endpoint" {
#   vpc_id            = aws_vpc.vpc.id
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = [local.subnet_ids[0]]
#   service_name      = "com.amazonaws.${var.region}.elasticache"
# }

### Currently, API service do not listen messsages from SQS
# resource "aws_vpc_endpoint" "sqs_endpoint" {
#   vpc_id            = aws_vpc.vpc.id
#   vpc_endpoint_type = "Interface"
#   subnet_ids        = local.subnet_ids
#   service_name      = "com.amazonaws.${var.region}.sqs"
# }
