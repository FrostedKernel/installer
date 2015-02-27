#!/sbin/sh
val=$(cat /tmp/aroma-data/doubletap2sleep.prop | cut -d"=" -f2)
case $val in
  1)
    dt2s="1"
    ;;
  2)
    dt2s="2"
    ;;
  3)
    dt2s="3"
    ;;
  4)
    dt2s="0"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="dt2s="
dt2s="dt2s="$dt2s
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/dt2s=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $dt2s>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $dt2s>/tmp/boot.img-cmdline
        ;;
esac
