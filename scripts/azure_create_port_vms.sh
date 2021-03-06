#!/bin/bash

#NB: you may prefer to go to https://manage.windowsazure.com, Cloud Services, Dashboard and START
#  the VMs will be started in parallel

vmprefix="mdoa34-"

# the following settings may be different for you:
vmservice="mdoa34b"

vmnumber=0

while [ $vmnumber -lt 3 ]
do
	vmname=$vmprefix$vmnumber
	vmipaddress=10.0.0.$((100+$vmnumber))

	echo "vm $vmname at $vmipaddress"
	azure vm endpoint create $vmname $((27017+$vmnumber))
	
	vmnumber=$((vmnumber+1))
done
