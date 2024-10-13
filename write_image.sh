#!/bin/sh

export ESPTOOL_PORT=/dev/tty.usbmodem1234561

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

# curl https://micropython.org/resources/firmware/ESP32_GENERIC_S3-20240602-v1.23.0.bin -o firmware.bin
esptool.py --chip esp32s3 flash_id

esptool.py --chip esp32s3 erase_flash

esptool.py -p $USB_TTL_DEV  -b 460800 \
    --before default_reset \
    --after hard_reset \
    --chip esp32s3  write_flash \
    --flash_mode dio \
    --flash_size detect \
    --flash_freq 40m \
    0x1000 ./build/bootloader.bin \
    0x9000 ./build/partition-table.bin \
    0x20000 ./build/micropython.bin
