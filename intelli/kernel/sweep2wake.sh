#/sbin/sh
val=$(cat /tmp/aroma-data/sweep2wake.prop | cut -d"=" -f2)
case $val in
  1)
    s2w="1"
    ;;
  2)
    s2w="0"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="s2w="
s2w="s2w="$s2w
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/s2w=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $s2w>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $s2w>/tmp/boot.img-cmdline
        ;;
esac
