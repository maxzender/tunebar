#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"

#define NOTIFICATION_NAME @"playerStateChanged"

@interface TBPlayerDispatcher : NSObject {
    id <TBPlayerDelegate> _currentPlayer;
    NSDictionary *_playerNotificationNames;
}

- (void)registerForNotificationWithObserver:(id)observer selector:(SEL)selector;

@end
