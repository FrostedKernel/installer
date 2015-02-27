#!/sbin/sh
val=$(cat /tmp/aroma-data/scheduler.prop | cut -d"=" -f2)
case $val in
  1)
    scheduler="bfq"
    ;;
  2)
    scheduler="cfq"
    ;;
  3)
    scheduler="deadline"
    ;;
  4)
    scheduler="fifo"
    ;;
  5)
    scheduler="fiops"
    ;;
  6)
    scheduler="noop"
    ;;
  7)
    scheduler="row"
    ;;
  8)
    scheduler="sio"
    ;;
  9)
    scheduler="sioplus"
    ;;
  10)
    scheduler="tripndroid"
    ;;
  11)
    scheduler="vr"
    ;;
  12)
    scheduler="zen"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="scheduler="
scheduler="scheduler="$scheduler
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/scheduler=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $scheduler>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $scheduler>/tmp/boot.img-cmdline
	;;
esac
