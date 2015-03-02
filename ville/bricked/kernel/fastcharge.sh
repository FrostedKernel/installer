#!/sbin/sh
val=$(cat /tmp/aroma-data/fastcharge.prop | cut -d"=" -f2)
case $val in
  1)
    fstchg="1"
    ;;
  2)
    fstchg="0"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="fstchg="
fstchg="fstchg="$fstchg
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/fstchg=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $fstchg>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $fstchg>/tmp/boot.img-cmdline
	;;
esac
