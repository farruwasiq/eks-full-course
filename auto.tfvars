main_vpc_cidr          = "10.212.210.0/24"
public_subnet_1a_cidr  = "10.212.210.0/27"
public_subnet_1b_cidr  = "10.212.210.32/27"
private_subnet_1a_cidr = "10.212.210.64/27"
private_subnet_1b_cidr = "10.212.210.96/27"
instance_types = {
  cm1     = "t2.micro" // "m6g.8xlarge"
  cm2     = "t2.micro" //"m6g.8xlarge"
  primary = "t2.micro" //"m6g.8xlarge"
  jump    = "t2.micro" //"m6g.8xlarge"
}
allowed_source = "0.0.0.0/0" //allowed sources cidr-change accourdingly

