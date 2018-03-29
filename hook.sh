#!/bin/bash

if [ "$ACTION" = "download" ]; then
    #echo "Attached pic" | mutt -a $ARGUMENT -s "Test Pic" -- nguyenj2@yahoo.com
    #gpicview $ARGUMENT &
    #~/Dropbox-Uploader/dropbox_uploader.sh upload $ARGUMENT Jason_11th_Birthday &

    fbi -T 2 -a $ARGUMENT
fi

