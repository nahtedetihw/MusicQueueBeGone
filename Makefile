THEOS_DEVICE_IP = 172.16.184.68

ARCHS = armv7 arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MusicQueueBeGone
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Music && killall -9 Preferences"
SUBPROJECTS += musicqueuebegoneprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

