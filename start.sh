#!/bin/sh

# write out environment file
printenv >> /etc/environment

#start cron
cron -f