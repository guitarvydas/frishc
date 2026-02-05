#!/bin/bash
rm -f out.*
rm -f *.json
set -e
export SHELLOPTS
export PBP="${HOME}/projects/pbp-dev"
export PBPWD="$(pwd)"
export PBPCALLER=$PBPWD
export PYTHONPATH="${PBP}/kernel:${PYTHONPATH}"
###
export dtree_tool=${HOME}/projects/dtree
${PBP}/resetlog

# create xinterpret.frish from xinterpret.drawio
${dtree_tool}/RUN "xinterpret" $dtree_tool $PBPCALLER

