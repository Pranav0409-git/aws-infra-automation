resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "Test-vpc"
    }
  
}
resource "aws_subnet" "public" {
    count = 2
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name = "public_subnet-${count.index + 1}"
    }
}
resource "aws_subnet" "private" {
    count = 2
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.azs[count.index]

    tags = {
      Name = "private_subnet-${count.index + 1}"
    }
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_vpc.id
  
}
