#import "TBPlayerController.h"
#import "TBiTunesController.h"
#import "TBRdioController.h"

@implementation TBPlayerController

- (id)init {
    self = [super init];
    if (self) {
        _players = [NSDictionary dictionaryWithObjectsAndKeys:@"com.apple.iTunes.playerInfo",
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
    for (NSString *player in _players) {
        [self registerNotificationForName:[_players objectForKey:player]];
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
    TBiTunesController *iTunes = [[TBiTunesController alloc] init];
    
    if ([iTunes isPlaying]) {
         player = iTunes;
    } else {
        TBRdioController *rdio = [[TBRdioController alloc] init];
        
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
    
    if ([notification.name isEqualToString:[_players objectForKey:@"iTunes"]]
        && ![[self currentPlayer] isKindOfClass:[TBiTunesController class]]) {

        player = [[TBiTunesController alloc] init];
        
    } else if ([notification.name isEqualToString:[_players objectForKey:@"Rdio"]]
               && ![[self currentPlayer] isKindOfClass:[TBRdioController class]]) {

        player = [[TBRdioController alloc] init];
        
    } else {
        player = _currentPlayer;
    }
    
    return player;
}

@end
