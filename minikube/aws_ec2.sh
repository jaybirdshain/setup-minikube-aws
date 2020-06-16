#!/bin/bash

# Check if jay-k8s already exists. Create if not
result=$(aws ec2 describe-instances --filters "Name=tag-value,Values=jay-k8s" \
  --query 'Reservations[*]' --output json)

if [ "$result" != '[]'  ] 
then
  echo "jay-k8s EC2 instance already exists"
  exit 1
else 
  echo "Creating my-k8s EC2 instance"
  aws ec2 run-instances \
    --image-id ami-085925f297f89fce1 \
    --count 1 \
    --instance-type t3.small \
    --key-name jaybird-key \
    --subnet-id subnet-060ce15b0502105ca \
    --security-group-ids sg-00d3a9a2c1f827dba \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=jay-k8s}]' \
    --block-device-mappings file://ebs.json \
    --user-data file://user_data.sh
fi
exit 0
