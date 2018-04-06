#! /bin/bash

killViewer()
{
    PID=$(ps -ef | grep "fbi" | grep -v grep | awk '{ print $2 }')
    if [ "$PID" != "" ]; then
        kill $PID
    fi
}

killViewer
