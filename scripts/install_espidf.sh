#!/bin/sh

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"

cd ..

git clone -b v5.2.2 --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
git branch
./install.sh
source ./export.sh

echo ESPIDF install done.