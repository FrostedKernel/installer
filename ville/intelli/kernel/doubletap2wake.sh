#!/sbin/sh
val=$(cat /tmp/aroma-data/doubletap2wake.prop | cut -d"=" -f2)
case $val in
  1)
    dt2w="1"
    ;;
  2)
    dt2w="2"
    ;;
  3)
    dt2w="3"
    ;;
  4)
    dt2w="0"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="dt2w="
dt2w="dt2w="$dt2w
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/dt2w=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $dt2w>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $dt2w>/tmp/boot.img-cmdline
        ;;
esac
