#!/bin/bash
download_limit=70mbit

function start_tc {
        docker cp /root/lancache/tc-limit.sh lancache-monolithic-1:/scripts
        docker exec -it lancache-monolithic-1 /scripts/tc-limit.sh start $download_limit
}

function stop_tc {
        docker exec -it lancache-monolithic-1 /scripts/tc-limit.sh stop
}

function show_status {
        docker exec -it lancache-monolithic-1 /scripts/tc-limit.sh status
}

# Start
if [ -n "$2" ]; then
        download_limit=$2
fi
if [ -z "$1" ]; then
        display_help
elif [ "$1" == "start" ]; then
        start_tc
elif [ "$1" == "stop" ]; then
        stop_tc
elif [ "$1" == "status" ]; then
        show_status
else
       download_limit=$1
       start_tc
fi
