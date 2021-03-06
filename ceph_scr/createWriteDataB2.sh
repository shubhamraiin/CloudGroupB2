faultTest.sh                                                                                        0000755 0000000 0000000 00000003504 12631420550 012066  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   #!/bin/bash



# create sample file for fault tolerance testing
mkdir dataFile
cd dataFile


dd if=/dev/urandom of=randomfile1 bs=128M count=8 conv=fdatasync



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

ceph osd out ${array[0]}

ceph osd out ${array[1]}

start_time=$(date -u +"%s%3N")
ceph osd map test_rados randomfile1
stop_time=$(date -u +"%s%3N")

#Evaluating the lookup time
echo "Lookup time: $(($stop_time-$start_time)) ms"

ceph osd in ${array[0]}
ceph osd in ${array[1]}

#cleanup
cd ..
rm -rf dataFile
                                                                                                                                                                                            newFaultTest.sh                                                                                     0000755 0000000 0000000 00000002044 12631420550 012536  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   #!/bin/bash



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
	
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            test.sh                                                                                             0000755 0000000 0000000 00000001240 12631420551 011066  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   declare -a arr_new
i=0
counter=0
while [ "$counter" -lt 3 ]
do
	if [ array[i]=0 ] then arr_new[$counter]=ceph-node2
	elif [ array[i]=1 ] then arr_new[$counter]=ceph-node4
	elif [ array[i]=2 ] then arr_new[$counter]=ceph-node1
	elif [ array[i]=3 ] then arr_new[$counter]=ceph-node6
	elif [ array[i]=4 ] then arr_new[$counter]=ceph-node5
	elif [ array[i]=5 ] then arr_new[$counter]=ceph-node7
	elif [ array[i]=6 ] then arr_new[$counter]=ceph-node8
	elif [ array[i]=7 ] then arr_new[$counter]=ceph-node9
	elif [ array[i]=8 ] then arr_new[$counter]=ceph-node10
	elif [ array[i]=9 ] then arr_new[$counter]=ceph-node10
	fi
	i=$i+1
	counter=$counter+1
done	
echo "${arr_new[@]}"
                                                                                                                                                                                                                                                                                                                                                                writeToCeph.py                                                                                      0000755 0000000 0000000 00000002361 12631420551 012367  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   import rados, sys

#Create Handle Examples.
cluster = rados.Rados(conffile='/etc/ceph/ceph.conf')
#cluster = rados.Rados(conffile=sys.argv[1])
cluster = rados.Rados(conffile = '/etc/ceph/ceph.conf', conf = dict (keyring = '/etc/ceph/ceph.client.admin.keyring'))

print "\nlibrados version: " + str(cluster.version())
print "Will attempt to connect to: " + str(cluster.conf_get('mon initial members'))

cluster.connect()
print "\nCluster ID: " + cluster.get_fsid()

print "\n\nCluster Statistics"
print "=================="
cluster_stats = cluster.get_cluster_stats()

for key, value in cluster_stats.iteritems():
	print key, value

#Pool Operations
print "\n\nPool Operations"
print "==============="

print "\nAvailable Pools"
print "----------------"
pools = cluster.list_pools()

for pool in pools:
	print pool

print "\nCreate 'test' Pool"
print "------------------"
cluster.create_pool('test')

print "\nPool named 'test' exists: " + str(cluster.pool_exists('test'))
print "\nVerify 'test' Pool Exists"
print "-------------------------"
pools = cluster.list_pools()

for pool in pools:
	print pool

print "\nDelete 'test' Pool"
print "------------------"     
cluster.delete_pool('test')
print "\nPool named 'test' exists: " + str(cluster.pool_exists('test'))
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               