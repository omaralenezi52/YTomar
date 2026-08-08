// ============================================================
//  02_PiP.x  ←  مبني على YouPiP.dylib
//  تفعيل Picture-in-Picture عبر إجبار MLPIPController على القبول.
// ============================================================
#import "YTOmar.h"

@interface MLPIPController : NSObject
- (BOOL)isPictureInPictureSupported;
- (BOOL)pictureInPicturePossible;
@end

%group PiP

%hook MLPIPController
- (BOOL)isPictureInPictureSupported { return YES; }
- (BOOL)pictureInPicturePossible   { return YES; }
%end

%end // group

%ctor {
    if (YTOmarPref(@"PiP", YES)) %init(PiP);
}
