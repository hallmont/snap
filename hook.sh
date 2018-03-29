#!/bin/bash

if [ "$ACTION" = "download" ]; then
    #echo "Attached pic" | mutt -a $ARGUMENT -s "Test Pic" -- john@yahoo.com
    #gpicview $ARGUMENT &
    #~/Dropbox-Uploader/dropbox_uploader.sh upload $ARGUMENT dest_dir

    fbi -T 2 -a $ARGUMENT
fi

