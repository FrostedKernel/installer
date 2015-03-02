#!/sbin/sh
val=$(cat /tmp/aroma-data/governor.prop | cut -d"=" -f2)
case $val in
  1)
    gov="badass"
    ;;
  2)
    gov="conservative"
    ;;
  3)
    gov="elementalx"
    ;;
  4)
    gov="intelliactive"
    ;;
  5)
    gov="intellidemand"
    ;;
  6)
    gov="intellimm"
    ;;
  7)
    gov="interactive"
    ;;
  8)
    gov="lionheart"
    ;;
  9)
    gov="ondemand"
    ;;
  10)
    gov="performance"
    ;;
  11)
    gov="powersave"
    ;;
  12)
    gov="preservative"
    ;;
  13)
    gov="smartass2"
    ;;
  14)
    gov="tripndroid"
    ;;
  15)
    gov="userspace"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="gov="
gov="gov="$gov
case $cmdline in
  "$searchString"* | *" $searchString"*)
       echo $(cat /tmp/boot.img-cmdline | sed -e 's/gov=[^ ]\+//')>/tmp/boot.img-cmdline
       echo $(cat /tmp/boot.img-cmdline)\ $gov>/tmp/boot.img-cmdline
       ;;  
  *)
       echo $(cat /tmp/boot.img-cmdline)\ $gov>/tmp/boot.img-cmdline
       ;;
esac
