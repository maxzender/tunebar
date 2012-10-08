#import "TBRdioPlayer.h"
#import "Rdio.h"

@implementation TBRdioPlayer

- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier {
    self = [super init];
    if (self) {
        _rdio = [SBApplication applicationWithBundleIdentifier:bundleIdentifier];
    }
    
    return self;
}

- (void)playButtonPressed {
    [_rdio playpause];
}

- (void)nextButtonPressed {
    if ([_rdio isRunning]) {
        [_rdio nextTrack];
    }
}

- (void)previousButtonPressed {
    if ([_rdio isRunning]) {
        [_rdio previousTrack];
    }
}

- (BOOL)isPlaying {
    BOOL isPlaying = NO;
    if ([_rdio isRunning]) {
        isPlaying = _rdio.playerState == RdioEPSSPlaying;
    }
    
    return isPlaying;
}

- (NSString *)getTrackName {
    NSString *currentTrackName = @"";
    if ([_rdio isRunning]) {
        currentTrackName = _rdio.currentTrack.name;
    }
    
    return currentTrackName;
}

- (NSString *)getAlbum {
    NSString *currentAlbum = @"";
    if ([_rdio isRunning]) {
        currentAlbum = _rdio.currentTrack.album;
    }
    
    return currentAlbum;
}

- (NSString *)getArtist {
    NSString *currentArtist = @"";
    if ([_rdio isRunning]) {
        currentArtist = _rdio.currentTrack.artist;
    }
    
    return currentArtist;
}

- (NSImage *)getArtwork {
    NSImage *artwork = [NSImage imageNamed:@"artwork_default"];

    if ([_rdio isRunning]) {
        artwork = _rdio.currentTrack.artwork;
    }
    
    return artwork;
}

- (double)progress {
    double progress = 0.0;
    if ([_rdio isRunning]) {
        double duration = _rdio.currentTrack.duration;
        double playerPosition = _rdio.playerPosition;
        if (duration > 0.0 && playerPosition > 0.0) {
            progress = playerPosition / 100;
        }
    }
    
    return progress;
}

@end
