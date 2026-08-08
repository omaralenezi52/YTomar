// ============================================================
//  00_Boot.x — بصمة الإقلاع + الحقوق
//  يُطبع في الكونسول عند تحميل الـ dylib للتأكيد أن الملف الموحّد اشتغل.
//  Developer: Omar Alenezi — Telegram: @o5252i
// ============================================================
#import "YTOmar.h"

%ctor {
    NSLog(@"[YTomar] ✅ loaded — unified tweak by Omar Alenezi (Telegram: @o5252i) v1.0.0");
    NSLog(@"[YTomar] modules: NoPremium · PiP · UHD/4K · Quality · Speed · ClassicMenu · DontEatMyContent · IAmYouTube");
}
