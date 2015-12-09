declare -a arr_new
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
