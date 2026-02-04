#!/bin/bash
# frish
rm -f out.*
rm -f *.json
set -e
export SHELLOPTS
export PBP="${HOME}/projects/pbp-dev"
export PBPHERE="$(pwd)"
export PBPCALLER=$PBPHERE
export PYTHONPATH="${PBP}/kernel:${PYTHONPATH}"
###
export tool=${HOME}/projects/dtree

echo
echo '@@@@@ frishc BUILD @@@@@'
for i in PBP PBPHERE PBPCALLER tool PYTHONPATH
do
    echo "$i = ${!i}"
done
echo '@@@@@'
echo

${tool}/RUN "xinterpret" $tool $PBPCALLER