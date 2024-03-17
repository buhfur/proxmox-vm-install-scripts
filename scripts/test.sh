#!/usr/bin/sh



git clone https://github.com/buhfur/linux-cli-community ~/linux-cli
wait
cd ~/linux-cli
wait
pip3 install -e . --break-system-packages


