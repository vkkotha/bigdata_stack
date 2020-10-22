#!/bin/bash

hdfs dfs -mkdir -p /apps/tez
hdfs dfs -chmod -R 755 /apps/tez 
# hdfs dfs -chown -R hadoop:users /apps/tez 
hdfs dfs -copyFromLocal -f ${TEZ_HOME}/tez-dist/tez-${TEZ_VERSION}.tar.gz /apps/tez/tez-${TEZ_VERSION}.tar.gz

hdfs dfs -mkdir -p /apps/aws
hdfs dfs -chmod -R 755 /apps/aws 
hdfs dfs -copyFromLocal -f ${HADOOP_PREFIX}/share/hadoop/tools/lib/*aws*.jar /apps/aws