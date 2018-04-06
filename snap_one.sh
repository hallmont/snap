#! /bin/bash

PIC_DIR=~/Pictures
SNAP_DIR=~/snap

killViewer()
{
    PID=$(ps -ef | grep "fbi" | grep -v grep | awk '{ print $2 }')
    if [ "$PID" != "" ]; then
        kill $PID
    fi
}

getFileName()
{
    num=0
    typeset FILENAME
    while true
    do
        num=$((num+1))
        FILENAME=$(printf "image_%03d.jpg" $num)

        if [ -f $PIC_DIR/$FILENAME ]; then
            continue
        else
            break
        fi
    done

    echo $FILENAME
}

killViewer

export DISPLAY=:0
# Do countdown
$SNAP_DIR/showtext; rc=$?
if [ $rc -eq 1 ]; then
    exit
fi

FILENAME=$(getFileName)

# Take picture
cd /tmp
gphoto2 --keep --capture-image-and-download \
--filename $PIC_DIR/$FILENAME --hook-script $SNAP_DIR/hook.sh; rc=$?
if [ $rc -eq 1 ]; then
    exit
fi

exit
