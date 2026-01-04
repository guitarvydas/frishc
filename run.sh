#!/bin/zsh
if [ -f out.✗ ]; then
    cat out.✗
else
    python $1
fi
