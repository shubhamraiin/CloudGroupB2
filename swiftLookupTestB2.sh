#!/bin/bash
# create sample file for testing

for i in {1..100} 
do
dd if=/dev/urandom of=LookUpFile$i bs=4M count=10 conv=fdatasync

# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ContainerLookUp1 LookUpFile$i

# delete the file from local filesystem
rm -r -f LookUpFile*

done

# start recording lookup time
startLookup=$(date -u +%s%3N)

swift-get-nodes object.ring.gz AUTH_system ContainerLookUp1 LookUpFile2

# stop recording read time
stopLookup=$(date -u +%s%3N)

# output the Lookup time
echo "Lookup time: $(($stopLookup-$startLookup)) ms" >> /home/swift/CustomizedResult/Lookup.xls

# delete file from swift file system
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass delete ContainerLookUp1

