#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"

#define NOTIFICATION_NAME @"playerStateChanged"


@interface TBPlayerController : NSObject {
    id <TBPlayerDelegate> _currentPlayer;
    NSDictionary *_players;
}

- (void)registerForNotificationWithObserver:(id)observer selector:(SEL)selector;

@end
