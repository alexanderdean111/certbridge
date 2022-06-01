#!/system/bin/sh

MAGISK_MOD_DIR="/data/adb/modules"
CERTBRIDGE_DIR="${MAGISK_MOD_DIR}/certbridge"
MAGISK_BUSYBOX="/data/adb/magisk/busybox"

# sanity checks
if [ $(id -u) -ne 0 ]; then
  echo "[-] Error: Must be running as root to install"
  exit 1
fi

if [ ! -d "${MAGISK_MOD_DIR}" ]; then
  echo "[-] Error: Unable to find Magisk module directory (${MAGISK_MOD_DIR})"
  exit 1
fi

if [ -d "${CERTBRIDGE_DIR}" ]; then
  echo "[-] Error: certbridge module appears to already be installed at ${CERTBRIDGE_DIR}"
  exit 1
fi

echo "[+] Ensuring we aren't using DOS line breaks"
find . -type f -exec $MAGISK_BUSYBOX dos2unix {} \;
echo "[+] Copying module to ${CERTBRIDGE_DIR}"
mkdir "${MAGISK_MOD_DIR}/certbridge"
cp -r "$(pwd)/META-INF" "${CERTBRIDGE_DIR}"
cp "$(pwd)/module.prop" "${CERTBRIDGE_DIR}"
cp "$(pwd)/post-fs-data.sh" "${CERTBRIDGE_DIR}"
cp "$(pwd)/README.md" "${CERTBRIDGE_DIR}"
echo "[+] Copy done"
echo "[*] Make sure to place certificates to be copied to the system certificate store to /data/local/tmp/certbridge and restart the device"
