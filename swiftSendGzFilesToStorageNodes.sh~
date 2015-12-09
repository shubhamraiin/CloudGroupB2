#!/bin/bash
for i in {1..16} 
do
	echo "Storage Node- storageNode$i"
	scp /etc/swift/*.gz swift@storageNode$i:/etc/swift
done
