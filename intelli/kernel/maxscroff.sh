#/sbin/sh
val=$(cat /tmp/aroma-data/maxscroff.prop | cut -d"=" -f2)
case $val in
  1)
    maxscroff="384000"
    ;;
  2)
    maxscroff="432000"
    ;;
  3)
    maxscroff="486000"
    ;;
  4)
    maxscroff="540000"
    ;;
  5)
    maxscroff="594000"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="maxscroff="
maxscroff="maxscroff="$maxscroff
case $cmdline in
  "$searchString"* | *" $searchString"*)
       echo $(cat /tmp/boot.img-cmdline | sed -e 's/maxscroff=[^ ]\+//')>/tmp/boot.img-cmdline
       echo $(cat /tmp/boot.img-cmdline)\ $maxscroff>/tmp/boot.img-cmdline
       ;;  
  *)
       echo $(cat /tmp/boot.img-cmdline)\ $maxscroff>/tmp/boot.img-cmdline
       ;;
esac
