#!/bin/bash -e
#
# Copyright (c) 2018-present Sonatype, Inc. All rights reserved.
# "Sonatype" is a trademark of Sonatype, Inc.
#

basename=`basename $0`
dirname=`dirname $0`
dirname=`cd "$dirname" && pwd`
cd "$dirname"

exec ./service.sh server ../etc/service.yml
