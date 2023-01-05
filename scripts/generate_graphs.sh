#!/bin/bash

FILES="/tmp/calibration_data"

mkdir -p ~/printer_data/config/graphs

for file in "${FILES}"_*.csv
do
        if [ -f "$file" ];then
          name=$(basename "${file}" .csv)
	echo basename $name
          ~/klipper/scripts/calibrate_shaper.py "${file}" -o ~/printer_data/config/graphs/"${name}".png
          mv "$file" ~/printer_data/config/graphs/"$name".processed
        fi
done

