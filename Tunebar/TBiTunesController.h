#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"
@class iTunesApplication;

@interface TBiTunesController : NSObject <TBPlayerDelegate> {
    iTunesApplication *_iTunes;
}

- (void)registerNotificationsWithObserver:(id)observer selector:(SEL)selector;

@end
