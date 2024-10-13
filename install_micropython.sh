#!/bin/sh

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

git clone --recursive https://github.com/micropython/micropython/
cd micropython
git reset --hard 82e69df33e379bf491bea647e217d6d56c5b8090
make -C mpy-cross
cd ports/esp32
make submodules

echo MICROPYTHON install done.