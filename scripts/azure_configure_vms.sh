#!/bin/bash

vmprefix="mdoa34-"
vmuser="azureuser"
vmnumber=0

while [ $vmnumber -lt 4 ]
do
	vmname=$vmprefix$vmnumber
	vmipaddress=10.0.0.$((100+$vmnumber))

	echo "vm $vmname at $vmipaddress"
	
	#ssh -t -i id_rsa mdoa@$vmipaddress 'sudo mkdir -p /usr/lib/jvm'
	
	sudo scp -i mdoa mdoa-config-automation.sh $vmuser@$vmipaddress:mdoa-config-automation.sh
	sudo scp -i mdoa dev_sdc_config $vmuser@$vmipaddress:dev_sdc_config
	sudo ssh -t -i mdoa $vmuser@$vmipaddress './mdoa-config-automation.sh'

	vmnumber=$((vmnumber+1))
done
