#!/usr/bin/env bash
echo "Pulling Latest Trunk"
git submodule foreach git pull origin master
pip install colorama
echo "Building capstone"
cd capstone && ./make.sh ios  >>/dev/null
echo "Moving capstone"
mv libcapstone.a ../