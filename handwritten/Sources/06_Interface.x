// ============================================================
//  06_Interface.x  ←  DontEatMyContent.dylib + IAmYouTube.dylib
//  (1) منع قص/تكبير المحتوى وراء الحواف (safe-area / zoom).
//  (2) انتحال هوية يوتيوب الرسمية لدعم البثّ (Cast) وميزات الحساب.
// ============================================================
#import "YTOmar.h"

// ---------- DontEatMyContent ----------
@interface YTPlayerView : UIView @end

%group DEMC
%hook YTPlayerView
- (UIEdgeInsets)safeAreaInsets {
    if (YTOmarPref(@"DontEatMyContent", YES)) return UIEdgeInsetsZero;
    return %orig;
}
%end
%end

// ---------- IAmYouTube (هوية رسمية) ----------
%group IAmYouTube
%hook NSBundle
- (NSString *)bundleIdentifier {
    NSString *orig = %orig;
    if (YTOmarPref(@"IAmYouTube", YES) &&
        [orig hasPrefix:@"com.google.ios.youtube"]) {
        return @"com.google.ios.youtube";
    }
    return orig;
}
%end
%end

%ctor {
    if (YTOmarPref(@"DontEatMyContent", YES)) %init(DEMC);
    if (YTOmarPref(@"IAmYouTube", YES))        %init(IAmYouTube);
}
