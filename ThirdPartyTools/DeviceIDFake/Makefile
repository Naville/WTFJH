include theos/makefiles/common.mk
export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:9.1:9.1
ADDITIONAL_LDFLAGS  = -Wl,-segalign,4000
TWEAK_NAME = DeviceIDFake
DeviceIDFake_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 ="
