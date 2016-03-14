include theos/makefiles/common.mk

LIBRARY_NAME = classdumpdyld
classdumpdyld_FILES = classdumpdyldlib.mm
classdumpdyld_LDFLAGS = -lsubstrate
classdumpdyld_LDFLAGS += -Wl,-segalign,0x4000
include $(THEOS_MAKE_PATH)/library.mk
