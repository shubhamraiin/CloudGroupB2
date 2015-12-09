#!/bin/sh

# Script to test the lookup for Ceph
# File Returns the Object Handle for given object
# Input: Object Name
# Output: Object Handle along with the placement groups and OSD ids to which it belongs
# Dump Sample Data in ceph cluster
# Author: Pavan Dixit
# ------------------------------------------------------------------

mkdir ./cephData
rados mkpool radosLookup
#ceph osd pool set radosLookup size 3

        for i in {1..2}
        do
                FILE="./cephData/file-$i"
                touch "$FILE.txt"
                echo `dd if=/dev/zero of=$FILE.txt bs=100MB count=2 conv=fdatasync`
                rados -p radosLookup put $FILE $FILE.txt
        done




start_time=$(date -u +"%s%3N")
ceph osd map radosLookup $1
stop_time=$(date -u +"%s%3N")

#Evaluating the lookup time
echo "Lookup time: $(($stop_time-$start_time)) ms"

#Cleanup
rados rmpool radosLookup radosLookup --yes-i-really-really-mean-it
rm -rf ./cephData
