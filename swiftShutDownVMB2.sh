#!/bin/bash
# create sample file for testing

dd if=/dev/urandom of=randomFile1 bs=4M count=10 conv=fdatasync

# upload file on swift
swift --insecure -A https://proxyNode:8080/auth/v1.0 -U system:root -K testpass upload myfiles randomFile1

# delete the file from local filesystem
rm randomFile1

# store the output of the get nodes in a file
swift-get-nodes object.ring.gz AUTH_system myfiles randomFile1 >> nodesOutputFile

# parse the output of the get nodes and get the first 3 ip addresses to make those machines go down
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' nodesOutputFile >> iPAddressesFile

# get the 1st machine down
IPADDRESS1=$(head -1 iPAddressesFile)
echo "IPAddres--------- $IPADDRESS1"
ssh swift@$IPADDRESS1 "swift-init all stop; sudo shutdown -P now; exit"
# get the 2nd machine down
#IPADDRESS2=$(head -2 iPAddressesFile | tail -1)
#echo "IPAddres--------- $IPADDRESS2"
#ssh swift@$IPADDRESS2 "swift-init all stop; sudo shutdown -P now; exit"

# start recording lookup time
startLookup=$(($(date -u +%s)*1000))
 
# read the file
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass download myfiles randomFile1
returnValue=$?
echo "return value ------------------- $returnValue"

# stop recording read time
stopLookup=$(($(date -u +%s)*1000))

if [ "$returnValue" == 0 ]
then
	#output the read time
	echo "Read Time: $(($stopLookup-$startLookup)) ms"
	echo "Read Time: $(($stopLookup-$startLookup)) ms" >> /home/swift/CustomizedResult/LookupAfterFailure.xls
else
	echo "Error while reading. Time taken : $(($stopLookup-$startLookup))" 
	echo "Error while reading. Time taken : $(($stopLookup-$startLookup))" >> /home/swift/CustomizedResult/LookupAfterFailure.xls
fi
echo "if done"

# get the 1st machine up
#IPADDRESS1=$(head -n1 iPAddressesFile)

#ssh swift@$IPADDRESS1 "swift-init all start; exit"
# get the 2nd machine up
#IPADDRESS2=$(head -2 iPAddressesFile | tail -1)

#ssh swift@$IPADDRESS2 "swift-init all start; exit"

# delete file from swift file system
#swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass delete myfiles
#echo "Deletion of file done"

# delete the file from local filesystem
rm nodesOutputFile
rm iPAddressesFile
rm randomFile1

# wait for an hour for the system to recover

