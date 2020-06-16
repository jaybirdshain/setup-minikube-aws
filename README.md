# Setup Minikube in AWS EC2 Instance

## Objective
Uses bash script and AWS CLI to create an ubuntu serverEC2 instance installed with kubenetes minikube.

## Prerequisites
* Gain access to a Linux Environment. In muy case, it is Oracle VirtualBox with an Ubuntu 20.04 Desktop image
  * Install the needed modules be to be able to AWS CLI.
  ```
  sudo apt install awscli
  aws configure`# using my credentials
  sudo apt install git
  sudo apt-get upgrade python3
  sudo apt-get install python3-pip
  sudo pip3 install boto3

  * Configure for AWS to your account (yes, an AWS Account is needed)
  * Fork or clone this repo
    `

## Uses the following Environment Variables
* Establish these Environment variables
```
INSTANCE_TYPE=<t3.small>               # Whatever you want
KEY_NAME=<my-existing-key-pair>a       # choose what key-pair you want. Needs to pre-exist
SUBNET_ID=<vpc=subnet-id>              # VPC subnet-id where you want the EC2 hosted
SECURITY_GROUP_ID=<security-group-id>  # Security group ID
EC2_NAME=<name-of-instance>            # Name of the EC2 instance that will be created
```
## Run the script
`bash aws_ec2.sh`

## Additional information
* You may find `minikube start` doesn't actually run so will have to do it again after connecting to the EC2 instance the first time.
* Unless you have a bastion, while experimenting use a public subnet
* This environment uses Docker and does not set `--driver`
* Refer to [Kubenetes Minikube documentation](https://kubernetes.io/docs/tasks/tools/install-minikube/) for further information. Note it is tricky. I tried many different options until I got this particular combination to work.
