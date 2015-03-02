#!/sbin/sh
val=$(cat /tmp/aroma-data/pocketdetect.prop | cut -d"=" -f2)
case $val in
  1)
    pdt="1"
    ;;
  2)
    pdt="0"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="pdt="
pdt="pdt="$pdt
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/pdt=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $pdt>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $pdt>/tmp/boot.img-cmdline
        ;;
esac
