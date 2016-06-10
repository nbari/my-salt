#!/bin/sh

export AWS_ACCESS_KEY_ID=the-key
export AWS_SECRET_ACCESS_KEY=the-secret
export AWS_DEFAULT_REGION=eu-west-1

add-apt-repository ppa:saltstack/salt --yes
apt-get install -y -qq python-software-properties
apt-get update -y -qq
apt-get upgrade -y -qq
apt-get install -y -qq python-pip
pip install awscli

TAG_NAME="Salt"
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')
TAG_VALUE=$(aws ec2 describe-tags --filters "Name=resource-id,Values=${INSTANCE_ID}" "Name=key,Values=$TAG_NAME" --region ${REGION} --output=text | cut -f5)

# hostname
echo ${INSTANCE_ID} > /etc/hostname
hostname -F /etc/hostname

# salt
mkdir /etc/salt
echo ${INSTANCE_ID} > /etc/salt/minion_id
echo "node_type: ${TAG_VALUE}" > /etc/salt/grains
echo "startup_states: highstate" > /etc/salt/minion

apt-get -o Dpkg::Options::="--force-confnew" install -y -qq salt-minion
