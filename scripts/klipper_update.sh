#!/bin/bash

cd ~/klipper
echo Stopping Klipper Service
systemctl stop klipper.service

# ShyFly Flash
make clean KCONFIG_CONFIG=config.sht36v2
make KCONFIG_CONFIG=config.sht36v2
python3 ~/klipper/lib/canboot/flash_can.py -u 64f40ee6b1fe

# Fystec Cheetah Flash
make clean KCONFIG_CONFIG=config.fystec
make KCONFIG_CONFIG=config.fystec
 make flash KCONFIG_CONFIG=config.fystec FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f401xc_4C0027000851383531393138-if00

# Linux MCU
make clean KCONFIG_CONFIG=config.Linux
make menuconfig KCONFIG_CONFIG=config.Linux
make KCONFIG_CONFIG=config.Linux
sudo ./scripts/flash-linux.sh

systemctl start klipper.service
echo Started Klipper Service
