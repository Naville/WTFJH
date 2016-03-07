#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys
import string
import random
from os import listdir
ValidType=["SDK","API","Utils","ThirdPartyTools"]
xmString = ""
outPath = "./Hooks/"
if (len(sys.argv) < 2):
	print "Template.py ModuleType ModuleName"
	sys.exit(-1)
if (sys.argv[1] not in ValidType):
	print "Wrong argument #1"
	print "Valid Arguments:"
	for x in ValidType:
		print x
	sys.exit(-1)
else:
	outPath = outPath + sys.argv[1]+"/" + sys.argv[2] + ".xm"
	xmString += "#import \"../SharedDefine.pch\"\n"
	xmString += "%group " + sys.argv[2] + "\n"
	xmString += "    // Insert Your Hooks Here\n"
	xmString += "%end\n"
	xmString += "extern void init_"+sys.argv[2]+"_hook() {\n"
	xmString += "    %init("+sys.argv[2]+");\n"
	xmString += "}\n"
	if (os.path.isfile(outPath) == False):
		os.system("echo \" \"> " + outPath)
		fileHandle = open(outPath, "w")
		fileHandle.write(xmString)
		fileHandle.close()
		print "Generated At" + outPath
	else:
		print "File already exists at " + outPath + "!\nFor safety reasons, generating has been cancelled.\nPlease manually remove that file."
