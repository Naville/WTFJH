#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys
import subprocess
import string
import random
import plistlib
from os import listdir
from colorama import init
from colorama import Fore, Back, Style
init(autoreset=True)

# Global config
makeFileString = ""
PathList = ["Hooks/APIHooks/", "Hooks/SDKHooks/", "Hooks/Utils/"]
global toggleString
toggleString = "void GlobalInit() {\n"
global MakeFileListString
MakeFileListString = "_FILES = Tweak.xm CompileDefines.xm"
global ModuleList
ModuleList = list()
global DEBUG
DEBUG = False
global PROTOTYPE
PROTOTYPE = False


def LINKTHEOS():
	if (os.path.exists("theos") == False):
		print "TheOS link doesn't exist, creating..."
		if (os.environ.get('THEOS') != None):
			os.system("ln -s $THEOS theos; mkdir .theos; mkdir .theos/obj; ln -s ./.theos/obj obj")
		else:
			print "$THEOS ENV not set."
			sys.exit(255)
	else:
		print "TheOS link exists at " + os.getcwd() + "/theos" + ", building..."


def FixControlFile(Path):
	file = open(Path,"a")
	version = open('./VERSION', "r")
	currentVersion = int(version.read())
	file.write("\nVersion: " + str(currentVersion) + "\n")
	version.close()
	file.close()
	currentVersion += 1
	version = open('./VERSION', "w")
	version.write(str(currentVersion))
	version.close()


def ModuleIter(Path):
	List = listdir(Path)
	for x in List:
		if (x.endswith(".xm") == True):
			componentList = x.split(".")
			componentName = ""
			i = 0
			while i < len(componentList[i]) - 1: #ModuleName
				componentName += componentList[i]
				print "Injecting " + componentName + " into module list..."
				global ModuleList
				ModuleList.append(componentName)
				i += 1
			global toggleString
			toggleString += "if (getBoolFromPreferences(@\""+componentName+"\") == YES) {\n"
			if DEBUG==True:
				toggleString += "NSLog(@\""+componentName+"Init\");\n"
			toggleString += "extern void init_"+componentName+"_hook();\n"
			toggleString += "    init_"+componentName+"_hook();\n";
			toggleString += "}\n";


def toggleModule():
	global toggleString
	toggleString += "extern BOOL getBoolFromPreferences(NSString *preferenceValue);\n"
	for x in PathList:
		ModuleIter(x)
	if DEBUG==True:
		toggleString += "NSLog(@\"Finished Init Modules\");\n"
	toggleString += "}\n"
	os.system("touch ./CompileDefines.xm")
	fileHandle = open("./CompileDefines.xm","w")
	fileHandle.flush()
	fileHandle.write(toggleString)
	fileHandle.close() 


def MakeFileIter(Path):
		FileList = listdir(Path)
		for x in FileList:
			if (x.endswith(".mm") == False and x.endswith(".m") == False and x.endswith(".xm") == False):
				print (Fore.RED +x + " has been ignored.")
			else:	
				string = " " + Path + x
				print (Fore.GREEN +"Injecting" + string + " into Makefile...")
				global MakeFileListString
				MakeFileListString += string


def subModuleList():
	for x in PathList:
		MakeFileIter(x)



# Thanks to http://stackoverflow.com/questions/2257441/random-string-generation-with-upper-case-letters-and-digits-in-python
def id_generator(size=15, chars=string.ascii_uppercase + string.digits):
	return ''.join(random.choice(chars) for _ in range(size))


# Build PreferencesLoader Script
def BuildPF():
	CustomPrefList = os.listdir("./Preferences")
	Plist = plistlib.readPlist('./BasePreferences.plist')
	Dict = {
		"cell": "PSGroupCell",
		"label": "Additional",
		"isStaticText": True
	}
	Plist["items"].append(Dict)
	Dict = {
		"cell": "PSSwitchCell",
		"label": "Log To The Console",
		"key": "LogToTheConsole",
		"default": False,
		"defaults": "naville.wtfjh"
	}
	Plist["items"].append(Dict)
	Dict = {
		"cell": "PSSwitchCell",
		"label": "URL Schemes Hooks",
		"key": "URLSchemesHooks",
		"default": False,
		"defaults": "naville.wtfjh"
	}
	Plist["items"].append(Dict)
	Dict = {
		"cell": "PSGroupCell",
		"label": "Modules",
		"isStaticText": True
	}
	Plist["items"].append(Dict)
	for x in ModuleList:
		CustomPrefPath = x + ".plist"
		if (CustomPrefPath in CustomPrefList):
			custom = plistlib.readPlist('./Preferences/' + CustomPrefPath)
			Plist["items"].append(custom)
		Dict = {
			"cell": "PSSwitchCell",
			"label": x,
			"key": x,
			"default": False,
			"defaults": "naville.wtfjh"
		}
		Plist["items"].append(Dict)
	Dict = {
		"cell": "PSGroupCell",
		"footerText": "https://github.com/Naville/WTFJH"
	}
	Plist["items"].append(Dict)
	plistlib.writePlist(Plist, "./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")

