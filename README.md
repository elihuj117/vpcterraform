# Deploying a VPC with Terraform

![alt text](https://ibb.co/ykXjLLT)

### Terraform
This is a fairly straightforward Terraform project to deploy a VPC, and some associated components within an AWS enviornment. I've configured the variables to where you can change the aws_region easily, and it will be included in the name of the created resources. Example: vpc01.us-east-1.aws.lab.local. 

#### Resources Created:
- VPC
- Internet Gateway
- VPN Gateway
- Customer Gateway 
- NAT Gateway
- Autoscaling Group
- Elastic Load Balancer
- 3 networks (2 private, 2 public, and 1 vpn)
- Name subnets to include region and AZ
- Security groups for RDS, EFS, and Lab
- Route tables that associate to the respective networks

#### Networking
I have configured 3 networks for this project broken down into public, private, and vpn. The first two are configured to be highly available across two Availabilty Zones, with the latter being a single subnet. 

There are three route tables configured, one for each network. The public route table is configured to send traffic to the Internet Gateway, while the private route tables are configured to send traffic to a pair of highly available NAT Gateways. The VPN route table can easily be configured to associate to the Customer Gateway by associating it to the VPC in the vpc.tf file. I'm not doing this as to not get charged for it while testing!

#### Instance Configuration
I have setup an Autoscaling group to include a pair of Ubuntu instances, with a min/max of 2 to always ensure that there is one available per AZ. There is an Application Load Balancer sitting in front of them listening on port 80, which in turn forwards traffic to the instances listening on port 8080. I have a simple bash script configured that displays some instance information.

#### Security Groups
I have three named security groups. The rds_access, and efs_access are for RDS, and EFS access, respsectively. The lab_access security group allows for access to different services within the VPC or externally. 

