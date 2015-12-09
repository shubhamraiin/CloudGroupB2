#!/bin/bash
# create sample file for testing

dd if=/dev/urandom of=randomFile1 bs=4M count=10 conv=fdatasync

# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload myfiles randomFile1

# delete the file from local filesystem
rm randomFile1

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
	echo "Read Time: $(($stopLookup-$startLookup)) ms" >> /home/swift/CustomizedResult/Read.xls
else
	echo "Error while reading. Time taken : $(($stopLookup-$startLookup))" 
	echo "Error while reading. Time taken : $(($stopLookup-$startLookup))" >> /home/swift/CustomizedResult/Read.xls
fi
echo "if done"

# delete file from swift file system
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass delete myfiles
echo "Deletion of file done"

# delete the file from local filesystem
rm randomFile1

