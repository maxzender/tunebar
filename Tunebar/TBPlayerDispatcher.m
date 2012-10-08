#import "TBPlayerDispatcher.h"
#import "TBiTunesPlayer.h"
#import "TBRdioPlayer.h"

@implementation TBPlayerDispatcher

- (id)init {
    self = [super init];
    if (self) {
        NSString *playerInfoFile = [[NSBundle mainBundle] pathForResource:@"PlayerInfo" ofType:@"plist"];
        NSDictionary *playerInfo = [NSDictionary dictionaryWithContentsOfFile:playerInfoFile];

        _playerData = [playerInfo objectForKey:@"SupportedPlayers"];
        _defaultPlayer = [playerInfo objectForKey:@"DefaultPlayer"];

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
    for (NSString *playerName in _playerData) {
        [self registerNotificationForName:[self notificationNameForPlayer:playerName]];
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
    id player = nil;
    id <TBPlayerDelegate> defaultPlayer = [self getInstanceForPlayer:_defaultPlayer];

    if ([defaultPlayer isPlaying]) {
        player = defaultPlayer;
    } else {
        // iterate over the remaining players
        NSEnumerator *enumerator = [_playerData keyEnumerator];
        NSString *playerName;
        id <TBPlayerDelegate> alternativePlayer;

        while ((playerName = [enumerator nextObject]) && player == nil) {

            if (playerName != _defaultPlayer) {

                alternativePlayer = [self getInstanceForPlayer:playerName];
                if ([alternativePlayer isPlaying]) {
                    player = alternativePlayer;
                }

            }

        }
    }
    
    return player;
}

- (id)getCurrentPlayerByNotification:(NSNotification *)notification {
    return [self getInstanceForPlayer:[self getPlayerNameByNotification:notification]];
}

#pragma mark -
#pragma mark Player data

- (NSString *)bundleIdentifierForPlayer:(NSString *)playerName {
    return [[_playerData objectForKey:playerName] objectForKey:@"bundleIdentifier"];
}

- (NSString *)notificationNameForPlayer:(NSString *)playerName {
    return [[_playerData objectForKey:playerName] objectForKey:@"notificationName"];
}

- (NSString *)getPlayerNameByNotification:(NSNotification *)notification {
    NSString *playerName;

    for (NSString *player in _playerData) {
        NSString *notificationName = [[_playerData objectForKey:player] objectForKey:@"notificationName"];
        
        if ([notificationName isEqualToString:notification.name]) {
            playerName = player;
        }
    }
    
    return playerName;
}

- (id)getInstanceForPlayer:(NSString *)playerName {
    Class playerClass = NSClassFromString([[_playerData objectForKey:playerName] objectForKey:@"className"]);
    id <TBPlayerDelegate> playerInstance = [[playerClass alloc] initWithBundleIdentifier:
                                            [self bundleIdentifierForPlayer:playerName]];

    return playerInstance;
}

@end
