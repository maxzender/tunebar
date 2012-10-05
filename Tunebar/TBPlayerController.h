#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"

#define NOTIFICATION_NAME @"playerStateChanged"


@interface TBPlayerController : NSObject {
    id <TBPlayerDelegate> _currentPlayer;
}

- (void)registerForNotificationWithObserver:(id)observer selector:(SEL)selector;

@end
