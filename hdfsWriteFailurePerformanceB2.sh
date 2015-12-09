#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest1
dd if=/dev/zero of=writeTest1/zerofile1 bs=$1 count=$2 conv=fdatasync
$hdfsPath dfs -put writeTest1 /hdfsWriteTest1

rm -R writeTest1

#Get the block distribution of the file written on datanodes
pathVal="$($hdfsPath dfs -find / -name zerofile1)"
echo "pathVal= $pathVal"
block1=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.100"))
block2=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.22"))
block3=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.23"))
block4=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.52"))
block5=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.53"))
block6=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.63"))
block7=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.64"))
block8=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.37"))
block9=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.38"))
block10=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.24"))
block11=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.25"))
block12=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.54"))
block13=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.55"))
block14=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.56"))
block15=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.65"))
block16=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.66"))
block17=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.67"))

#Create an associative array of [IP] and [block distribution]
declare -A blocksIP
blocksIP=(
	["10.176.128.100"]=$block1
	["10.176.128.22"]=$block2
	["10.176.128.23"]=$block3
	["10.176.128.52"]=$block4
	["10.176.128.53"]=$block5
	["10.176.128.63"]=$block6
	["10.176.128.64"]=$block7
	["10.176.128.37"]=$block8
	["10.176.128.38"]=$block9
	["10.176.128.24"]=$block10
	["10.176.128.25"]=$block11
	["10.176.128.54"]=$block12
	["10.176.128.55"]=$block13
	["10.176.128.56"]=$block14
	["10.176.128.65"]=$block15
	["10.176.128.66"]=$block16
	["10.176.128.67"]=$block17)

#echo "${blocksIP[@]}"

#Sort the associative array in the descending order of number of blocks
ipArray=()
IFS=$'\n'
set -f
ipArray=($(
	for key in "${!blocksIP[@]}"
	do
		printf '%s %s\n' "$key" "${blocksIP[$key]}"
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

echo "Starting to Write after failure..."
bash hdfsWriteTest.sh 1M 500

# Sleep for 3 minutes and then issue a write request
sleep 3m
echo "Write after 3 mins of failure..."
bash hdfsWriteTest.sh 1M 500

sleep 3m
echo "Write after 6 mins of failure..."
bash hdfsWriteTest.sh 1M 500

sleep 3m
echo "Write after 9 mins of failure..."
bash hdfsWriteTest.sh 1M 500

sleep 3m
echo "Write after 12 mins of failure..."
bash hdfsWriteTest.sh 1M 500

sleep 3m
echo "Write after 15 mins of failure..."
bash hdfsWriteTest.sh 1M 500

sleep 3m
echo "Write after 18 mins of failure..."
bash hdfsWriteTest.sh 1M 500

$hdfsPath dfs -rm -R /hdfsWriteTest1
