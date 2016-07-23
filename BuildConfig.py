#Put Your Lists Here
ManualList=["GlobalInit","getBoolFromPreferences","RandomString"]
ExtraFramework=["UIKit","CoreGraphics","CoreFoundation","QuartzCore","CFNetwork"]
ExtraLibrary=[]
LDFLAGS=["-lz","-L.","-v","-force_load","./ExtraFWs/libcapstone.a","-force_load","./ExtraFWs/libkeystone.a","-F./ExtraFWs/"]
ExtraCFlags=[]
ExtraOBJFiles=["./ExtraFWs/Reveal.framework/Reveal","./ExtraFWs/Cycript.framework/Cycript"]