def ParseArgs():
	for x in sys.argv:
		if x.upper() == "DEBUG":
			print "DEBUG Enabled"
			global DEBUG
			DEBUG = True
		if x.upper() == "PROTOTYPE":
			print "PROTOTYPE Enabled"
			global PROTOTYPE
			PROTOTYPE = True

def main():
	ParseArgs()

	# Generate random Name to bypass detection
	# os.remove("./Makefile")
	randomTweakName = id_generator()
	toggleModule()
	subModuleList()
	LINKTHEOS()
	global makeFileString
	makeFileString += "export CFLAGS=-Wp,\"-DWTFJHTWEAKNAME="+"@\\\""+randomTweakName+"\\\""
	if(PROTOTYPE):
		makeFileString += ",-DPROTOTYPE"
	makeFileString += "\"\n"
	makeFileString += "include theos/makefiles/common.mk\n"
	makeFileString += "export ARCHS = armv7 armv7s arm64\n"
	makeFileString += "export TARGET = iphone:clang:7.0:7.0\n"
	makeFileString += "TWEAK_NAME = " + randomTweakName + "\n"
	makeFileString += randomTweakName + MakeFileListString + "\n"
	makeFileString += "ADDITIONAL_CCFLAGS  = -Qunused-arguments\n"
	makeFileString += "ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000,-sectcreate,WTFJH,SIGDB,./SignatureDatabase.plist\n"
	makeFileString += randomTweakName + "_LIBRARIES = sqlite3 substrate\n"
	makeFileString += randomTweakName + "_FRAMEWORKS = Foundation UIKit Security\n"
	makeFileString += "include $(THEOS_MAKE_PATH)/tweak.mk\n"
	makeFileString += "after-install::\n"
	makeFileString += "	install.exec \"killall -9 SpringBoard\""
	fileHandle = open('Makefile', 'w')
	fileHandle.flush() 
	fileHandle.write(makeFileString)
	fileHandle.close() 
	BuildPF()
	os.system("cp ./WTFJH.plist ./" + randomTweakName + ".plist")
	print (Fore.YELLOW +"DEBUG:"+str(DEBUG))
	print (Fore.YELLOW +"PROTOTYPE:"+str(PROTOTYPE))
	if (DEBUG == True):
		print "Building..."
		os.system("make")
	else:
		with open(os.devnull, 'wb') as devnull:
			try:
				print "Building..."
				x = subprocess.check_call(['make'], stdout=devnull, stderr=subprocess.STDOUT)
				print "Make Exit With Status: ",x
				os.system("rm ./CompileDefines.xm")
			except:
				print (Fore.RED +"Error During Compile,Rerun With DEBUG as Argument to See Output")
				os.system("rm ./" + randomTweakName + ".plist")
				os.system("rm ./Makefile")
				os.system("rm ./CompileDefines.xm")
				exit(255)
	os.system("mkdir -p ./layout/DEBIAN; cp ./control ./layout/DEBIAN/control")
	FixControlFile("./layout/DEBIAN/control")
	os.system("mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries; cp ./obj/" + randomTweakName + ".dylib" + " ./layout/Library/MobileSubstrate/DynamicLibraries/")
	os.system("cp ./WTFJH.plist" + " ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".plist")
	# Cleaning finder caches, thanks to http://stackoverflow.com/questions/2016844/bash-recursively-remove-files
	os.system("find . -type f -name .DS_Store -delete && xattr -cr *")
	os.system("dpkg-deb -Zgzip -b ./layout ./LatestBuild.deb")
	os.system("rm ./" + randomTweakName + ".plist")
	os.system("rm ./layout/DEBIAN/control")
	os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".dylib")
	os.system("rm -rf ./obj")
	os.system("rm ./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
	os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".plist")
	if (DEBUG):
		print (Fore.YELLOW +'Debugging mode, without removing Inter-compile files.')
	else:
		os.system("rm ./Makefile")
		os.system("rm ./CompileDefines.xm")
	print (Fore.YELLOW +"Built with components: \n")
	for x in ModuleList:
		print (Fore.YELLOW +x)
	print "Unlinking TheOS..."
	os.system("rm ./theos")
	os.system("rm -r ./.theos")
	print "Finished."

if __name__ == "__main__":
    main()