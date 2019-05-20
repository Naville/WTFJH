#Put Your Lists Here
import os
ManualList=["GlobalInit","getBoolFromPreferences","RandomString"]
ExtraFramework=["UIKit","CoreGraphics","CoreFoundation","QuartzCore","CFNetwork","JavaScriptCore"]
ExtraLibrary=[]
LDFLAGS=["-lz","-L.","-v","-force_load ./ExtraFWs/libcapstone.a","-F./ExtraFWs/","-Wno-unused-function"]
ExtraCFlags=["-I"+os.getcwd()+"/Hooks/","-I"+os.getcwd()+"/capstone/include/"]
ExtraOBJFiles=[]
ExtraCCFlags=["-std=c++11"]
CreateExtraSegs={"FLEX":"./ExtraFWs/FLEX.framework/FLEX","Reveal2":"./Reveal2Server","Frida":"./ExtraFWs/frida-gadget.dylib"}
