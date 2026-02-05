#!/bin/bash
rm -f out.*
rm -f *.json
set -e
export SHELLOPTS
export PBP=~/projects/pbp-dev
export PBPHERE=$(pwd)
export PYTHONPATH="${PBP}/kernel:${PYTHONPATH}"
fname="$1"
