resource "aws_vpc" "jeet_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jeet_vpc"
  }
}


# Create Public Subnet in VPC
resource "aws_subnet" "jeet_vpc_sub_pub_1" {
  vpc_id     = aws_vpc.jeet_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true" # This makes a subnet pvt or public
  availability_zone = "us-east-1a"

  tags = {
    Name = "jeet_vpc_sub_pub_1"
  }
}


# Create Private Subnet in VPC
resource "aws_subnet" "jeet_vpc_sub_pvt_1" {
  vpc_id     = aws_vpc.jeet_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false" # This makes a subnet pvt or public 
  availability_zone = "us-east-1b"

  tags = {
    Name = "jeet_vpc_sub_pvt_1"
  }
}


# Internet gateway
resource "aws_internet_gateway" "jeet_vpc_gw" {
  vpc_id = aws_vpc.jeet_vpc.id

  tags = {
    Name = "jeet_vpc_gw"
  }
}

# Route table
resource "aws_route_table" "jeet_vpc_pub_rtbl_1" {
  vpc_id = aws_vpc.jeet_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jeet_vpc_gw.id
  }

  tags = {
    Name = "jeet_vpc_pub_rtbl_1"
  }
}

# Route association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.jeet_vpc_sub_pub_1.id
  route_table_id = aws_route_table.jeet_vpc_pub_rtbl_1.id
}


# Creating EC2 instance in public subnet
resource "aws_instance" "web" {
  ami           = "ami-0ba9883b710b05ac6"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.jeet_vpc_sub_pub_1.id}"
  key_name = "MyEC22" 

  tags = {
    Name = "jeet-pub-ec2"
  }
}

