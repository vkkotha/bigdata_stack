#!/bin/bash

datadir=`echo $HDFS_CONF_dfs_datanode_data_dir | perl -pe 's#file://##'`
if [ ! -d $datadir ]; then
  echo "Datanode data directory not found: $datadir"
  exit 2
fi

$HADOOP_PREFIX/bin/yarn --config $HADOOP_CONF_DIR nodemanager &
$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR datanode
