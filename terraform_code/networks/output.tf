output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_id" {
    value = aws_subnet.subnets.id
}

output "rtb_id" {
    value = aws_route_table.pub_rtb.id
}


output "igw_id" {
    value = aws_internet_gateway.igw.id
}

output "routetable_id" {
    value = aws_route_table.pub_rtb.id
}
