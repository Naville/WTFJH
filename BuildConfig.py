#Put Your Lists Here
import os
ManualList=["GlobalInit","getBoolFromPreferences","RandomString"]
ExtraFramework=["UIKit","CoreGraphics","CoreFoundation","QuartzCore","CFNetwork"]
ExtraLibrary=[]
LDFLAGS=["-lz","-L.","-v","-force_load ./ExtraFWs/libcapstone.a","-force_load ./ExtraFWs/libLiberation.a","-force_load ./ExtraFWs/Reveal.framework/Reveal","-force_load ./ExtraFWs/Cycript.framework/Cycript","-F./ExtraFWs/","-Wno-unused-function"]
ExtraCFlags=["-I"+os.getcwd()+"/Hooks/"]
ExtraOBJFiles=[]
ExtraCCFlags=["-std=c++11"]
