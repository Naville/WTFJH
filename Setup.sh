#!/usr/bin/env bash
echo "Installing Latest Dependencies"
brew install dpkg
brew install ldid
brew install wget
brew install unzip
echo "Pulling Latest Trunk"
git submodule foreach git pull origin master
sudo pip install colorama
echo "Building capstone"
cd capstone && ./make.sh ios  >>/dev/null
echo "Moving capstone"
mv libcapstone.a ../
echo "Downloading Cycript"
wget https://cydia.saurik.com/api/latest/3 -O Cycript.zip
echo "Extracting Cycript"
unzip Cycript.zip 'Cycript.ios/Cycript.framework/*' -d ./
mv -f ./Cycript.ios/Cycript.framework ./Cycript.framework
