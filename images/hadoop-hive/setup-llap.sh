#!/bin/bash

cd /opt/hive
mkdir /opt/hive/llap
cd llap
hive --service llap --name llaptest --instances 1 --executors 5 --size 1024m