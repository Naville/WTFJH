include theos/makefiles/common.mk
export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:7.0:7.0
TWEAK_NAME = SOGNMKIL2F72OW7
SOGNMKIL2F72OW7_FILES = Tweak.xm CompileDefines.xm Hooks/APIHooks/NSData.xm Hooks/APIHooks/NSURLConnection.xm Hooks/Utils/CallStackInspector.m Hooks/Utils/CallTracer.m Hooks/Utils/PlistObjectConverter.m Hooks/Utils/RuntimeUtils.m Hooks/Utils/SQLiteStorage.m Hooks/Utils/Utils.m
ADDITIONAL_CCFLAGS  = -Qunused-arguments
ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000
SOGNMKIL2F72OW7_LIBRARIES = sqlite3 substrate
SOGNMKIL2F72OW7_FRAMEWORKS = Foundation UIKit Security
include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"