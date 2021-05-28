#!/bin/bash

export LD_LIBRARY_PATH=./lib


./apollo3d_kick --host $1 --port $2 --x $3 --y $4 --challenge $5> /dev/null 2> /dev/null &
