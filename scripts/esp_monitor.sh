#!/bin/sh

export ESPTOOL_PORT=/dev/tty.usbmodem142301

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

cd ..

source esp-idf/export.sh
cd esp-idf
python3 ./tools/idf_monitor.py monitor --no-reset -p $ESPTOOL_PORT