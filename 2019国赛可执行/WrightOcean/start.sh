#!/bin/bash
#
# WrightOcean start script for 3D Simulation Competitions
#


AGENT_BINARY=./WrightOcean
#二进制目录
BINARY_DIR="."
#libs目录
LIBS_DIR="./libs"
NUM_PLAYERS=11

team="WrightOcean"
#主机“本地主机”
host="localhost"
#端口
port=3100
#参数文件
paramsfile=paramfiles/defaultParams.txt
mhost="localhost"
#临时设置程序共享库位置(不同)
export LD_LIBRARY_PATH=$LIBS_DIR:$LD_LIBRARY_PATH


usage()
{
  (echo "Usage: $0 [options]"
   echo "Available options:"
   echo "  --help                       prints this"
   echo "  HOST                         specifies server host (default: localhost)"
   echo "  -p, --port PORT              specifies server port (default: 3100)"
   echo "  -t, --team TEAMNAME          specifies team name"
   echo "  -mh, --mhost HOST            IP of the monitor for sending draw commands (default: localhost)"
   echo "  -pf, --paramsfile FILENAME   name of a parameters file to be loaded (default: paramfiles/defaultParams.txt)") 1>&2
}

#解析主机
fParsedHost=false
paramsfile_args="--paramsfile ${paramsfile}"
#n1 -gt n2             大于
while [ $# -gt 0 ]
do
  case $1 in

    --help)
      usage
      exit 0
      ;;

    -mh|--mhost)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      mhost="${2}"
      shift 1
      ;;

    -p|--port)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      port="${2}"
      shift 1
      ;;

    -t|--team)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      team="${2}"
      shift 1
      ;;

    -pf|--paramsfile)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      DIR_PARAMS="$( cd "$( dirname "$2" )" && pwd )"
      PARAMS_FILE=$DIR_PARAMS/$(basename $2)
      paramsfile_args="${paramsfile_args} --paramsfile ${PARAMS_FILE}"
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

opt="${opt} --host=${host} --port ${port} --team ${team} ${paramsfile_args} --mhost=${mhost}"

DIR="$( cd "$( dirname "$0" )" && pwd )" 
cd $DIR

for ((i=1;i<=$NUM_PLAYERS;i++)); do
    case $i in
	1|8|3|4|5|9|11)
	    echo "Running agent No. $i -- Type 1"
   	  #  "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 2 --paramsfile paramfiles/defaultParams_t2.txt &#> /dev/null &
	     "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 1 --paramsfile paramfiles/defaultParams_t1.txt &#> /dev/null &
	  #  "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 0 --paramsfile paramfiles/defaultParams_t0.txt > stdout$i 2> stderr$i &
	    ;;
	7|2)
	    echo "Running agent No. $i -- Type 3"
	    "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 3 --paramsfile paramfiles/defaultParams_t3.txt &#>  /dev/null &
	  #  "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 1 --paramsfile paramfiles/defaultParams_t1.txt > stdout$i 2> stderr$i &
	    ;;

	6|10)
	   echo "Running agent No. $i -- Type 4"
	   "$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 4  --paramsfile paramfiles/defaultParams_t4.txt &#> /dev/null &
	    #"$BINARY_DIR/$AGENT_BINARY" $opt --unum $i --type 4 --paramsfile paramfiles/defaultParams_t4.txt > stdout$i 2> stderr$i &
	    ;;
	
    esac
    sleep 1
done


