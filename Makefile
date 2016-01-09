include theos/makefiles/common.mk
export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:7.0:7.0
TWEAK_NAME = PT07JKIB20DOR44
PT07JKIB20DOR44_FILES = Tweak.xm CompileDefines.xm
ADDITIONAL_CCFLAGS  = -Qunused-arguments
ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000
PT07JKIB20DOR44_LIBRARIES = sqlite3 substrate
include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"