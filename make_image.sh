#!/bin/sh

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

mkdir build
source esp-idf/export.sh
cd micropython/ports/esp32

make submodules
make BOARD=ESP32_GENERIC_S3 clean

idf.py -D MICROPY_BOARD=ESP32_GENERIC_S3 -B build-WALTER build
# idf.py -D MICROPY_BOARD=ESP32_GENERIC_S3 -B build-WALTER size
# idf.py -D MICROPY_BOARD=ESP32_GENERIC_S3 -B build-WALTER size-components
# idf.py -D MICROPY_BOARD=ESP32_GENERIC_S3 -B build-WALTER size-files

cp ./build-WALTER/sdkconfig.combined ../../../build/sdkconfig.combined
cp ./build-WALTER/bootloader/bootloader.bin ../../../build/bootloader.bin
cp ./build-WALTER/partition_table/partition-table.bin ../../../build/partition-table.bin
# cp ./build-WALTER/ota_data_initial.bin ../../../build/ota_data_initial.bin
cp ./build-WALTER/micropython.bin ../../../build/micropython.bin
