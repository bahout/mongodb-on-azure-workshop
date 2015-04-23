#!/bin/bash
#this script is inspired from http://haishibai.blogspot.fr/2014/12/mongodb-clusters-on-azure-using-mms-and.html
curl -OL https://mms.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_1.7.0.992-1_amd64.deb
sudo dpkg -i mongodb-mms-automation-agent-manager_1.7.0.992-1_amd64.deb
sudo sed -i 's/mmsGroupId=@GROUP_ID@/mmsGroupId=5531ef0ae4b0ca8a5c62816b/g' /etc/mongodb-mms/automation-agent.config
sudo sed -i 's/mmsApiKey=@API_KEY@/mmsApiKey=0fefea0de643d263c94cdf97fa63e06d/g' /etc/mongodb-mms/automation-agent.config

sudo sfdisk /dev/sdc < ~/dev_sdc_config
sudo mkfs -t ext4 /dev/sdc1
sudo mkdir -p /data
sudo mount /dev/sdc1 /data
sudo sed -i '$a/dev/sdc1 /data ext4 defaults 1 2' /etc/fstab

#because on azure
sudo bash -c 'echo 60 > /proc/sys/net/ipv4/tcp_keepalive_time'

sudo chown mongodb:mongodb /data
sudo start mongodb-mms-automation-agent
