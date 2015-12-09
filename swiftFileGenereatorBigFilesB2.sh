#!/bin/bash
#
#generate file
#
for j in {1..4}
do
for i in {1..50}
do
dd if=/dev/urandom of=${i}randomFile1GB${i} bs=1M count=1024 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container1GB${j} ${i}randomFile1GB${i}
# delete the file from local filesystem
rm ${i}randomFile1GB${i}
done
done

for j in {1..5}
do
for i in {1..10}
do
dd if=/dev/urandom of=${i}randomFile2GB${i} bs=1M count=2048 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container2GB${j} ${i}randomFile2GB${i}
# delete the file from local filesystem
rm ${i}randomFile2GB${i}
done
done

for j in {1..3}
do
for i in {1..5}
do
dd if=/dev/urandom of=${i}randomFile3GB${i} bs=1M count=3072 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container3GB${j} ${i}randomFile3GB${i}
# delete the file from local filesystem
rm ${i}randomFile3GB${i}
done
done
