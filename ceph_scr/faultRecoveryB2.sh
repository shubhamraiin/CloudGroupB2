#!/bin/bash
# create sample file for fault tolerance testing

mkdir dataFile
cd dataFile

dd if=/dev/urandom of=randomfile1 bs=4M count=250 conv=fdatasync

# upload file on ceph

rados -p test_rados put randomfile1 randomfile1

start_time=$(date -u +"%s%3N")
lookupout=`ceph osd map test_rados randomfile1`
stop_time=$(date -u +"%s%3N")

#Evaluating the lookup time
echo "Lookup time: $(($stop_time-$start_time)) ms"


echo "Lookup Output"
echo $lookupout

echo "Parsing the osd Lookup output"
partialNodeIds=`echo $lookupout| sed -n -e 's/^.*acting //p'`
echo "Extracting Node Ids"
nodeIds=`echo $partialNodeIds | cut -d "[" -f2 | cut -d "]" -f1`
echo $nodeIds

IFS=',' read -r -a array <<< "$nodeIds" 


echo "Node Ids"
echo "${array[@]}"


declare -a arr_new
counter=0
for i in "${array[@]}"
do
	#echo $i
	#echo $counter
        if [ $i == 0 ] 
	then 
		arr_new[$counter]="ceph-node2"
        elif [ $i == 1 ] 
	then 
		arr_new[$counter]="ceph-node4"
	        
	elif [ $i == 2 ] 
	then 
		arr_new[$counter]="ceph-node1"
	        
	elif [ $i == 3 ] 
	then 
		arr_new[$counter]="ceph-node6"
        
	elif [ $i == 4 ] 
	then 
		arr_new[$counter]="ceph-node5"
	        
	elif [ $i == 5 ] 
	then 
		arr_new[$counter]="ceph-node7"
	        
	elif [ $i == 6 ] 
	then 
		arr_new[$counter]="ceph-node8"
	        
	elif [ $i == 7 ] 
	then 
		arr_new[$counter]="ceph-node9"
	        
	elif [ $i == 8 ] 
	then 
		arr_new[$counter]="ceph-node10"        
	else arr_new[$counter]="ceph-node10"
        fi
        let counter++
done
echo "${arr_new[@]}"

echo "\n----- ZERO osd down-----"

start_time=$(date -u +"%s%3N")
#ceph osd map test_rados randomfile1
rados -p test_rados get randomfile1 test0.out
stop_time=$(date -u +"%s%3N")

#Evaluating the fault recovery time
echo "Read time: $(($stop_time-$start_time)) ms"



echo "\n-----1 osd down-----"

ceph osd out ${array[0]}


start_time=$(date -u +"%s%3N")
#ceph osd map test_rados randomfile1
rados -p test_rados get randomfile1 test1.out
stop_time=$(date -u +"%s%3N")

#Evaluating the fault recovery time
echo "Read time: $(($stop_time-$start_time)) ms"

#remove out file
#rm -rf test1.out

#osd is added in cluster

ceph osd in ${array[0]}


echo "\n-----2 osds down-----"

ceph osd out ${array[0]}

ceph osd out ${array[1]}

start_time=$(date -u +"%s%3N")
#ceph osd map test_rados randomfile1
rados -p test_rados get randomfile1 test2.out
stop_time=$(date -u +"%s%3N")

#Evaluating the fault recovery time
echo "Read time: $(($stop_time-$start_time)) ms"

#remove out file
#rm -rf test2.out

ceph osd in ${array[0]}
ceph osd in ${array[1]}

echo "\n-----3 osds down-----"

ceph osd out ${array[0]}

ceph osd out ${array[1]}

ceph osd out ${array[2]}

start_time=$(date -u +"%s%3N")
#ceph osd map test_rados randomfile1
rados -p test_rados get randomfile1 test3.out
stop_time=$(date -u +"%s%3N")

#Evaluating the fault recovery time
echo "Read time: $(($stop_time-$start_time)) ms"

#remove out file
#rm -rf test3.out

ceph osd in ${array[0]}
ceph osd in ${array[1]}
ceph osd in ${array[2]}

#cleanup
cd ..
rm -rf dataFile
