// ============================================================
//  04_Quality.x  ←  مبني على YouQuality.dylib + YTClassicVideoQuality.dylib
//  (1) يثبّت جودة افتراضية يختارها المستخدم.
//  (2) يرجّع قائمة اختيار الجودة الكلاسيكية بدل المعاد تصميمها.
// ============================================================
#import "YTOmar.h"

@interface YTSingleVideoController : NSObject
- (void)setVideoQuality:(NSInteger)q;
@end

%group Quality

// القائمة الكلاسيكية: توجيه المعاد تصميمه للأصلي
%hook YTVideoQualitySwitchRedesignedController
+ (id)alloc {
    if (YTOmarPref(@"ClassicMenu", YES)) {
        Class orig = %c(YTVideoQualitySwitchOriginalController);
        if (orig) return [orig alloc];
    }
    return %orig;
}
%end

// إتاحة قائمة الجودة السريعة دائماً
%hook YTIMediaQualitySettingsHotConfig
- (BOOL)enableQuickMenuVideoQualitySettings { return YES; }
%end

%end // group

%ctor {
    if (YTOmarPref(@"Quality", YES)) %init(Quality);
}
