#!/bin/bash
echo >/tmp/pbplog.md
echo >>/tmp/pbplog.md
echo '--- in FRISH ---' >>/tmp/pbplog.md
echo >>/tmp/pbplog.md
rm -f out.*
rm -f *.json
set -e
export SHELLOPTS
export PBP="${HOME}/projects/pbp-dev"
export PBPWD="$(pwd)"
export PBPCALLER=$PBPWD
export PYTHONPATH="${PBP}/kernel:${PYTHONPATH}"
###
export tool=${HOME}/projects/dtree

echo >>/tmp/pbplog.md
echo '@@@@@ frishc BUILD @@@@@' >>/tmp/pbplog.md
for i in PBP PBPWD PBPCALLER tool PYTHONPATH
do
    echo "$i = ${!i}" >>/tmp/pbplog.md
done
echo '@@@@@' >>/tmp/pbplog.md
echo >>/tmp/pbplog.md

${tool}/RUN "xinterpret" $tool $PBPCALLER
