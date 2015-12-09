#!/bin/bash
# create sample file for testing

dd if=/dev/urandom of=FailureFile bs=4M count=250 conv=fdatasync

# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload Failure FailureFile

# delete the file from local filesystem
rm FailureFile

# store the output of the get nodes in a file
swift-get-nodes object.ring.gz AUTH_system Failure FailureFile >> nodesOutputFile

# parse the output of the get nodes and get the first 3 ip addresses to make those machines go down
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' nodesOutputFile >> iPAddressesFile

# normal read the file
echo "Normal Read Time Without Failure: $(($stopLookup-$startLookup)) ms" >> CustomizedResult/ReadAfterFailure.xls
#
startLookup=$(date -u +%s%3N)
#
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass download Failure FailureFile >> CustomizedResult/ReadAfterFailure.xls
#
stopLookup=$(date -u +%s%3N)
echo "Normal Read Time Without Failure: $(($stopLookup-$startLookup)) ms" >> CustomizedResult/ReadAfterFailure.xls

# get the 1st machine down
IPADDRESS1=$(head -1 iPAddressesFile)
echo "IPAddres--------- $IPADDRESS1"
ssh swift@$IPADDRESS1 "swift-init all stop; exit"
# get the 2nd machine down
#IPADDRESS2=$(head -2 iPAddressesFile | tail -1)
#echo "IPAddres--------- $IPADDRESS2"
#ssh swift@$IPADDRESS2 "swift-init all stop; exit"
# get the 2nd machine down
#IPADDRESS3=$(head -3 iPAddressesFile | tail -1)
#echo "IPAddres--------- $IPADDRESS3"
#ssh swift@$IPADDRESS3 "swift-init all stop; exit"

# start recording lookup time
startLookup=$(date -u +%s%3N)
 
# read the file
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass download Failure FailureFile
returnValue=$?
echo "return value ------------------- $returnValue"

# stop recording read time
stopLookup=$(date -u +%s%3N)

if [ "$returnValue" == 0 ]
then
	#output the read time
	echo "Read Time after Failure: $(($stopLookup-$startLookup)) ms"
	echo "Read Time after Failure: $(($stopLookup-$startLookup)) ms" >> CustomizedResult/ReadAfterFailure.xls
else
	echo "Error while reading. Time taken : $(($stopLookup-$startLookup)) ms" 
	echo "Error while reading. Time taken : $(($stopLookup-$startLookup)) ms" >> CustomizedResult/ReadAfterFailure.xls
fi
echo "if done"

# get the 1st machine up
#ssh swift@$IPADDRESS1 "swift-init all start; exit"
# get the 2nd machine up
#ssh swift@$IPADDRESS2 "swift-init all start; exit"
# get the 3rd machine up
#ssh swift@$IPADDRESS3 "swift-init all start; exit"

# delete file from swift file system
#swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass delete ReadAfterFailure
#echo "Deletion of file done"

# delete the file from local filesystem
rm nodesOutputFile
rm iPAddressesFile
rm FailureFile
