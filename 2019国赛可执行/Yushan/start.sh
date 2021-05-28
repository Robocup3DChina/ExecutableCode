#!/bin/bash
#
# sample start script for 3D soccer simulation
#
AGENT_BINARY="YuShan3D"
BINARY_DIR="./"
NUM_PLAYERS=11
#killall -9 "$AGENT_BINARY" &> /dev/null
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:makelib/
echo "       YuShan3D_2015 3D soccer simulation team "
echo ""
for ((i=1;i<=$NUM_PLAYERS ;i++)); do
echo "Running agent No. $i"
"$BINARY_DIR/$AGENT_BINARY" -s 192.168.2.22 -t YuShan3D -u $i > /dev/null 2> /dev/null&
sleep 1.0
done
