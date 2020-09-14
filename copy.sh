#!/bin/bash

# pull in env vars
source /etc/environment


DATE=`date +\%Y-\%m-\%d-\%H-\%M`
BACKUPDIR="influxdb-$DATE"
BACKUPFILE="influxdb-$DATE.tgz"

mkdir $BACKUPDIR
influxd backup -portable $BACKUPDIR

# backup to tmp dir
cd /tmp
influxd backup -portable -host ${INFLUX_HOST}:${INFLUX_PORT} $BACKUPDIR

# combine files
tar cfvz $BACKUPFILE $BACKUPDIR

# move to mount
mv $BACKUPFILE /mnt/

# clean up
rm -rf $BACKUPDIR
rm -rf $BACKUPFILE
