// ============================================================
//  01_NoPremium.x  ←  مبني على NoYTPremium.dylib
//  يكبح ترويج Premium والـ interstitials والاستبيانات.
//  الكلاسات الحقيقية مستخرجة من الملف الأصلي.
// ============================================================
#import "YTOmar.h"

%group NoPremium

// إيقاف نوافذ الترويج البينية
%hook YTPromoThrottleController
- (void)showPromoWithCompletion:(id)completion { /* مكبوح */ }
%end

// منع أوامر عرض الـ interstitial بملء الشاشة
%hook YTIShowFullscreenInterstitialCommand
- (BOOL)shouldShow { return NO; }
%end

// إخفاء قسم "الوصول المبكر لـ Premium" من الإعدادات
%hook YTSettingsSectionItemManager
- (void)updatePremiumEarlyAccessSectionWithEntry:(id)entry { /* لا شيء */ }
%end

// كتم مجموعة أحداث الترويج
%hook YTInterstitialPromoEventGroupHandler
- (void)handleEvent:(id)event { /* مكبوح */ }
%end

%end // group

%ctor {
    if (YTOmarPref(@"NoPremium", YES)) %init(NoPremium);
}
