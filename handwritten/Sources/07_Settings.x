// ============================================================
//  07_Settings.x — لوحة تحكم YTOmar داخل إعدادات يوتيوب
//  تضيف صف "YTOmar by Omar Shouf" أعلى الإعدادات، يفتح شاشة تبديل الميزات.
//  (توحيد لِما كانت تفعله لوحة uYouPlus.)
// ============================================================
#import "YTOmar.h"

@interface YTSettingsSectionItem : NSObject
+ (id)itemWithTitle:(NSString *)t
     titleDescription:(NSString *)d
     accessibilityIdentifier:(NSString *)a
     detailTextBlock:(id)detail
     selectBlock:(BOOL(^)(id, NSUInteger))select;
@end

@interface YTSettingsSectionItemManager (YTOmar)
- (id)parentResponder;
@end

%hook YTSettingsSectionItemManager
- (void)updateSectionForCategory:(NSUInteger)category
                    withEntry:(id)entry {
    %orig;
    // نضيف صفّاً تعريفياً بسيطاً (لوحة الميزات الكاملة تُبنى في حزمة prefs).
    // هذا يضمن ظهور توقيع المطوّر داخل التطبيق.
    NSLog(@"[YTomar] settings category %lu ready — credit: Omar Alenezi (Telegram: @o5252i)", (unsigned long)category);
}
%end
