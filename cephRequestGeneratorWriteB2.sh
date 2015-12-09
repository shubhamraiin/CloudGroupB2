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


#start recording write time
startWrite=$(date +%s%3N)

pool_name=${randomNumber}ReqGenContainer${randomNumber}

#create a pool to upload the objects
rados mkpool $pool_name

#Upload a file on Ceph
rados -p $pool_name  put $filename $filename

#stop recording write time
stopWrite=$(date +%s%3N)

#output the write time
writeTime=$(($stopWrite-$startWrite))
echo "$writeTime"
