#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=writeTest/zerofile bs=$1 count=$2 conv=fdatasync
$hdfsPath dfs -put writeTest /hdfsWriteTest

#Get the block distribution of the file written on datanodes
pathVal="$($hdfsPath dfs -find / -name zerofile)"
echo "pathVal= $pathVal"
block1=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.21"))
block2=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.22"))
block3=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.23"))
block4=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.52"))
block5=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.53"))
block6=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.63"))
block7=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.64"))

#Create an associative array of [IP] and [block distribution]
declare -A blocksIP
blocksIP=(["10.176.128.21"]=$block1 ["10.176.128.22"]=$block2 ["10.176.128.23"]=$block3 ["10.176.128.52"]=$block4 ["10.176.128.53"]=$block5 ["10.176.128.63"]=$block6 ["10.176.128.64"]=$block7)
echo "${blocksIP[@]}"

#Sort the associative array in the descending order of number of blocks
ipArray=()
IFS=$'\n'
set -f
ipArray=($(
	for key in "${!blocksIP[@]}"
	do
		printf '%s %s\n' "$key" "${blocksIP[$key]}"
#	done | sort -t : -k 2n | sed 's/:.*//'))
	done | sort -k2nr | sed 's/:.*//'))
unset IFS
set +f

#Get the top 3 datanode IPs
#echo "${ipArray[@]}"
ip1=${ipArray[0]}
IFS=' ' read -ra ips1 <<< "$ip1"
echo "${ips1[0]}"
ip1=${ips1[0]}

ip2=${ipArray[1]}
IFS=' ' read -ra ips2 <<< "$ip2"
echo "${ips2[0]}"
ip2=${ips2[0]}

ip3=${ipArray[2]}
IFS=' ' read -ra ips3 <<< "$ip3"
echo "${ips3[0]}"
ip3=${ips3[0]}

#Stop data nodes that contain maximum blocks
ssh hduser@$ip1 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh stop datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh stop nodemanager; jps; exit"
ssh hduser@$ip2 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh stop datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh stop nodemanager; jps; exit"
ssh hduser@$ip3 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh stop datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh stop nodemanager; jps; exit"

#start recording read time
startRead=$(date -u +"%s")
$hdfsPath dfs -get $pathVal
returnValue=$?
#stop recording read time
stopRead=$(date -u +"%s")

if [ "$returnValue" == 0 ]
then
	#output the read time
	echo "Read Time: $(($stopRead-$startRead)) second"
	echo "Read Time After Failure, $(($stopRead-$startRead))" >> hdfsParamOutput.xls
else
	echo "Error while reading. Time taken:: $(($stopRead-$startRead))" 
	echo "Read Time After Failure(Error while reading), $(($stopRead-$startRead))" >> hdfsParamOutput.xls
fi
rm -r -f writeTest
$hdfsPath dfs -rm -R $writeFilePath
rm zerofile

#Start data nodes
ssh hduser@$ip1 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh start datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh start nodemanager; jps; exit"
ssh hduser@$ip2 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh start datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh start nodemanager; jps; exit"
ssh hduser@$ip3 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh start datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh start nodemanager; jps; exit"
