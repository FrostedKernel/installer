#!/sbin/sh
val=$(cat /tmp/aroma-data/bln.prop | cut -d"=" -f2)
case $val in
  1)
    blncfg="1"
    ;;
  2)
    blncfg="0"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="blncfg="
blncfg="blncfg="$blncfg
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/blncfg=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $blncfg>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $blncfg>/tmp/boot.img-cmdline
	;;
esac
