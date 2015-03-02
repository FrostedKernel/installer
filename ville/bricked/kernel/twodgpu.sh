#!/sbin/sh
val=$(cat /tmp/aroma-data/twodgpu.prop | cut -d"=" -f2)
case $val in
  1)
    twodgpu="200000000"
    ;;
  2)
    twodgpu="266667000"
    ;;
  3)
    twodgpu="300000000"
    ;;
  4)
    twodgpu="320000000"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="twodgpu="
twodgpu="twodgpu="$twodgpu
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/twodgpu=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $twodgpu>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $twodgpu>/tmp/boot.img-cmdline
        ;;
esac
