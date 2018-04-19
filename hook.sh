#!/bin/bash

. ~/snap/.google

if [ "$ACTION" = "download" ]; then
    #echo "Attached pic" | mutt -a $ARGUMENT -s "Test Pic" -- john@yahoo.com
    #gpicview $ARGUMENT &
    #~/Dropbox-Uploader/dropbox_uploader.sh upload $ARGUMENT dest_dir

    if [ "$GOOGLE_USER" != "" -a "$GOOGLE_USER" != "myuser" ]; then
        upload-gphotos $ARGUMENT -u "$GOOGLE_USER" -p "$GOOGLE_PASS" -a "$ALBUM" &
    fi

    fbi -T 2 -a $ARGUMENT
fi

