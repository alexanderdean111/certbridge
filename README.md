# Certificate Bridge
Magisk module to copy certificates `/data/local/tmp/certbridge` into the system store (`/system/etc/security/cacerts`)

### Installation

Requires Magisk to already be installed and to be able to run as root.

1. Copy zip file to device

    ```sh
    $ adb push certbridge.zip /sdcard
    ```

2. Connect to device with ADB and elevate to root

    ```sh
    $ adb shell
    $ su
    # whoami
    root
    ```
   
3. Unzip the archive and run the installer script

    ```sh
    $ cd /sdcard
    $ unzip certbridge.zip
    $ cd certbridge
    $ /system/bin/sh cli-installer.sh
    ```

4. Create the certificate directory from which the module will copy certificates, and copy any certificates to be placed in the certificate store in it

    ```sh
    $ mkdir /data/local/tmp/certbridge
    $ cp /sdcard/my-ca-cert.0 /data/local/tmp/certbridge/
    ```

5. Restart the device, certificates in /data/local/tmp/certbridge will be copied into /system/etc/security/cacerts and be trusted by the Android system
