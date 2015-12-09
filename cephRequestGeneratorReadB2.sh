#!/bin/bash
#takes four arguments:
#First: block size, Second: number of blocks
#Third: Random number

randomNumber=$3

filename="${randomNumber}randomfile${randomNumber}"
echo "File name to be read: $filename"

#start recording write time
startRead=$(date +%s%3N)

pool_name=${randomNumber}ReqGenContainer${randomNumber}

#Download a file from Ceph
rados -p $pool_name get $filename $filename


#stop recording read time
stopRead=$(date +%s%3N)

#output the write time
writeTime=$(($stopRead-$startRead))
echo "Download time: $writeTime"

rm $filename
