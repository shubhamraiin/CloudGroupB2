#!/bin/bash
#takes four arguments:
#First: block size, Second: number of blocks
#Third: Random number
#export hdfsPath=/usr/local/hadoop/bin/hdfs
randomNumber=$3
filename="${randomNumber}randomfile${randomNumber}"
echo "File name to be created: $filename"
#start recording write time
startRead=$(date +%s%3N)
# download file from swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass download ${randomNumber}ReqGenContainer${randomNumber} $filename
returnValue=$?
#stop recording read time
stopRead=$(date +%s%3N)
if [ "$returnValue" == 0 ]
then
	#output the write time
	readTime=$(($stopRead-$startRead))
	echo "Read Time: $readTime ms"
	echo "500 MB, $readTime" >> /home/swift/CustomizedResult/SwiftReadOutputReqGen.xls
else
	echo "Error while reading"	
fi
rm $filename
