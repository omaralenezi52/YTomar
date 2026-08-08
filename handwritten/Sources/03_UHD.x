// ============================================================
//  03_UHD.x  ←  مبني على YTUHD.dylib
//  يفتح جودات 4K/UHD بإخبار الإعدادات الساخنة أن الجهاز يدعمها.
// ============================================================
#import "YTOmar.h"

@interface YTIHotConfig : NSObject @end
@interface YTHotConfig (YTOmar)
- (id)mediaHotConfig;
@end

%group UHD

// إجبار قدرة الترميز/الدقة القصوى على أعلى قيمة
%hook YTHotConfig
- (BOOL)isHighResolutionEnabled { return YES; }
%end

// بعض إصدارات يوتيوب تحصر الدقة عبر hotConfig العام
%hook YTIMediaQualitySettingsHotConfig
- (BOOL)shouldEnableUhdOnCellular { return YES; }
- (long long)maxVideoQuality { return 2160; }
%end

%end // group

%ctor {
    if (YTOmarPref(@"UHD", YES)) %init(UHD);
}
