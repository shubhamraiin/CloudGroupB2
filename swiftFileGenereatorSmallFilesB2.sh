#!/bin/bash
#
#generate file
#
for j in {1..50}
do
for i in {1..2000}
do
dd if=/dev/urandom of=${i}randomFile1MB${i} bs=1M count=1 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container1MB${j} ${i}randomFile1MB${i}
# delete the file from local filesystem
rm ${i}randomFile1MB${i}
done
done

for j in {1..100}
do
for i in {1..3000}
do
dd if=/dev/urandom of=${i}randomFile500KB${i} bs=1KB count=500 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container500KB${j} ${i}randomFile500KB${i}
# delete the file from local filesystem
rm ${i}randomFile500KB${i}
done
done

for j in {1..200}
do
for i in {1..2500}
do
dd if=/dev/urandom of=${i}randomFile10KB${i} bs=1KB count=10 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container10KB${j} ${i}randomFile10KB${i}
# delete the file from local filesystem
rm ${i}randomFile10KB${i}
done
done

for j in {1..150}
do
for i in {1..1000}
do
dd if=/dev/urandom of=${i}randomFile250KB${i} bs=1KB count=250 conv=fdatasync
# upload file on swift
swift --insecure -A https://$PROXY_LOCAL_NET_IP:8080/auth/v1.0 -U system:root -K testpass upload ${j}Container250KB${j} ${i}randomFile250KB${i}
# delete the file from local filesystem
rm ${i}randomFile250KB${i}
done
done
