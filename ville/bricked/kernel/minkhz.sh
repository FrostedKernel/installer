#!/sbin/sh
val=$(cat /tmp/aroma-data/minkhz.prop | cut -d"=" -f2)
case $val in
  1)
    minkhz="192000"
    ;;
  2)
    minkhz="384000"
    ;;
  3)
    minkhz="432000"
    ;;
  4)
    minkhz="486000"
    ;;
  5)
    minkhz="540000"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="minkhz="
minkhz="minkhz="$minkhz
case $cmdline in
  "$searchString"* | *" $searchString"*)
       echo $(cat /tmp/boot.img-cmdline | sed -e 's/minkhz=[^ ]\+//')>/tmp/boot.img-cmdline
       echo $(cat /tmp/boot.img-cmdline)\ $minkhz>/tmp/boot.img-cmdline
       ;;  
  *)
       echo $(cat /tmp/boot.img-cmdline)\ $minkhz>/tmp/boot.img-cmdline
       ;;
esac
