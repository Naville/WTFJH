#!/usr/bin/env bash
echo "Installing Latest Dependencies"
brew install dpkg
brew install ldid
brew install wget
brew install homebrew/dupes/unzip
echo "Clean-up"
rm -rf ./Hooks/keystone/
rm -rf ./Hooks/capstone/
rm ./libcapstone.a
rm ./libkeystone.a
rm ./Reveal.framework
echo "Pulling Latest Trunk"
git submodule foreach git pull origin master
sudo pip install colorama
echo "Building capstone"
cd capstone && ./make.sh ios  && cd ../ >>/dev/null
echo "Moving capstone"
mv ./capstone/libcapstone.a ./ >>/dev/null
cp -r ./capstone/include ./Hooks/capstone >>/dev/null
echo "Building keystone"
cd keystone&&mkdir build &&cd build &&../make-lib.sh &&cd ../../>>/dev/null
echo "Moving keystone"
mv ./keystone/build/llvm/lib/libkeystone.a ./ >>/dev/null
cp -r ./keystone/include/keystone ./Hooks/keystone >>/dev/null
echo "Downloading Cycript"
wget https://cydia.saurik.com/api/latest/3 -O Cycript.zip
echo "Cleaning old framework"
rm -rf ./Cycript.framework >>/dev/null
echo "Extracting Cycript"
mkdir CYTMP
unzip Cycript.zip -d ./CYTMP >>/dev/null
cp -avR ./CYTMP/Cycript.ios/*.framework ./  >>/dev/null
rm -rf ./CYTMP
rm -rf ./Cycript.zip
echo "Downloading Reveal"
wget http://download.revealapp.com/Reveal.app.zip
unzip Reveal.app.zip -d ./RevealTMP
cp -rf ./RevealTMP/Reveal.app/Contents/SharedSupport/iOS-Libraries/Reveal.framework ./
rm -rf ./RevealTMP
rm -rf ./Reveal.app.zip



