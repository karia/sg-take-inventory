#! /usr/bin/env ruby
require 'json'

# Get EC2 SecurityGroups
str = `aws ec2 describe-instances`
ec2hash = JSON.load(str);
ec2array = []
ec2hash["Reservations"].each do |ec2instance|
  ec2instance["Instances"][0]["SecurityGroups"].each do |ec2sg|
    ec2array.push(ec2sg["GroupId"])
  end
end

# Get ALB SecurityGroups
str = `aws elbv2 describe-load-balancers`
albhash = JSON.load(str);
albarray = []
albhash["LoadBalancers"].each do |alb|
  alb["SecurityGroups"].each do |albsg|
    albarray.push(albsg)
  end
end

# Get CLB(ELB Classic) SecurityGroups
str = `aws elb describe-load-balancers`
clbhash = JSON.load(str);
clbarray = []
clbhash["LoadBalancerDescriptions"].each do |clb|
  clb["SecurityGroups"].each do |clbsg|
    clbarray.push(clbsg)
  end
end

# Get RDS SecurityGroups
str = `aws rds describe-db-instances`
rdshash = JSON.load(str);
rdsarray = []
rdshash["DBInstances"].each do |rds|
  rds["VpcSecurityGroups"].each do |rdssg|
    rdsarray.push(rdssg["VpcSecurityGroupId"])
  end
end

# Get ElastiCache SecurityGroups
str = `aws elasticache describe-cache-clusters`
eshash = JSON.load(str);
esarray = []
eshash["CacheClusters"].each do |escluster|
  unless escluster["SecurityGroups"].nil? then
    escluster["SecurityGroups"].each do |essg|
      esarray.push(essg["SecurityGroupId"])
    end
  end
end

# Get Redshift SecurityGroups
str = `aws redshift describe-clusters`
rshash = JSON.load(str);
rsarray = []
rshash["Clusters"].each do |rs|
  rs["VpcSecurityGroups"].each do |rssg|
    rsarray.push(rssg["VpcSecurityGroupId"])
  end
end

# Output ALL SecurityGroups
puts "GroupId,GroupName,EC2,ALB,CLB,RDS,ElastiCache,Redshift"

str = `aws ec2 describe-security-groups`
sghash = JSON.load(str);
sghash["SecurityGroups"].each do |sg|
  line = sg["GroupId"] + "," + sg["GroupName"]

  # EC2
  if ec2array.include?(sg["GroupId"]) then
    line = line + ",YES"
  elsif
    line = line +  ",NO"
  end

  # ALB
  if albarray.include?(sg["GroupId"]) then
    line = line + ",YES"
  elsif
    line = line +  ",NO"
  end

  # CLB
  if clbarray.include?(sg["GroupId"]) then
    line = line + ",YES"
  elsif
    line = line +  ",NO"
  end

  # RDS
  if rdsarray.include?(sg["GroupId"]) then
    line = line + ",YES"
  elsif
    line = line +  ",NO"
  end

  # ElasticCache 
  if esarray.include?(sg["GroupId"]) then
    line = line + ",YES"
  elsif
    line = line +  ",NO"
  end

  # Redshift
  if rsarray.include?(sg["GroupId"]) then
    line = line + ",YES"
  elsif
    line = line +  ",NO"
  end

  # Output
  puts line
end

