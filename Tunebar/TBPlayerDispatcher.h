#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"

#define NOTIFICATION_NAME @"playerStateChanged"

@interface TBPlayerDispatcher : NSObject {
    id <TBPlayerDelegate> _currentPlayer;
    NSDictionary *_playerData;
    NSString *_defaultPlayer;
}

- (void)registerForNotificationWithObserver:(id)observer selector:(SEL)selector;

@end
