#!/bin/sh

export ESPTOOL_PORT=/dev/tty.usbmodem141401

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

cd ..

mpremote connect $ESPTOOL_PORT fs cp -r src :
mpremote connect $ESPTOOL_PORT fs cp boot.py :
mpremote connect $ESPTOOL_PORT fs cp main.py :
