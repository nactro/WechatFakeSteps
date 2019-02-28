ARCHS = arm64
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = WechatSettings
WechatSettings_FILES = WechatSettingsRootListController.m NactroCreditOption.m NactroCreditService.m NactroCreditCell.m UIColor+Hex.m UIFont+Extension.m NactroHeaderView.m
WechatSettings_INSTALL_PATH = /Library/PreferenceBundles
WechatSettings_FRAMEWORKS = UIKit
WechatSettings_PRIVATE_FRAMEWORKS = Preferences
export GO_EASY_ON_ME=1


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WechatSettings.plist$(ECHO_END)
