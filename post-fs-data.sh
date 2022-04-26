#!/system/bin/sh
MODDIR=${0%/*}

# make the directory for Magisk to mount
mkdir -p $MODDIR/system/etc/security/cacerts

# remove previous certificates
#rm -rf $MODDIR/system/etc/security/cacerts/*

# duplicate certificates from SD Card
cp -f /data/local/tmp/certbridge/* $MODDIR/system/etc/security/cacerts/

# fix permissions
chown -R 0:0 $MODDIR/system/etc/security/cacerts
chmod -R 644 $MODDIR/system/etc/security/cacerts

# if SELinux is on, set the context
if [ "$(getenforce)" == "Enforcing" ]; then
  selinux=$(ls -Zd /system/etc/security/cacerts | cut -d" " -f1)
  chcon -R $selinux $MODDIR/system/etc/security/cacerts
fi
