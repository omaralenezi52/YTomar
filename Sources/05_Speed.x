// ============================================================
//  05_Speed.x  ←  مبني على YoutubeSpeed.dylib
//  يوسّع خيارات سرعة التشغيل (حتى 4x بخطوات دقيقة).
// ============================================================
#import "YTOmar.h"

@interface YTVarispeedSwitchController : NSObject
- (NSArray *)options;
@end
@interface YTVarispeedSwitchControllerOption : NSObject
- (instancetype)initWithTitle:(NSString *)t rate:(float)rate;
@end

%group Speed

%hook YTVarispeedSwitchController
- (NSArray *)options {
    NSArray *orig = %orig;
    if (!YTOmarPref(@"Speed", YES)) return orig;

    NSArray *rates = @[@0.25, @0.5, @0.75, @1.0, @1.25, @1.5, @1.75,
                       @2.0, @2.5, @3.0, @3.5, @4.0];
    NSMutableArray *opts = [NSMutableArray array];
    for (NSNumber *r in rates) {
        float rate = r.floatValue;
        NSString *title = (rate == 1.0) ? @"Normal"
                          : [NSString stringWithFormat:@"%.2gx", rate];
        id opt = [[%c(YTVarispeedSwitchControllerOption) alloc]
                    initWithTitle:title rate:rate];
        if (opt) [opts addObject:opt];
    }
    return opts.count ? opts : orig;
}
%end

%end // group

%ctor {
    if (YTOmarPref(@"Speed", YES)) %init(Speed);
}
