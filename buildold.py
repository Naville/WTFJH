#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys
import subprocess
import string
import random
import plistlib
import argparse
import re
from os import listdir
from colorama import init
from colorama import Fore, Back, Style
import ManualObfuscation
init(autoreset=True)

# Global config
makeFileString = ""
PathList = ["Hooks/API/", "Hooks/SDK/", "Hooks/Utils/","Hooks/ThirdPartyTools/"]
ManualObflist=ManualObfuscation.ManualList
global toggleString
toggleString = "#import \"./Hooks/Obfuscation.h\"\nvoid GlobalInit() {\n"
global MakeFileListString
MakeFileListString = "_FILES = Tweak.xm CompileDefines.xm"
global ModuleList
ModuleList = list()
global DEBUG
DEBUG = False
global PROTOTYPE
PROTOTYPE = False
global OBFUSCATION
OBFUSCATION=False
global ObfDict
ObfDict=dict()
global LoaderList
LoaderList=list()
global LinkerString
LinkerString=""
global currentVersion
currentVersion=0

#Clean-Up
def cleanUp():
	print (Fore.YELLOW +"Cleaning Misc Files")
	os.system("rm ./layout/DEBIAN/control")
	os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".dylib")
	os.system("rm -rf ./obj")
	os.system("rm ./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
	os.system("rm ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".plist")
	os.system("rm ./" + randomTweakName + ".plist")
	for x in listdir("./ThirdPartyTools"):
		if os.path.isdir("./ThirdPartyTools/"+x):
			os.system("rm -rf ./ThirdPartyTools/"+x+"/obj/")
			os.system("rm -rf ./"+x+".dylib")
	for x in LoaderList:
		#Clean-Up Auto-Generated Loaders
		print (Fore.YELLOW +"Cleaning:"+x+"Loader")
		os.system("rm ./Hooks/ThirdPartyTools/"+x+".xm")
	if (DEBUG):
		print (Fore.YELLOW +'Debugging mode, without removing Inter-compile files.')
		if OBFUSCATION==False:
			os.system("rm ./Hooks/Obfuscation.h")
	else:
		os.system("rm ./Makefile")
		os.system("rm ./Hooks/Obfuscation.h")
		os.system("rm ./CompileDefines.xm")
def BuildMakeFile():
	global randomTweakName
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
	global LinkerString
	makeFileString += "ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000,-sectcreate,WTFJH,SIGDB,./SignatureDatabase.plist"+LinkerString+"\n"
	makeFileString += randomTweakName + "_LIBRARIES = sqlite3 substrate\n"
	makeFileString += randomTweakName + "_FRAMEWORKS = Foundation UIKit Security\n"
	makeFileString += "include $(THEOS_MAKE_PATH)/tweak.mk\n"
	makeFileString += "after-install::\n"
	makeFileString += "	install.exec \"killall -9 SpringBoard\""
	fileHandle = open('Makefile', 'w')
	fileHandle.flush() 
	fileHandle.write(makeFileString)
	fileHandle.close() 
def LINKTHEOS():#For God's Sake. Keep Your Codes Clean is IMPORTANT. We'll Remove It Later
	if (os.path.exists("theos") == False):
		print "TheOS link doesn't exist, creating..."
		if (os.environ.get('THEOS') != None):
			os.system("ln -s $THEOS theos; mkdir .theos; mkdir .theos/obj; ln -s ./.theos/obj obj")
		else:
			print "$THEOS ENV not set."
			sys.exit(255)
	else:
		print "TheOS link exists at " + os.getcwd() + "/theos" + ", building..."


def FixControlFile(Path):#BuildVersion Stuff
	global currentVersion
	file = open(Path,"a")
	version = open('./VERSION', "r")
	currentVersion = int(version.read())
	file.write("\nVersion: " + str(currentVersion) + "\n")
	version.close()
	file.close()
	version = open('./VERSION', "w")
	version.write(str(currentVersion+1))
	version.close()


def ModuleIter(Path):#A List of Core Modules
	List = listdir(Path)
	for x in List:
		if (x.endswith(".xm") == True):
		#Obfuscate C++ Hooks
			if OBFUSCATION==True:
				pattern = re.compile(r'MSHookFunction\(.*;')
				rawcontent=open(Path+x,"r").read()
				result = pattern.findall(rawcontent)
				if result!=None:
					for z in result:
						#print z
						Splitlist=z.split(",")
						lengthSplit=len(Splitlist)
						newfunction=Splitlist[lengthSplit-2]
						oldpointer=Splitlist[lengthSplit-1]
						#Hacky Method To Get Function Names
						newfunction=newfunction.replace(" ","").replace("&","").replace("*","").replace("(","").replace(")","").replace(";","").replace("void","")
						oldpointer=oldpointer.replace(" ","").replace("&","").replace("*","").replace("(","").replace(")","").replace(";","").replace("void","")
						#print "newfunction"+newfunction
						#print "oldpointer"+oldpointer
						ManualObflist.append(newfunction)
						ManualObflist.append(oldpointer)
				else:
					print z+" has no Match"
			#End CPP Obfuscation
			componentList = x.split(".")
			componentName = ""
			i = 0
			while i < len(componentList[i]) - 1: #ModuleName
				componentName += componentList[i]
				if DEBUG==True:
					print (Fore.GREEN +"Injecting " + componentName + " into module list...")
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


def MakeFileIter(Path):#Iterate All Code Files
		FileList = listdir(Path)
		for x in FileList:
			if (x.endswith(".mm") == False and x.endswith(".m") == False and x.endswith(".xm") == False):
				if DEBUG==True:
					print (Fore.RED +x + " has been ignored.")
			else:	
				string = " " + Path + x
				if DEBUG==True:
					print (Fore.GREEN +"Injecting" + string + " into Makefile...")
				global MakeFileListString
				MakeFileListString += string


def subModuleList():#Core Module Iterator Wrapper So We Support Iterating Different Paths
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
	Plist["items"].append(Dict)#Code-Signature Based Objc-Deobfuscation Confidence
	Dict = {
		"cell": "PSEditTextCell",
		"keyboard": "numbers",
		"placeholder": 0.8,
		"bestGuess":0.8,
		"isNumeric": True,
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
 		if x.upper() == "OBFUSCATION":
 			print "Obfuscation Enabled"
 			global OBFUSCATION
 			OBFUSCATION=True
def Obfuscation():
	if OBFUSCATION==False:
		print "No Obfuscation"
		os.system("echo \" \" >./Hooks/Obfuscation.h")#Clean Up Previous Obfuscation Defines
	else:
		obf=open("./Hooks/Obfuscation.h","w")
		for name in ModuleList:
			randname=id_generator(chars=string.ascii_uppercase +string.ascii_lowercase)
			defineString="#define init_"+name+"_hook "+randname+"\n"
			ObfDict["init_"+name+"_hook"]=randname
			obf.write(defineString)
		for name2 in ManualObflist:
			randname=id_generator(chars=string.ascii_uppercase +string.ascii_lowercase)
			obf.write("#define "+name2+" "+randname+"\n")
			ObfDict[name2]=randname
		obf.close()
def BuildLoader(ModuleName):
	Template=open("ThirdPartyTemplate.xm","r").read().replace("TEMPLATENAME",ModuleName)
	f=open("./Hooks/ThirdPartyTools/"+ModuleName+".xm","w")
	f.write(Template)
	f.close()
def buildThirdPartyComponents():
	os.system("find . -type f -name .DS_Store -delete && xattr -cr *")
	for x in listdir("./ThirdPartyTools"):
		if os.path.isdir("./ThirdPartyTools/"+x)==False:
			pass
		else:
			print "ThirdPartyTools---Building:",x
			if len(x)>16:
				print (Fore.RED +"Name Length Must Be Smaller Than 16")
				print (Fore.RED +"Error Would Occur During Linking")
				cleanUp()
				sys.exit(255)
			if os.path.isfile("./Hooks/ThirdPartyTools/"+x+".xm")==False:
				print (Fore.RED +"Loader For "+x+" Doesn't Exist. Creating")
				BuildLoader(x)
				LoaderList.append(x)
			if (DEBUG):
				os.system("cd ./ThirdPartyTools/"+x+"/ &&make")
				os.system("mv ./ThirdPartyTools/"+x+"/obj/"+x+".dylib ./")
			else:
				try:
					subprocess.check_call(["cd ./ThirdPartyTools/"+x+" && make"], stdout=open("ThirdPartyLog.log", 'a'), stderr=subprocess.STDOUT, shell=True)

					os.system("mv ./ThirdPartyTools/"+x+"/obj/"+x+".dylib ./")
				except Exception as inst:
					print inst
					print  (Fore.RED +"Build "+x+"Went Wrong. Rerun With DEBUG to see output")
					cleanUp()
					sys.exit(255)
			global LinkerString
			LinkerString += ",-sectcreate,WTFJH,"+x+",./"+x+".dylib"
def main():
	ParseArgs()
	# Generate random Name to bypass detection
	# os.remove("./Makefile")
	os.system("echo \' \' >./MainLog.log")
	os.system("echo \' \' >./ThirdPartyLog.log")
	global randomTweakName
	randomTweakName = id_generator()
	buildThirdPartyComponents()#Call This Before Generating Makefile for a complete Linker Flags.
	#Call buildThirdPartyComponents() before generating Makefile. Or else the loaders won't be injected
	toggleModule()
	subModuleList()
	LINKTHEOS()
	BuildPF()
	Obfuscation()
	BuildMakeFile()
	os.system("cp ./WTFJH.plist ./" + randomTweakName + ".plist")
	print (Fore.YELLOW +"DEBUG:"+str(DEBUG))
	print (Fore.YELLOW +"PROTOTYPE:"+str(PROTOTYPE))
	print (Fore.YELLOW +"OBFUSCATION:"+str(OBFUSCATION))
	buildSuccess=True
	#Start Sanity Check
	for name in listdir("./Hooks/ThirdPartyTools"):
		if name.endswith(".xm")==False:
			pass
		else:
			name=name.replace(".xm","")
			if os.path.isfile("./Hooks/ThirdPartyTools/"+name+".xm")==False:
				print "File Missing At:"+"./Hooks/ThirdPartyTools/"+name
				print name+"Loader Exists. But Binary Missing"
				cleanUp()
				sys.exit(0)

	#end
	if (DEBUG == True):
		print "Building... Main"
		x=os.system("make")
		print "Make Exit With Status: ",x
		if x!=0:
			buildSuccess=False
			print (Fore.RED+"Error Occured.Quit")
	else:
		with open("MainLog.log", 'a') as devnull:
			try:
				print "Building... Main"
				x = subprocess.check_call(['make'], stdout=devnull, stderr=subprocess.STDOUT)
				print "Make Exit With Status: ",x
				os.system("rm ./CompileDefines.xm")
			except Exception as inst:
				buildSuccess=False
				print inst
				print (Fore.RED +"Error During Compile,Rerun With DEBUG as Argument to See Output")
				os.system("rm ./" + randomTweakName + ".plist")
				os.system("rm ./Makefile")
				os.system("rm ./CompileDefines.xm")
#Packaging
	if buildSuccess==True:
		os.system("mkdir -p ./layout/DEBIAN; cp ./control ./layout/DEBIAN/control")
		FixControlFile("./layout/DEBIAN/control")
		os.system("mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries; cp ./obj/" + randomTweakName + ".dylib" + " ./layout/Library/MobileSubstrate/DynamicLibraries/")
		os.system("cp ./WTFJH.plist" + " ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".plist")
		# Cleaning finder caches, thanks to http://stackoverflow.com/questions/2016844/bash-recursively-remove-files
		os.system("find . -type f -name .DS_Store -delete && xattr -cr *")
		os.system("dpkg-deb -Zgzip -b ./layout ./Build-"+str(currentVersion)+".deb")
	cleanUp()
	if buildSuccess==True:
		print (Fore.YELLOW +"Built with components: \n")
		for x in ModuleList:
			print (Fore.YELLOW +x)
		if OBFUSCATION==True:
			for x in ObfDict.keys():
				print (Fore.CYAN +x+" Obfuscated To: "+ObfDict[x]+"\n")#Separate Lines For Readablity
	print "Unlinking TheOS..."
	os.system("rm ./theos")
	os.system("rm ./ManualObfuscation.pyc")
	os.system("rm -r ./.theos")
	print "Finished."

if __name__ == "__main__":
    main()
