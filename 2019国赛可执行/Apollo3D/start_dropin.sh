#!/bin/bash
#
# Sample start script for 2015 3D Simulation Drop-In Player Challenge
#


AGENT_BINARY="apollo3d_dropin"
BINARY_DIR="."

export LD_LIBRARY_PATH=./lib

usage()
{
  (echo "Usage: $0 [options]"
   echo "Available options:"
   echo "  --help                       prints this"
   echo "  HOST                         specifies server host"
   echo "  -t, --team TEAMNAME          specifies team name"
   echo "  -u, --unum UNUM              specifies uniform number") 1>&2
}


fParsedHost=false

while [ $# -gt 0 ]
do
  case $1 in

    --help)
      usage
      exit 0
      ;;

    -t|--team)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      team="${2}"
      shift 1
      ;;
    
    -u|--unum)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      i="${2}"
      shift 1
      ;;
     
    *)
      if $fParsedHost;
      then
        echo 1>&2
        echo "invalid option \"${1}\"." 1>&2
        echo 1>&2
        usage
        exit 1
      else
        host="${1}"
	fParsedHost=true
      fi
      ;;
  esac

  shift 1
done



echo "Running agent No. $i"
"$BINARY_DIR/$AGENT_BINARY" --host $host --team $team --unum $i &> /dev/null &
#"$BINARY_DIR/$AGENT_BINARY" -h $host -t $team -u $i > log/stdout$i 2> log/stderr$i &
sleep 1


