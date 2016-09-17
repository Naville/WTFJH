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
rm ./ExtraFWs/libLiberation.a >> /dev/null 2>&1 
rm ./Hooks/Liberation.h >> /dev/null 2>&1  
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
cd "${OrigDIR}"
echo "Building Liberation"
cd ./Liberation
cd keystone&&git pull origin master &&cd ../
./liberation setup
./liberation build
cd "${OrigDIR}"
echo "Moving Liberation"
mv ./Liberation/lib/libLiberation.a ./ExtraFWs/
mv ./Liberation/include/Liberation.h ./Hooks/
cd "${OrigDIR}"
echo "Downloading Cycript"
wget https://cydia.saurik.com/api/latest/3 -O Cycript.zip
echo "Cleaning old framework"
rm -rf ./Cycript.framework>> /dev/null 2>&1  
rm -rf ./ExtraFWs/Cycript.framework >> /dev/null 2>&1  
rm -rf ./Reveal.framework >> /dev/null 2>&1  
rm -rf ./ExtraFWs/Reveal.framework>> /dev/null 2>&1  

#Cycript's static library hasn't been updated for years and ages. Use system dylib instead

echo "Extracting Cycript"
rm -rf ./Cycript
mkdir Cycript
unzip Cycript.zip -d ./Cycript >> /dev/null 2>&1  
cp -avR ./Cycript/Cycript.lib/libcycript.dylib ./  >> /dev/null 2>&1  
rm -rf ./Cycript.zip
echo "Downloading Reveal"
wget http://download.revealapp.com/Reveal.app.zip
unzip Reveal.app.zip -d ./RevealTMP >> /dev/null 2>&1  
cp -rf ./RevealTMP/Reveal.app/Contents/SharedSupport/iOS-Libraries/libReveal.dylib ./ >> /dev/null 2>&1  
rm -rf ./RevealTMP >> /dev/null 2>&1  
rm -rf ./Reveal.app.zip >> /dev/null 2>&1  
echo "Building FLEX"
cd ./FLEX && xcodebuild -workspace FLEX.xcworkspace -scheme FLEX CONFIGURATION_BUILD_DIR=./&& mv ./FLEX.framework ../ExtraFWs&&cd ../
echo "Downloading Reveal2"
wget -O Reveal2.zip https://dl.devmate.com/com.ittybittyapps.Reveal2/Reveal.zip
unzip Reveal2.zip -d ./Reveal2TMP >> /dev/null 2>&1  
cp -rf ./Reveal2TMP/Reveal.app/Contents/SharedSupport/iOS-Libraries/RevealServer.framework/RevealServer ./Reveal2Server >> /dev/null 2>&1  
rm ./Reveal2.zip
rm -rf ./Reveal2TMP >>/dev/null 2>&1
