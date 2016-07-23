#!/usr/bin/env bash

OrigDIR="$(pwd)"
echo "DIR Set to:""${OrigDIR}"

echo "Installing Latest Dependencies"
brew install dpkg
brew install ldid
brew install wget
brew install cmake
brew install homebrew/dupes/unzip
echo "Clean-up"
rm -rf ./Hooks/keystone/ >> /dev/null 2>&1  
rm -rf ./Hooks/capstone/ >> /dev/null 2>&1  
rm ./ExtraFWs/libcapstone.a >> /dev/null 2>&1  
rm ./ExtraFWs/libkeystone.a >> /dev/null 2>&1  
rm ./ExtraFWs/Reveal.framework >> /dev/null 2>&1  
rm ./Reveal.app.zip >> /dev/null 2>&1  
rm -rf ./RevealTMP >> /dev/null 2>&1  
rm -rf ./CYTMP >> /dev/null 2>&1 
mkdir ExtraFWs >> /dev/null 2>&1 
mkdir Packages >> /dev/null 2>&1 
echo "Pulling Latest Trunk"
git submodule update --init --recursive
echo "Installing colorama from python-pip"
sudo pip install colorama
echo "Building capstone"
cd capstone && git pull origin master&& ./make.sh ios
cd "${OrigDIR}"
echo "Moving capstone"
mv ./capstone/libcapstone.a ./ExtraFWs/ >>/dev/null
cp -r ./capstone/include ./Hooks/capstone >>/dev/null
echo "Building keystone"
cd keystone && git pull origin master&&rm -rf build &&mkdir build &&cd build &&../make-lib.sh
cd "${OrigDIR}"
echo "Moving keystone"
mv ./keystone/build/llvm/lib/libkeystone.a ./ExtraFWs/ >> /dev/null 2>&1  
cp -r ./keystone/include/keystone ./Hooks/keystone >> /dev/null 2>&1  
cd "${OrigDIR}"
echo "Downloading Cycript"
wget https://cydia.saurik.com/api/latest/3 -O Cycript.zip
echo "Cleaning old framework"
rm -rf ./Cycript.framework>> /dev/null 2>&1  
rm -rf ./ExtraFWs/Cycript.framework >> /dev/null 2>&1  
rm -rf ./Reveal.framework >> /dev/null 2>&1  
rm -rf ./ExtraFWs/Reveal.framework>> /dev/null 2>&1  
echo "Extracting Cycript"
mkdir CYTMP
unzip Cycript.zip -d ./CYTMP >> /dev/null 2>&1  
cp -avR ./CYTMP/Cycript.ios/*.framework ./ExtraFWs/  >> /dev/null 2>&1  
rm -rf ./CYTMP
rm -rf ./Cycript.zip
echo "Downloading Reveal"
wget http://download.revealapp.com/Reveal.app.zip
unzip Reveal.app.zip -d ./RevealTMP >> /dev/null 2>&1  
cp -rf ./RevealTMP/Reveal.app/Contents/SharedSupport/iOS-Libraries/Reveal.framework ./ExtraFWs/ >> /dev/null 2>&1  
rm -rf ./RevealTMP >> /dev/null 2>&1  
rm -rf ./Reveal.app.zip >> /dev/null 2>&1  



