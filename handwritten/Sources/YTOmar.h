// ============================================================
//  YTOmar.h — الرأس المشترك / التعريفات
//  Developer: Omar Alenezi — Telegram: @o5252i
// ============================================================
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// مفتاح التخزين الموحّد لكل الإعدادات
#define YTOMAR_DOMAIN @"com.omarshouf.ytomar"

// قارئ إعداد موحّد (افتراضياً كل الميزات مفعّلة ما لم يُطفئها المستخدم)
static inline BOOL YTOmarPref(NSString *key, BOOL defaultOn) {
    NSUserDefaults *d = [[NSUserDefaults alloc] initWithSuiteName:YTOMAR_DOMAIN];
    id v = [d objectForKey:key];
    return v ? [v boolValue] : defaultOn;
}

static inline double YTOmarDouble(NSString *key, double fallback) {
    NSUserDefaults *d = [[NSUserDefaults alloc] initWithSuiteName:YTOMAR_DOMAIN];
    id v = [d objectForKey:key];
    return v ? [v doubleValue] : fallback;
}

// ---- تصريحات كلاسات يوتيوب المستخدمة (مستخرجة من الملفات الأصلية) ----
@interface YTHotConfig : NSObject @end
@interface YTColdConfig : NSObject @end
@interface YTPlayerViewController : UIViewController @end
@interface YTSettingsSectionItemManager : NSObject @end
@interface YTMainAppVideoPlayerOverlayViewController : UIViewController @end
@interface YTVersionUtils : NSObject @end
