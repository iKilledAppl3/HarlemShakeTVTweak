ARCHS = arm64
TARGET = appletv:clang
FINALPACKAGE = 1
SYSROOT = $(THEOS)/sdks/AppleTVOS12.4.sdk
THEOS_DEVICE_IP = 192.168.1.211

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HarlemShakeTVTweak
HarlemShakeTVTweak_FILES = Tweak.xm VLMHarlemShakeModified.m
HarlemShakeTVTweak_FRAMEWORKS = UIKit AVFoundation AudioToolbox
HarlemShakeTVTweak_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 PineBoard"
SUBPROJECTS += harlemshaketvprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
