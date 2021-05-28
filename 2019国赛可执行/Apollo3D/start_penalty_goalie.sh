#!/bin/bash
#
# RoboCup 2015 penalty start script for 3D Simulation Competitions
#

AGENT_BINARY=penalty-keeper

export LD_LIBRARY_PATH=./lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:makelibs

./$AGENT_BINARY --host $1 > /dev/null 2> /dev/null &
