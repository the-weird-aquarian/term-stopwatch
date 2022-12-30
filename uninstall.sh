#!/usr/bin/env bash

source ./common_utils.sh

chkRoot

if [ -f /usr/bin/stopwatch ]
then
  echo "Uninstalling ..."
  rm /usr/bin/stopwatch
  successFail
else
  echo "File doesn't exist"
fi

exit 0