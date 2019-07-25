# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=ExampleKernel by osm0sis @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=mido
device.name2=Redmi Note 4
device.name3=Redmi Note 4x
device.name4=HMNote4x
device.name5=Redmi Note 4X
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/omap/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# update default.prop
patch_prop "default.prop" "ro.debuggable" "0"

ui_print "Default.prop patched."

# update init.rc
insert_line init.rc "spectrum" after 'import /init.${ro.zygote}.rc' 'import /init.spectrum.rc';

# end ramdisk changes

write_boot;
## end install

