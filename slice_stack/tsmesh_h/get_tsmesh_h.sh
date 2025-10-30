#!/bin/bash

shot=191486
diag="tsmesh_h"

url="https://exp.lhd.nifs.ac.jp/opendata/LHD/webapi.fcgi?cmd=getfile&diag=${diag}&shotno=${shot}&subno=1"
echo "${diag}_${shot}.txt"
wget -q -O "${diag}_${shot}.txt" "$url"
