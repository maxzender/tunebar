#import "TBPlayerDispatcher.h"
#import "TBiTunesPlayer.h"
#import "TBRdioPlayer.h"

@implementation TBPlayerDispatcher

- (id)init {
    self = [super init];
    if (self) {
        _playerNotificationNames = [NSDictionary dictionaryWithObjectsAndKeys:@"com.apple.iTunes.playerInfo",
                    @"iTunes", @"com.rdio.desktop.playStateChanged", @"Rdio", nil];
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
    _currentPlayer = [self getCurrentPlayerByNotification:notification];
    [self postPlayerStateChangedNotification];
}

#pragma mark -
#pragma mark Player notifications

- (void)registerNotifications {
    for (NSString *notificationName in _playerNotificationNames) {
        [self registerNotificationForName:[_playerNotificationNames objectForKey:notificationName]];
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

#pragma mark Determining the current player

- (id)currentPlayer {
    if (_currentPlayer == nil) {
        _currentPlayer = [self getCurrentPlayer];
    }
    
    return _currentPlayer;
}

- (id)getCurrentPlayer {
    id player;
    TBiTunesPlayer *iTunes = [[TBiTunesPlayer alloc] init];
    
    if ([iTunes isPlaying]) {
         player = iTunes;
    } else {
        TBRdioPlayer *rdio = [[TBRdioPlayer alloc] init];
        
        if ([rdio isPlaying]) {
            player = rdio;
        } else {
            player = iTunes;
        }
    }
    
    return player;
}

- (id)getCurrentPlayerByNotification:(NSNotification *)notification {
    id player;
    
    if ([notification.name isEqualToString:[_playerNotificationNames objectForKey:@"iTunes"]]
        && ![[self currentPlayer] isKindOfClass:[TBiTunesPlayer class]]) {

        player = [[TBiTunesPlayer alloc] init];
        
    } else if ([notification.name isEqualToString:[_playerNotificationNames objectForKey:@"Rdio"]]
               && ![[self currentPlayer] isKindOfClass:[TBRdioPlayer class]]) {

        player = [[TBRdioPlayer alloc] init];
        
    } else {
        player = _currentPlayer;
    }
    
    return player;
}

@end
