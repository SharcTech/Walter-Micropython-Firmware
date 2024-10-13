#!/bin/sh

export ESPTOOL_PORT=/dev/tty.usbmodem14201

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

cd ..

curl https://micropython.org/resources/firmware/ESP32_GENERIC_S3-20240602-v1.23.0.bin -o stock_firmware.bin

esptool.py --chip esp32s3 flash_id

esptool.py --chip esp32s3 erase_flash

esptool.py --chip esp32s3 write_flash -z 0 stock_firmware.bin
