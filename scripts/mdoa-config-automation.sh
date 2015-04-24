#!/bin/bash
########## install MMS
####### this script is inspired from http://haishibai.blogspot.fr/2014/12/mongodb-clusters-on-azure-using-mms-and.html
#curl -OL https://mms.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_1.7.0.992-1_amd64.deb
#sudo dpkg -i mongodb-mms-automation-agent-manager_1.7.0.992-1_amd64.deb
#sudo sed -i 's/mmsGroupId=@GROUP_ID@/mmsGroupId=5531ef0ae4b0ca8a5c62816b/g' /etc/mongodb-mms/automation-agent.config
#sudo sed -i 's/mmsApiKey=@API_KEY@/mmsApiKey=0fefea0de643d263c94cdf97fa63e06d/g' /etc/mongodb-mms/automation-agent.config
######## end of install MMS


#sudo sfdisk /dev/sdc < ~/dev_sdc_config
echo Partitioning...
	sudo fdisk /dev/sdc <<ENDPARTITION > /tmp/fdisk.log 2>&1
n
p
1


w
ENDPARTITION

sudo mkfs -t ext4 /dev/sdc1
sudo mkdir -p /data
sudo mount /dev/sdc1 /data
sudo sed -i '$a/dev/sdc1 /data ext4 defaults 1 2' /etc/fstab

#because on azure
sudo bash -c 'echo 60 > /proc/sys/net/ipv4/tcp_keepalive_time'



########mongo install
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
######## end of install



sudo chown mongodb:mongodb /data

#sudo start mongodb-mms-automation-agent

sudo service mongod start

