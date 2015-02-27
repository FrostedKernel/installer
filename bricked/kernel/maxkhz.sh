#/sbin/sh
val=$(cat /tmp/aroma-data/maxkhz.prop | cut -d"=" -f2)
case $val in
  1)
    maxkhz="1512000"
    ;;
  2)
    maxkhz="1674000"
    ;;
  3)
    maxkhz="1728000"
    ;;
  4)
    maxkhz="1782000"
    ;;
  5)
    maxkhz="1836000"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="maxkhz="
maxkhz="maxkhz="$maxkhz
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/maxkhz=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $maxkhz>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $maxkhz>/tmp/boot.img-cmdline
        ;;
esac
