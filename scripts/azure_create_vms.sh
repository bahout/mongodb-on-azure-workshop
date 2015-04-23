#!/bin/bash
vmimage="b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2_LTS-amd64-server-20150309-en-us-30GB" #azure vm image list #azure vm image show $vmimage
vmusername="azureuser"
vmsize="Standard_D13"
vmsshcert="mdoa.pem"
vmlocation="North Europe"
vmavailabilityset="mongoDB"
vmprefix="mdoa34-"

# the following settings may be different for you:
vmvnetnet="group mdoa mdoa" #you can get the value with the following command: azure network vnet list
storageaccountname="mdoa34"
vmservice="mdoa34b"


#create service
#azure service create vmservice--location "North Europe"

vmnumber=0
while [ $vmnumber -lt 4 ]
do
	vmname=$vmprefix$vmnumber
	vmsshport=$((2200+$vmnumber))
	vmipaddress=10.0.0.$((100+$vmnumber))
	osbloburl=https://$storageaccountname.blob.core.windows.net/vhds/${vmname}_os.vhd
	databloburl=https://$storageaccountname.blob.core.windows.net/vhds/${vmname}_data1.vhd

	azure vm create --connect --vm-name $vmname --vm-size $vmsize --ssh $vmsshport --virtual-network-name "$vmvnetnet" --availability-set $vmavailabilityset --blob-url $osbloburl --static-ip $vmipaddress --no-ssh-password --ssh-cert $vmsshcert $vmservice $vmimage $vmusername
	azure vm disk attach-new $vmname 1000 $databloburl

	if [ "$?" != "0" ]; then
        echo "Error: provisioning VM ${azurevmname} failed"
        exit 1
    fi

	vmnumber=$((vmnumber+1))
done
