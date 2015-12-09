#!/bin/bash
#create sample file for testing

#if [ "$1" eq 0 ]

counter1=1
counter2=1
while [ "$counter1" -lt 15 ]
do
  bash $1 64000 $counter2
  counter1=$((counter1+1))
  counter2=$((counter2*2))
done
