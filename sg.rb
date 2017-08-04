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

p clbarray

# Output ALL SecurityGroups
puts "GroupId,GroupName,EC2,ALB,CLB"

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

  # Output
  puts line
end

