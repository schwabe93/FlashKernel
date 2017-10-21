# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=FlashKernel V0.0.2 by schwabe93 @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=gts3lltexx
device.name2=gts3llte
device.name3=
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/mmcblk0p28;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod 750 $ramdisk/init.services.rc
chmod 750 $ramdisk/sbin/sysinit.sh



## AnyKernel install
dump_boot;

# begin ramdisk changes
# init.rc
insert_line init.rc "import /init.services.rc" after "import /init.fac.rc" "/import init.services.rc";

# end ramdisk changes

write_boot;

## end install

