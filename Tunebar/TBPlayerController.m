#import "TBPlayerController.h"
#import "TBiTunesController.h"
#import "TBRdioController.h"

@implementation TBPlayerController

- (id)init {
    self = [super init];
    if (self) {
        [self registerNotifications];
    }
    
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:[self currentPlayer]];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [[self currentPlayer] methodSignatureForSelector:selector];
}

- (void)playerStateChanged:(NSNotification *)notification {
    if (notification.name == @"com.apple.iTunes.playerInfo"
        && ![[self currentPlayer] isKindOfClass:[TBiTunesController class]]) {
        
        _currentPlayer = [[TBiTunesController alloc] init];
        
    } else if (notification.name == @"com.rdio.desktop.playStateChanged"
               && ![[self currentPlayer] isKindOfClass:[TBRdioController class]]) {
        
        _currentPlayer = [[TBRdioController alloc] init];
        
    }
    [self postPlayerStateChangedNotification];
}

#pragma mark -
#pragma mark Player notifications

- (void)registerNotifications {
    NSArray *players = [NSArray arrayWithObjects:@"com.apple.iTunes.playerInfo", @"com.rdio.desktop.playStateChanged", nil];
    
    for (NSString *player in players) {
        [self registerNotificationForName:player];
    }
}

- (void)registerNotificationForName:(NSString *)name {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(playerStateChanged:)
                                                            name:name
                                                          object:nil];
}

#pragma mark Internal notifications

- (void)registerForNotificationWithObserver:(id)observer selector:(SEL)selector {
    if ([observer respondsToSelector:selector]) {
        [[NSNotificationCenter defaultCenter] addObserver:observer
                                                 selector:selector
                                                     name:NOTIFICATION_NAME
                                                   object:nil];
    }
}

- (void)postPlayerStateChangedNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:self];
}

#pragma mark -

- (id)currentPlayer {
    if (_currentPlayer == nil) {
        _currentPlayer = [[TBRdioController alloc] init];
    }
    return _currentPlayer;
}

@end
