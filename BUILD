#!/bin/bash

### frishc ###

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
${dtree_tool}/@make ${dtree_tool} "xinterpret" $PBPCALLER

