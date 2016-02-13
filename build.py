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
#Global Config BOOLs
global DEBUG
DEBUG=False
global PROTOTYPE
PROTOTYPE=False
def ParseArg():
	for x in sys.argv:
		if x.upper()=="DEBUG":
			print "DEBUG MODE"
			global DEBUG
			DEBUG=True
		if x.upper()=="PROTOTYPE":
			print "Enable PROTOTYPE"
			global PROTOTYPE
			PROTOTYPE=True
#end


def FixControlFile(Path):
	file=open(Path,"a")
	version=open('./VERSION',"r")
	currentVersion=int(version.read())
	file.write("\nVersion: "+str(currentVersion)+"\n")
	version.close()
	file.close()
	currentVersion+=1
	version=open('./VERSION',"w")
	version.write(str(currentVersion))
	version.close()
def ModuleIter(Path):
	List=listdir(Path)
	for x in List:
		if(x.endswith(".xm")==True):
			componentList=x.split(".")
			componentName=""
			i=0
			while i<len(componentList[i])-1:#ModuleName
				componentName+=componentList[i]
				print "Injecting "+componentName+"Into Module List"
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
	Dict={"cell":"PSSwitchCell","label":"URLSchemesHooks","key":"URLSchemesHooks","default":True,"defaults":"naville.wtfjh"}
	Plist["items"].append(Dict)
	Dict={"cell":"PSSwitchCell","label":"LogToTheConsole","key":"LogToTheConsole","default":True,"defaults":"naville.wtfjh"}
	Plist["items"].append(Dict)
	plistlib.writePlist(Plist,"./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
	#print Plist

#Main Here

ParseArg()
randomTweakName=id_generator()#Generate Random Name To Help Bypass Detection
#os.remove("./Makefile")
toggleModule()
subModuleList()
if (os.path.exists("theos")==False):
	print "Theos Link Doesn't Exist,Creating"
	if(os.environ.get('THEOS')!=None):
		os.system("ln -s $THEOS theos; ln -s ./.theos/obj obj")
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
print "DEBUG:",DEBUG
if(DEBUG==True):
	print "Debugging Mode"
	print "Cleaning Old Build"
	os.system("make clean")
	print "Building"
	os.system("make")
else:
	with open(os.devnull, 'wb') as devnull:
		try:
			print "Cleaning Old Build"
			subprocess.check_call(['make','clean'], stdout=devnull, stderr=subprocess.STDOUT)
			print "Building"
			x=subprocess.check_call(['make'], stdout=devnull, stderr=subprocess.STDOUT)
			print "Make Exit With Status:",x
		except:
			print "Error During Compile,Rerun With DEBUG as Argument to See Output"
			os.system("rm ./"+randomTweakName+".plist")
			exit(255)
os.system("mkdir -p ./layout/DEBIAN; cp ./control ./layout/DEBIAN/control")
FixControlFile("./layout/DEBIAN/control")
os.system("mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries; cp ./obj/"+randomTweakName+".dylib"+" ./layout/Library/MobileSubstrate/DynamicLibraries/")
os.system("cp ./WTFJH.plist"+" ./layout/Library/MobileSubstrate/DynamicLibraries/"+randomTweakName+".plist")
#Cleaning Finder Caches ,Thanks http://stackoverflow.com/questions/2016844/bash-recursively-remove-files
os.system("find . -type f -name .DS_Store -delete && xattr -cr *")
os.system("dpkg-deb -Zgzip -b ./layout ./LatestBuild.deb")
os.system("rm ./"+randomTweakName+".plist")
os.system("rm ./layout/DEBIAN/control")
os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/"+randomTweakName+".dylib")
os.system("rm -rf ./obj")
os.system("rm ./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/"+randomTweakName+".plist")
if(DEBUG):
	print "Debugging Mode,Not Removing Inter-Compile Files"
else:
	os.system("rm ./Makefile")
	os.system("rm ./CompileDefines.xm")
print "Built With Components:",ModuleList
print "Unlinking Theos"
os.system("rm ./theos")
os.system("rm -r ./.theos")



