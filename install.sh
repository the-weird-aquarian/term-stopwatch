#!/usr/bin/env bash

source ./common_utils.sh

chkRoot

echo "Installing ..."
cp stopwatch.sh /usr/bin/stopwatch
successFail

echo "Fixing permissions ..."
chmod +x /usr/bin/stopwatch
successFail

exit 0