#!/bin/bash
echo
echo '--- in FRISH ---'
echo
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

echo
echo '@@@@@ frishc BUILD @@@@@'
for i in PBP PBPWD PBPCALLER tool PYTHONPATH
do
    echo "$i = ${!i}"
done
echo '@@@@@'
echo

${tool}/RUN "xinterpret" $tool $PBPCALLER
