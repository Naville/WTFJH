#!/usr/bin/env python
from os import listdir
import subprocess
import string
import random
import os
import sys
import plistlib
makeFileString=""
PathList=["Hooks/APIHooks/","Hooks/SDKHooks/","Hooks/Utils/"]
global toggleString
toggleString="void GlobalInit(){\n"
global MakeFileListString
MakeFileListString="_FILES = Tweak.xm CompileDefines.xm"
global ModuleList
ModuleList=list()
def ModuleIter(Path):
	List=listdir(Path)
	for x in List:
		if(x.endswith(".xm")==False):
			print x+" "+"Not A Theos Code File"
		else:
			componentList=x.split(".")
			componentName=""
			i=0
			while i<len(componentList[i])-1:#ModuleName
				componentName+=componentList[i]
				global ModuleList
				ModuleList.append(componentName)
				i+=1
			global toggleString
			toggleString+="if(getBoolFromPreferences(@\""+componentName+"\")==YES){\n"
			toggleString+="extern  void init_"+componentName+"_hook();\n"
			toggleString+="init_"+componentName+"_hook();\n";
			toggleString+="}\n";
def toggleModule():
	global toggleString
	toggleString+="extern BOOL getBoolFromPreferences(NSString *preferenceValue);\n"
	for x in PathList:
		ModuleIter(x)
	toggleString+="}\n"
	os.system("touch"+" "+"./CompileDefines.xm")
	fileHandle=open("./CompileDefines.xm","w")
	fileHandle.flush()
	fileHandle.write(toggleString)
	fileHandle.close() 

def MakeFileIter(Path):
		FileList=listdir(Path)
		for x in FileList:
			if(x.endswith(".mm")==False and x.endswith(".m")==False and x.endswith(".xm")==False):
				print x+" Not Code File"
			else:	
				string=" "+Path+x
				print "Injecting:"+string+" Into Makefile"
				global MakeFileListString
				MakeFileListString+=string



def subModuleList():
	for x in PathList:
		MakeFileIter(x)
def id_generator(size=15, chars=string.ascii_uppercase + string.digits):
	#Thanks to http://stackoverflow.com/questions/2257441/random-string-generation-with-upper-case-letters-and-digits-in-python
	return ''.join(random.choice(chars) for _ in range(size))
def BuildPF():
	#Build PreferencesLoader Script
	Plist=plistlib.readPlist('./BasePreferences.plist')
	for x in ModuleList:
		Dict={"cell":"PSSwitchCell","label":x,"key":x,"default":True,"defaults":"naville.wtfjh"}
		Plist["items"].append(Dict)
	plistlib.writePlist(Plist,"./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
	#print Plist
randomTweakName=id_generator()#Generate Random Name To Help Bypass Detection
#os.remove("./Makefile")
toggleModule()
subModuleList()
if (os.path.exists("theos")==False):
	print "Theos Link Doesn't Exist,Creating"
	if(os.environ.get('THEOS')!=None):
		os.system("ln -s $THEOS theos")
	else:
		print "$THEOS ENV Not Set"
		sys.exit(255)
else:
	print "Theos Link Exists at"+os.getcwd()+"/theos"+",Building"
makeFileString+="include theos/makefiles/common.mk\n"
makeFileString+="export ARCHS = armv7 armv7s arm64\n"
makeFileString+="export TARGET = iphone:clang:7.0:7.0\n"
makeFileString+="TWEAK_NAME = "+randomTweakName+"\n"
makeFileString+=randomTweakName+MakeFileListString+"\n"
makeFileString+="ADDITIONAL_CCFLAGS  = -Qunused-arguments\n"
makeFileString+="ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000\n"
makeFileString+=randomTweakName+"_LIBRARIES = sqlite3 substrate\n"
makeFileString+=randomTweakName+"_FRAMEWORKS = Foundation UIKit Security\n"
makeFileString+="include $(THEOS_MAKE_PATH)/tweak.mk\n"
makeFileString+="after-install::\n"
makeFileString+="	install.exec \"killall -9 SpringBoard\""
#print makeFileString
fileHandle = open('Makefile','w')
fileHandle.flush() 
fileHandle.write(makeFileString)
fileHandle.close() 
BuildPF()
os.system("cp ./WTFJH.plist ./"+randomTweakName+".plist")
print "Cleaning Old Build"
os.system("make clean")
print "Building"
if(len(sys.argv)>1):
	if(sys.argv[1].upper() =="DEBUG"):
		print "Debugging Mode"
		os.system("make")
else:
	with open(os.devnull, 'wb') as devnull:
		subprocess.check_call(['make'], stdout=devnull, stderr=subprocess.STDOUT)
os.system("rm ./"+randomTweakName+".plist")
os.system("rm ./Makefile")
os.system("cp ./control ./layout/DEBIAN/control")
os.system("cp ./obj/"+randomTweakName+".dylib"+" ./layout/Library/MobileSubstrate/DynamicLibraries/")
os.system("dpkg-deb -Zgzip -b ./layout ./LatestBuild.deb")
os.system("rm ./layout/DEBIAN/control")
os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/"+randomTweakName+".dylib")
os.system("rm -rf ./obj")
os.system("rm ./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
print "Built With Components:",ModuleList



