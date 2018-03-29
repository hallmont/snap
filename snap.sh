num=0
while true
do
	PIC_DIR=~/Pictures
	SNAP_DIR=~/snap

	num=$((num+1))
	# FILENAME=$(date +image-%Y%m%d-%H%M%S.jpg)
	FILENAME=$(printf "image_%03d.jpg" $num)

	if [ -f $PIC_DIR/$FILENAME ]; then
		continue
	fi

	# Take picture
	gphoto2 --keep --capture-image-and-download \
	--filename $PIC_DIR/$FILENAME --hook-script $SNAP_DIR/hook.sh; rc=$?
	if [ $rc -eq 1 ]; then
		exit
	fi

	# Wait for image viewer to exit (user press ESC)
	while true
	do
		PID=$(ps -ef | grep "fbi" | grep -v grep | awk '{ print $2 }')
		if [ "$PID" = "" ]; then
		    break
		fi
		sleep 1
	done

	# Do countdown
        $SNAP_DIR/showtext; rc=$?
	if [ $rc -eq 1 ]; then
		exit
	fi
done

exit
