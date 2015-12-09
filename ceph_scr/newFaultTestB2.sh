#!/bin/bash



# create sample file for fault tolerance testing

dd if=/dev/urandom of=randomfile1 bs=4M count=10 conv=fdatasync

# upload file on ceph

rados -p test_rados put randomfile1 randomfile1



# store the output of the get nodes in a file

lookupout=`ceph osd map test_rados randomFile1`


echo "Lokkup Output"
echo $lookupout


echo "Parsing the osd Lookup output"
partialNodeIds=`echo $lookupout| sed -n -e 's/^.*acting //p'`
echo "Extracting Node Ids"
nodeIds=`echo $partialNodeIds | cut -d "[" -f2 | cut -d "]" -f1`
echo $nodeIds

IFS=',' read -r -a array <<< "$nodeIds" 


echo "Node Ids"
echo "${array[@]}"


echo ${array[0]}
echo ${array[1]}
echo ${array[2]}

declare -a arr_new
counter=0
for i in ${array[@]} 
do
        echo "value of i= $i"
	if [ $i == 0 ] 
	then 
		arr_new[$counter]="ceph-node2"
        elif [ $i == 1 ] 
	then 
		arr_new[$counter]="ceph-node4"
        else 
		arr_new[$counter]="ceph-node10"
        fi
	echo "counter value= $counter"
       let counter++ 
done
echo ${arr_new[@]}


#cleanup
cd ..
rm -rf randomFile1
	
