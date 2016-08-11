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
import signal
from os import listdir
from colorama import init
from colorama import Fore, Back, Style
import BuildConfig
init(autoreset=True)
STDOUT=open("STDOUT.log", 'a')
STDERR=open("STDERR.log", 'a')

def Exec(Command):
	try:
		subprocess.check_call([Command], stdout=STDOUT, stderr=STDERR, shell=True)
	except:
		pass

# Global config
makeFileString = ""
PathList = ["Hooks/API/", "Hooks/SDK/", "Hooks/Utils/","Hooks/ThirdPartyTools/","Hooks/Misc/"]
ManualObflist=BuildConfig.ManualList
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
global SkippedList
SkippedList=list()
global InitialCWD
InitialCWD=os.getcwd()
global JAILED
JAILED=False
global buildCommand
buildCommand="make debug=0"
global HostName
HostName=subprocess.check_output("hostname -s", shell=True).replace("\n","")
global AllowedSourceExtension
AllowedSourceExtension=[".cpp",".xm",".xmi",".mm",".c",".m",".x",".xi"]

def isSource(FileName):
	for End in AllowedSourceExtension:
		if FileName.upper().endswith(End.upper()):
			return True
	return False

#Setup SIGINT Handler
def signal_handler(signal, frame):
	print (Fore.RED+"\nForce-Quit,Cleaning-Up")
	cleanUp()
	print "ByeBye"
	sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)
#End


def buildlistdir(path):#So We Can Intercept And Remove Unwanted Modules
	fileList=listdir(path)
	for x in SkippedList:
		for y in fileList:
			if (y == x+".xm"):#Only Remove Module Files
				fileList.remove(y)
				print (Fore.RED+y+" Removed From Modules")
	return fileList
def Thirdbuildlistdir(path):#So We Can Intercept And Remove Unwanted Modules
	fileList=listdir(path)
	for x in SkippedList:
		for y in fileList:
			if (x == y):#Only Remove Module Files
				fileList.remove(y)
				print (Fore.RED+y+" Removed From Third Party Modules")
	return fileList
