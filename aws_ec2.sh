#!/bin/bash

# Requires these Environment Variables
INSTANCE_TYPE=<t3.small>               # Whatever you want
KEY_NAME=<my-existing-key-pair>a       # choose what key-pair you want. Needs to pre-exist
SUBNET_ID=<vpc=subnet-id>              # VPC subnet-id where you want the EC2 hosted
SECURITY_GROUP_ID=<security-group-id>  # Security group ID
EC2_NAME=<name-of-instance>            # Name of the EC2 instance that will be created

# Check if jay-k8s already exists. Create if not
result=$(aws ec2 describe-instances --filters "Name=tag-value,Values=$EC2_NAME" \
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
    --instance-type $INSTANCE_TYPE \
    --key-name jaybird-key \
    --subnet-id $SUBNET_ID \
    --security-group-ids $SECURITY_GROUP \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$EC2_NAME}]" \
    --block-device-mappings file://ebs.json \
    --user-data file://user_data.sh
fi
exit 0
