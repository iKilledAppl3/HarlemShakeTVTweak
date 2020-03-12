ARCHS = arm64
TARGET = appletv:clang
FINALPACKAGE = 1
SYSROOT = $(THEOS)/sdks/AppleTVOS12.4.sdk
THEOS_DEVICE_IP = 192.168.1.211

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HarlemShakeTVPrefs
HarlemShakeTVPrefs_FILES = $(wildcard *.mm)
HarlemShakeTVPrefs_INSTALL_PATH = /Library/PreferenceBundles
HarlemShakeTVPrefs_FRAMEWORKS = UIKit TVSettingKit
HarlemShakeTVPrefs_PRIVATE_FRAMEWORKS = TVSettingKit
HarlemShakeTVPrefs_CFLAGS+= -I. -ITVSettings -ITVSettingsKit -Wno-error
HarlemShakeTVPrefs_LDFLAGS = -undefined dynamic_lookup

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/HarlemShakeTVPrefs.plist$(ECHO_END)
