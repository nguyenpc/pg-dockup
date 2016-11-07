#!/bin/bash

./backup.sh

if [ -n "$CRON_TIME" ]; then
  # force set environment vars 
  env > /etc/environment
  
  # create brand new crontab.conf
  if [ -n "$CRON_MAILTO" ]; then
    echo "MAILTO=\"$CRON_MAILTO\"" > /crontab.conf
  else
    echo "" > /crontab.conf
  fi

  # configure cron
  echo "$CRON_TIME $DIR/backup.sh" >> /crontab.conf
  crontab  /crontab.conf
  echo "=> Running dockup backups as a cronjob for $CRON_TIME"
  echo "=> Output will be mailed to $CRON_MAILTO"
  exec cron -f
fi
