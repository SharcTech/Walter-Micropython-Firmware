#!/bin/sh

export ESPTOOL_PORT=/dev/tty.usbmodem141301

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

esptool.py --chip esp32s3 flash_id

esptool.py --chip esp32s3 erase_flash

esptool.py -b 460800 \
    --before default_reset \
    --after hard_reset \
    --chip esp32s3  write_flash \
    --flash_mode dio \
    --flash_size 8MB \
    --flash_freq 80m \
    0x0000 ./build/bootloader.bin \
    0x8000 ./build/partition-table.bin \
    0x10000 ./build/micropython.bin
