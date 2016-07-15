include theos/makefiles/common.mk
TWEAK_NAME = classdumpdyld
classdumpdyld_FILES = classdumpdyldlib.xm
classdumpdyld_LDFLAGS = -lsubstrate
classdumpdyld_LDFLAGS += -Wl,-segalign,0x4000
include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/library.mk
