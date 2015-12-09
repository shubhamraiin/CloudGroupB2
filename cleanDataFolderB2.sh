#!/bin/bash
rm -r -f /app/hadoop/tmp/dfs/data
rm -r -f /app/hadoop/tmp/dfs/name
ssh hdfsSlave1 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave2 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave3 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave4 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave5 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave6 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave7 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave8 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave9 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave10 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave11 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave12 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave13 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave14 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave15 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave16 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
ssh hdfsSlave17 "rm -r -f /app/hadoop/tmp/dfs/data;exit"
/usr/local/hadoop/bin/hadoop namenode -format


