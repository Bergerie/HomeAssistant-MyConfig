## Install MySensors gateway
```sh
git clone https://github.com/mysensors/MySensors.git --branch master
cd MySensors
```
Add this to ./configure
```cpp
--my-mqtt-user=*)
    CPPFLAGS="-DMY_MQTT_USER=\\\"${optarg}\\\" $CPPFLAGS"
    ;;
--my-mqtt-password=*)
    CPPFLAGS="-DMY_MQTT_PASSWORD=\\\"${optarg}\\\" $CPPFLAGS"
    ;;
```
After this
```cpp
--my-signing-request-gw-signatures-from-all*)
        signing_request_signatures=true
        CPPFLAGS="-DMY_SIGNING_GW_REQUEST_SIGNATURES_FROM_ALL $CPPFLAGS"
        ;;
```
```sh
./configure --my-gateway=mqtt --my-controller-ip-address=127.0.0.1 --my-port=1883 --my-mqtt-publish-topic-prefix=mysensors-out --my-mqtt-subscribe-topic-prefix=mysensors-in --my-mqtt-client-id=mygateway --my-mqtt-user=admin --my-mqtt-password=admin --my-transport=nrf24 --my-rf24-irq-pin=15
make
sudo make install
sudo systemctl enable mysgw.service
sudo systemctl start mysgw.service
```


## To install LIRC
```bat
sudo apt-get install lirc liblircclient-dev
sudo nano /etc/lirc/hardware.conf
```
Paste following:

```
########################################################
# /etc/lirc/hardware.conf
#
# Arguments which will be used when launching lircd
LIRCD_ARGS="--uinput"

# Don't start lircmd even if there seems to be a good config file
# START_LIRCMD=false

# Don't start irexec, even if a good config file seems to exist.
# START_IREXEC=false

# Try to load appropriate kernel modules
LOAD_MODULES=true

# Run "lircd --driver=help" for a list of supported drivers.
DRIVER="default"
# usually /dev/lirc0 is the correct setting for systems using udev
DEVICE="/dev/lirc0"
MODULES="lirc_rpi"

# Default configuration files for your hardware if any
LIRCD_CONF=""
LIRCMD_CONF=""
########################################################
```

```bat
sudo nano /etc/modules
```
Append to the end:
```
lirc_dev
lirc_rpi gpio_in_pin=16 gpio_out_pin=20
```
```bat
sudo /etc/init.d/lirc stop
sudo /etc/init.d/lirc start
sudo nano /boot/config.txt
```
Append to the end:
```
dtoverlay=lirc-rpi,gpio_in_pin=16,gpio_out_pin=20,gpio_in_pull=up
```