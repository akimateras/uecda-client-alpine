#!/bin/sh
set -eu

if [ $# -lt 2 ]; then
    echo 'At least 2 arguments are required.'
    echo 'usage: <directory> <commands...>'
    return 1
fi

WORKDIR=$1
COMMAND=`echo $@ | sed -E "s:^${WORKDIR}\s+::"`

echo "DIRECTORY: $WORKDIR"
echo "COMMAND  : $COMMAND"

cd $WORKDIR
exec $COMMAND
