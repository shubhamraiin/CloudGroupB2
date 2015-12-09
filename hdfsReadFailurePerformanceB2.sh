#!/bin/bash
function hdfsRead {
        #start recording read time
        startRead=$(date -u +"%s")
	pathValue="$($hdfsPath dfs -find / -name zerofile)"
        $hdfsPath dfs -get $pathValue
        returnValue=$?
        #stop recording read time
        stopRead=$(date -u +"%s")

        if [ "$returnValue" == 0 ]
        then
                #output the read time
                echo "Read Time: $(($stopRead-$startRead)) second"
                echo "Read Time After Failure, $(($stopRead-$startRead))" >> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
        else
                echo "Error while reading. Time taken:: $(($stopRead-$startRead))" 
                echo "Read Time After Failure(Error while reading), $(($stopRead-$startRead))" >> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
        fi
	rm zerofile
}
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create sample file for testing
mkdir writeTest
dd if=/dev/zero of=writeTest/zerofile bs=$1 count=$2 conv=fdatasync
$hdfsPath dfs -put writeTest /hdfsWriteTest

rm -R writeTest

#Get the block distribution of the file written on datanodes
pathVal="$($hdfsPath dfs -find / -name zerofile)"
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
block18=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.68"))
block19=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.69"))
block20=($($hdfsPath fsck $pathVal -files -blocks -locations | grep -c "10.176.128.70"))

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
	["10.176.128.67"]=$block17
	["10.176.128.67"]=$block18
	["10.176.128.67"]=$block19
	["10.176.128.67"]=$block20)

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
echo "First Datanode: ${ips1[0]}"
ip1=${ips1[0]}

ip2=${ipArray[1]}
IFS=' ' read -ra ips2 <<< "$ip2"
echo "Second Datanode: ${ips2[0]}"
ip2=${ips2[0]}

ip3=${ipArray[2]}
IFS=' ' read -ra ips3 <<< "$ip3"
echo "Third Datanode: ${ips3[0]}"
ip3=${ips3[0]}

echo "Reading before failure.......">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

#Stop data nodes that contain maximum blocks
ssh hduser@$ip1 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh stop datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh stop nodemanager; jps; exit"
ssh hduser@$ip2 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh stop datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh stop nodemanager; jps; exit"
ssh hduser@$ip3 "bash /usr/local/hadoop/sbin/hadoop-daemon.sh stop datanode; bash /usr/local/hadoop/sbin/yarn-daemon.sh stop nodemanager; jps; exit"

echo "Starting to read after failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

# Sleep for every 3 minutes and then issue a read request
sleep 3m
echo "Reading after 3 mins of failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

sleep 3m
echo "Reading after 6 mins of failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

sleep 3m
echo "Reading after 9 mins of failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

sleep 3m
echo "Reading after 12 mins of failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

sleep 3m
echo "Reading after 15 mins of failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

sleep 3m
echo "Reading after 18 mins of failure...">> /home/hduser/Desktop/ReqGenOutput/hdfsWriteOutput.xls
hdfsRead

$hdfsPath dfs -rm -R /hdfsWriteTest
