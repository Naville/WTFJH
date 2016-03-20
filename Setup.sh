#!/usr/bin/env bash
echo "Pulling Latest Trunk"
git submodule update
pip install colorama >>/dev/null
echo "Building capstone"
cd capstone && ./make.sh ios >>/dev/null
print "Moving capstone"
mv libcapstone.a ../