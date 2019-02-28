ARCHS = arm64
export GO_EASY_ON_ME=1
include $(THEOS)/makefiles/common.mk
export SDKVERSION= 12.1.2
TWEAK_NAME = WechatFakeSteps
WechatFakeSteps_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += wechatsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
