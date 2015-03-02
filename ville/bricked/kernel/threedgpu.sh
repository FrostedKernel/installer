#/sbin/sh
val=$(cat /tmp/aroma-data/threedgpu.prop | cut -d"=" -f2)
case $val in
  1)
    threedgpu="400000000"
    ;;
  2)
    threedgpu="436364000"
    ;;
  3)
    threedgpu="480000000"
    ;;
  4)
    threedgpu="512000000"
    ;;
esac

cmdline=$(cat /tmp/boot.img-cmdline)
searchString="threedgpu="
threedgpu="threedgpu="$threedgpu
case $cmdline in
  "$searchString"* | *" $searchString"*)
        echo $(cat /tmp/boot.img-cmdline | sed -e 's/threedgpu=[^ ]\+//')>/tmp/boot.img-cmdline
        echo $(cat /tmp/boot.img-cmdline)\ $threedgpu>/tmp/boot.img-cmdline
        ;;  
  *)
        echo $(cat /tmp/boot.img-cmdline)\ $threedgpu>/tmp/boot.img-cmdline
        ;;
esac
