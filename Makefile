THEOS_DEVICE_IP = 192.168.0.11

ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MusicQueueBeGone

$(TWEAK_NAME)_FILES = Tweak.xm
# $(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Music"
include $(THEOS_MAKE_PATH)/aggregate.mk