#Clean-Up
def cleanUp():
	print (Fore.YELLOW +"Cleaning Misc Files")
	Exec("rm ./layout/DEBIAN/control")
	Exec("rm ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".dylib")
	Exec("rm -rf ./obj")
	Exec("rm ./layout/Library/PreferenceLoader/Preferences/WTFJHPreferences.plist")
	Exec("rm ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".plist")
	Exec("rm ./" + randomTweakName + ".plist")
	Exec("rm ./*.dylib")
	Exec("rm ./*.pyc")
	print "Unlinking TheOS..."
	Exec("unlink ./theos")
	Exec("rm ./BuildConfig.pyc")
	Exec("rm -r ./.theos")
	for x in buildlistdir("./ThirdPartyTools"):
		if os.path.isdir("./ThirdPartyTools/"+x):
			Exec("rm -rf ./ThirdPartyTools/"+x+"/obj/")
			Exec("rm -rf ./ThirdPartyTools/"+x+"/.theos/")
			Exec("unlink ./ThirdPartyTools/"+x+"/theos/")
			Exec("rm -rf ./"+x+".dylib")
	for x in LoaderList:
		#Clean-Up Auto-Generated Loaders
		print (Fore.YELLOW +"Cleaning:"+x+"Loader")
		Exec("rm ./Hooks/ThirdPartyTools/"+x+".xm")
	if (DEBUG):
		print (Fore.YELLOW +'Debugging mode, without removing Inter-compile files.')
		if OBFUSCATION==False:
			Exec("rm ./Hooks/Obfuscation.h")
	else:
		Exec("rm ./Makefile")
		Exec("rm ./Hooks/Obfuscation.h")
		Exec("rm ./CompileDefines.xm")
def BuildMakeFile():
	global randomTweakName
	global makeFileString
	makeFileString += "export CFLAGS=-Wp,\"-DWTFJHTWEAKNAME="+"@\\\""+randomTweakName+"\\\""
	if(PROTOTYPE):
		makeFileString += ",-DPROTOTYPE"
	if(JAILED):
		makeFileString += ",-DNonJailbroken"
	makeFileString+=",\"-DWTFJHHostName="+"@\\\""+HostName+"\\\""
	makeFileString += "\n"
	makeFileString += "include $(THEOS)/makefiles/common.mk\n"
	#makeFileString += "export ARCHS = armv7 armv7s arm64\n"
	#makeFileString += "export TARGET = iphone:clang:7.0:7.0\n"
	makeFileString += "TWEAK_NAME = " + randomTweakName + "\n"
	makeFileString += "SUBSTRATE ?= yes\n"
	if(JAILED==True):
		makeFileString += randomTweakName+"_USE_SUBSTRATE = $(SUBSTRATE)\n"
	makeFileString += randomTweakName + MakeFileListString + "\n"
	makeFileString += randomTweakName +"_CCFLAGS  = -Qunused-arguments"
	for CCFlag in BuildConfig.ExtraCCFlags:
		makeFileString +=" "+CCFlag
	makeFileString+="\n"
	global LinkerString
	makeFileString += randomTweakName +"_LDFLAGS  = -Wl,-segalign,4000,-sectcreate,WTFJH,SIGDB,./SignatureDatabase.plist"+LinkerString+" "
	for LDF in BuildConfig.LDFLAGS:
		makeFileString +=" "+LDF
	makeFileString +=" \n"	
	makeFileString +=randomTweakName +"_CFLAGS = "
	for CFlag in BuildConfig.ExtraCFlags:
		makeFileString +=" "+CFlag
	makeFileString+="\n"
	makeFileString += randomTweakName + "_LIBRARIES = sqlite3 substrate stdc++ c++ "
	for LBName in BuildConfig.ExtraLibrary:
		makeFileString +=LBName+" "
	makeFileString +=" \n"
	makeFileString += randomTweakName + "_FRAMEWORKS = Foundation UIKit Security JavaScriptCore "
	for FWName in BuildConfig.ExtraFramework:
		makeFileString +=FWName+" "
	makeFileString +=" \n"
	if len(BuildConfig.ExtraOBJFiles)>0:
		makeFileString += randomTweakName + "_OBJ_FILES ="
		for OBName in BuildConfig.ExtraOBJFiles:
			makeFileString +=OBName+" "
	makeFileString +=" \n"
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
			os.system("ln -s $THEOS theos && mkdir .theos && mkdir .theos/obj && ln -s ./.theos/obj obj")
		else:
			print "$THEOS ENV not set. Try Run ./InstallTheos.sh"

			os.system("ln -s $THEOS theos && mkdir .theos && mkdir .theos/obj && ln -s ./.theos/obj obj")

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
	List = buildlistdir(Path)
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
		FileList = buildlistdir(Path)
		for x in FileList:
			if (isSource(x)==False):
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
	CustomPrefList = buildlistdir("./Preferences")
	Plist = plistlib.readPlist('./BasePreferences.plist')
	
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
  		if x.upper() == "JAILED":
 			print "Attempting To Build For Jailed Device. ThirdPartyTools Are Disabled"
 			print "WTFJH is far more limited in JAILED MODE"
 			global JAILED
 			JAILED=True
 			global buildCommand
 			buildCommand += "SUBSTRATE=no"
 		if x.upper().startswith("DISABLE="):
 			tempList=x[8:].split(",")
 			for z in tempList:
 				SkippedList.append(z)
 		if x.upper().startswith("HostName="):
 			HostName=str(x[9:])
 	if(DEBUG==False):
 		buildCommand="make "
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
	Exec("find . -type f -name .DS_Store -delete && xattr -cr *")
	for x in Thirdbuildlistdir("ThirdPartyTools"):
		os.chdir(InitialCWD)#Make Sure CWD We've changed in buildThirdPartyComponents() is set back
		if os.path.isdir("ThirdPartyTools/"+x)==False:
			print (Fore.YELLOW+"ThirdPartyTools/"+x+" Not A Folder. Skipped")
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
				SubDirectoryPath="./ThirdPartyTools/"+x
				origCH=os.getcwd()
				os.chdir(SubDirectoryPath)
				os.system("unlink theos&&rm obj&&rm -rf .theos&&ln -s $THEOS theos&&mkdir .theos && mkdir .theos/obj&&ln -s .theos/obj obj&& make&&"+"mv ./obj/debug/"+x+".dylib ../../")	
				os.chdir(origCH)
			else:
				Error=None
				try:
					SubDirectoryPath="./ThirdPartyTools/"+x
					origCH=os.getcwd()
					os.chdir(SubDirectoryPath)
					Error=subprocess.check_call(["unlink theos&&rm obj&&rm -rf .theos&&ln -s $THEOS theos&&mkdir .theos && mkdir .theos/obj&&ln -s .theos/obj obj&& make &&"+"mv ./obj/debug/"+x+".dylib ../../"], stdout=STDOUT, stderr=STDERR, shell=True)		
					#sys.exit(0)	
					os.chdir(origCH)						
				except Exception as inst:
					if (isinstance(inst,subprocess.CalledProcessError) and (Error==None or Error==0)):
						print (Fore.YELLOW+"Minor Error Took Place When Building "+x+" ,Ignored")
					else:
						print  (Fore.RED +"Build "+x+"Went Wrong. Rerun With DEBUG to see output")
						cleanUp()
						sys.exit(255)
			global LinkerString
			LinkerString += ",-sectcreate,WTFJH,"+x+",./"+x+".dylib"
def main():
	#os.system("unset THEOS")#Latest Theos Brings Shit
	ParseArgs()
	LINKTHEOS()
	os.system("echo \" \" >./Hooks/Obfuscation.h")
	# Generate random Name to bypass detection
	global randomTweakName
	randomTweakName = id_generator()
	buildThirdPartyComponents()#Call This Before Generating Makefile for a complete Linker Flags.
	#Call buildThirdPartyComponents() before generating Makefile. Or else the loaders won't be injected
	os.chdir(InitialCWD)#Make Sure CWD We've changed in buildThirdPartyComponents() is set back
	toggleModule()
	subModuleList()
	BuildPF()
	Obfuscation()
	BuildMakeFile()
	os.system("cp ./WTFJH.plist ./" + randomTweakName + ".plist")
	print (Fore.YELLOW +"DEBUG:"+str(DEBUG))
	print (Fore.YELLOW +"PROTOTYPE:"+str(PROTOTYPE))
	print (Fore.YELLOW +"OBFUSCATION:"+str(OBFUSCATION))
	print (Fore.YELLOW +"JAILED:"+str(JAILED))
	print (Fore.YELLOW +"HostName Set To:"+str(HostName))
	buildSuccess=True
	#Start Sanity Check
	for name in buildlistdir("./Hooks/ThirdPartyTools"):
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
		x=os.system(buildCommand)
		print "Make Exit With Status: ",x
		if x!=0:
			buildSuccess=False
			print (Fore.RED+"Error Occured.Quit")
	else:
		try:
			print "Building... Main"
			print os.getcwd()
			x = subprocess.check_call([buildCommand], stdout=STDOUT, stderr=STDERR,shell=True)
			print "Make Exit With Status: ",x
		except Exception as inst:
			buildSuccess=False
			print inst
			print (Fore.RED +"Error During Compile,Rerun With DEBUG as Argument to See Output")
#Packaging
	if buildSuccess==True:
		os.system("mkdir -p ./layout/DEBIAN; cp ./control ./layout/DEBIAN/control")
		FixControlFile("./layout/DEBIAN/control")
		os.system("mkdir -p ./layout/Library/MobileSubstrate/DynamicLibraries; cp ./obj/debug/" + randomTweakName + ".dylib" + " ./layout/Library/MobileSubstrate/DynamicLibraries/")
		os.system("cp ./WTFJH.plist" + " ./layout/Library/MobileSubstrate/DynamicLibraries/" + randomTweakName + ".plist")
		# Cleaning finder caches, thanks to http://stackoverflow.com/questions/2016844/bash-recursively-remove-files
		os.system("find . -type f -name .DS_Store -delete && xattr -cr *")
		os.system("dpkg-deb -Zgzip -b ./layout ./Packages/Build-"+str(currentVersion)+".deb")
	cleanUp()
	if buildSuccess==True:
		print (Fore.YELLOW +"Built with components: \n")
		for x in ModuleList:
			print (Fore.YELLOW +x)
		if OBFUSCATION==True:
			for x in ObfDict.keys():
				print (Fore.CYAN +x+" Obfuscated To: "+ObfDict[x]+"\n")#Separate Lines For Readablity
	print "Finished."
	if buildSuccess==False:
		sys.exit(255)

if __name__ == "__main__":
    main()