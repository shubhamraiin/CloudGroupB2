#!/bin/bash
#takes four arguments:
#First: block size, Second: number of blocks
#Third: Random number
#export hdfsPath=/usr/local/hadoop/bin/hdfs
randomNumber=$3
filename="${randomNumber}randomfile${randomNumber}"
echo "File name to be created: $filename"
#create sample file for testing
dd if=/dev/urandom of=$filename bs=$1 count=$2 conv=fdatasync
#
#start recording write time
startWrite=$(date +%s%3N)
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${randomNumber}ReqGenContainer${randomNumber} $filename
returnValue=$?
#stop recording write time
stopWrite=$(date +%s%3N)
if [ "$returnValue" == 0 ]
then
	#output the write time
	writeTime=$(($stopWrite-$startWrite))
	echo "Write Time: $writeTime ms"
	echo "500 MB, $writeTime" >> /home/swift/CustomizedResult/SwiftWriteOutputReqGen.xls
else
	echo "Error while writing"	
fi
rm $filename
