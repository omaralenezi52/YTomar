## YTomar — واجهة يوتيوب موحّدة في dylib واحد
## Developer / الحقوق: Omar Alenezi — Telegram: @o5252i
## البناء عبر Theos على macOS أو Linux. المخرج: .theos/obj/YTomar.dylib

TARGET := iphone:clang:latest:14.0
ARCHS  = arm64 arm64e
INSTALL_TARGET_PROCESSES = YouTube

TWEAK_NAME = YTomar

# كل ملفات المصدر داخل Sources/ تُجمّع في dylib واحد
YTomar_FILES    = $(wildcard Sources/*.x)
YTomar_CFLAGS   = -fobjc-arc -Wno-deprecated-declarations -ISources
YTomar_FRAMEWORKS = UIKit Foundation AVKit AVFoundation

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
