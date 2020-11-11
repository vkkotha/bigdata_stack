#!/bin/bash
cd "${0%/*}"
docker-compose -f ../docker-compose.yml exec hive-server sh -c /opt/hive/bin/setup-llap.sh
