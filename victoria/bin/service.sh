#!/bin/bash -e
#
# Copyright (c) 2018-present Sonatype, Inc. All rights reserved.
# "Sonatype" is a trademark of Sonatype, Inc.
#

basename=`basename $0`
dirname=`dirname $0`
dirname=`cd "$dirname" && pwd`
cd "$dirname"

tmpdir=../tmp
if [ ! -d "$tmpdir" ]; then
  mkdir -p "$tmpdir"
fi

logdir=../log
if [ ! -d "$logdir" ]; then
  mkdir -p "$logdir"
fi
export SERVICE_LOGDIR="$logdir"

dbdir=../db
if [ ! -d "$dbdir" ]; then
  mkdir -p "$dbdir"
fi
export SERVICE_DBDIR="$dbdir"

#export SERVICE_LOG_LEVEL=DEBUG
export SERVICE_LOG_CONSOLE_THRESHOLD=DEBUG

exec java \
  -Djava.io.tmpdir="$tmpdir" \
  -Djava.awt.headless=true \
  -Djava.net.preferIPv4Stack=true \
  -jar ../lib/service.jar \
  "$@"
