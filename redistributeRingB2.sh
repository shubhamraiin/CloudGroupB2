#!/bin/bash
# SSH to the host machine of swift storage nodes and proxy node without password(Added the key)
#Start the storage nodes
echo -e "\n\n ******** Starting Swift *********"
echo -e "\n Starting proxynode and storagenode 16"
sleep 2s
ssh groupb@groupb23 "virsh start storageNode16; sleep 5s; ssh swift@storageNode16 \"rm -R /etc/swift/*.gz; sudo scp swift@proxynode:/etc/swift/*.gz /etc/swift; exit;\"; exit"

echo -e "\n Starting storagenode 1,2,3,4 and 5"
sleep 2s
ssh groupb@groupb13 "virsh start storageNode5; sleep 5s; ssh swift@storageNode5 \"rm -R /etc/swift/*.gz; sudo scp swift@proxynode:/etc/swift/*.gz /etc/swift; exit;\"; exit"

echo -e "\n Starting storagenode 6,7,8,9 and 10"
sleep 2s
ssh groupb@groupb22 "virsh start storageNode6; sleep 5s; ssh swift@storageNode6 \"rm -R /etc/swift/*.gz; sudo scp swift@proxynode:/etc/swift/*.gz /etc/swift; exit;\"; exit"

echo -e "\n\n ******** removed gz from 75,76,86********"
