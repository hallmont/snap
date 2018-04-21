#! /bin/bash

PIC_DIR=~/Pictures
SNAP_DIR=~/snap

DO_COUNTDOWN=1
TEMPLATE_FILE=""

while [[ "$#" > 0 ]]; do case $1 in
  -c|--composite) TEMPLATE_FILE="$2"; shift;;
  -n|--no_countdown) DO_COUNTDOWN=0;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

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

if [ $DO_COUNTDOWN -eq 1 ]; then
    # Do countdown
    $SNAP_DIR/showtext; rc=$?
    if [ $rc -eq 1 ]; then
        exit
    fi
fi

FILENAME=$(getFileName)

# Take picture
cd /tmp
gphoto2 --keep --capture-image-and-download \
--filename $PIC_DIR/$FILENAME --hook-script $SNAP_DIR/hook.sh; rc=$?
if [ $rc -eq 1 ]; then
    exit
fi

COMPOSITE_FILE=/tmp/output.png

if [ "$TEMPLATE_FILE" != "" ]; then
    composite -gravity center $TEMPLATE_FILE $PIC_DIR/$FILENAME $COMPOSITE_FILE
    $SNAP_DIR/viewer.sh $COMPOSITE_FILE
fi

exit
