#!/sbin/sh
#ramdisk_gov_sed.sh by show-p1984
#Features: 
#extracts ramdisk
#finds busbox in /system or sets default location if it cannot be found
#add init.d support if not already supported
#disables variabe brightness controls to allow bln
#enables unsecure kernel
#removes governor overrides
#repacks the ramdisk

mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
cd /

#add init.d support if not already supported
found=$(find /tmp/ramdisk/init.rc -type f | xargs grep -oh "run-parts /system/etc/init.d");
if [ "$found" != 'run-parts /system/etc/init.d' ]; then
        #find busybox in /system
        bblocation=$(find /system/ -name 'busybox')
        if [ -n "$bblocation" ] && [ -e "$bblocation" ] ; then
                echo "BUSYBOX FOUND!";
                #strip possible leading '.'
                bblocation=${bblocation#.};
        else
                echo "NO BUSYBOX NOT FOUND! init.d support will not work without busybox!";
                echo "Setting busybox location to /system/xbin/busybox! (install it and init.d will work)";
                #set default location since we couldn't find busybox
                bblocation="/system/xbin/busybox";
        fi
	#append the new lines for this option at the bottom
        echo "" >> /tmp/ramdisk/init.rc
        echo "service userinit $bblocation run-parts /system/etc/init.d" >> /tmp/ramdisk/init.rc
        echo "    oneshot" >> /tmp/ramdisk/init.rc
        echo "    class late_start" >> /tmp/ramdisk/init.rc
        echo "    user root" >> /tmp/ramdisk/init.rc
        echo "    group root" >> /tmp/ramdisk/init.rc
fi

#remove system access to led/currents for bln
found=$(find /tmp/ramdisk/init.qcom.rc -type f | xargs grep -oh "chown system system /sys/class/leds/button-backlight/currents");
if [ "$found" = 'chown system system /sys/class/leds/button-backlight/currents' ]; then

	# reset permissions for button-backlight/currents
	# this will kill CM's variable button brightness
	sed -i -e 's|chown system system /sys/class/leds/button-backlight/currents|chown root root /sys/class/leds/button-backlight/currents|g' /tmp/ramdisk/init.qcom.rc

fi

#unsecure
found=$(find /tmp/ramdisk/default.prop -type f | xargs grep -oh "ro.adb.secure=1");
if [ "$found" = 'ro.adb.secure=1' ]; then
	sed -i -e 's|ro.adb.secure=1|ro.adb.secure=0|g' /tmp/ramdisk/default.prop
fi

found=$(find /tmp/ramdisk/default.prop -type f | xargs grep -oh "ro.secure=1");
if [ "$found" = 'ro.secure=1' ]; then
	sed -i -e 's|ro.secure=1|ro.secure=0|g' /tmp/ramdisk/default.prop
fi

#remove governor overrides, use kernel default
sed -i '/\/sys\/devices\/system\/cpu\/cpu0\/cpufreq\/scaling_governor/d' /tmp/ramdisk/init.qcom.rc
sed -i '/\/sys\/devices\/system\/cpu\/cpu1\/cpufreq\/scaling_governor/d' /tmp/ramdisk/init.qcom.rc
sed -i '/\/sys\/devices\/system\/cpu\/cpu2\/cpufreq\/scaling_governor/d' /tmp/ramdisk/init.qcom.rc
sed -i '/\/sys\/devices\/system\/cpu\/cpu3\/cpufreq\/scaling_governor/d' /tmp/ramdisk/init.qcom.rc

rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdisk.gz
cd /tmp/ramdisk/
find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz
cd /

