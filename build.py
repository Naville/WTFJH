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
global JailedHostIP
JailedHostIP = "192.168.1.107"
makeFileString = ""
#When Adding Path To The List. Please Strictly Follow This Format. i.e. "FOLDER/TYPE/". Or buildPF() will produce incorrect results
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
HostName=subprocess.check_output("hostname -s", shell=True).replace("\n","")+".local"
global AllowedSourceExtension
AllowedSourceExtension=[".cpp",".xm",".xmi",".mm",".c",".m",".x",".xi"]
global theospathmid
theospathmid="//"
global ModuleDict
ModuleDict=dict()
global ThirdPartList
ThirdPartList=list()
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
...
