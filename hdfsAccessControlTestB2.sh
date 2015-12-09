#!/bin/bash
export hdfsPath=/usr/local/hadoop/bin/hdfs

#create empty directory to push to $hdfsPath
mkdir testAccessControl

#push empty directory to $hdfsPath
$hdfsPath dfs -put testAccessControl /testAccessControl

#start recording Access read time
startAccessRead=$(date -u +"%s")

$hdfsPath dfs -getfacl -R /testAccessControl

#stop recording Access read time
stopAccessRead=$(date -u +"%s")

#output the Access read time
echo "Access Read time :: $(($stopAccessRead-$startAccessRead)) seconds"
echo "Access Read time, $(($stopAccessRead-$startAccessRead))" >> hdfsParamOutput.xls

#remove test data
rm -r -f testAccessControl
$hdfsPath dfs -rm -R /testAccessControl
