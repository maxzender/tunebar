#import "TBiTunesPlayer.h"
#import "iTunes.h"

@implementation TBiTunesPlayer

- (id)init {
    self = [super init];
    if (self) {
        _iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    }
    
    return self;
}

- (void)playButtonPressed {
    [_iTunes playpause];
}

- (void)nextButtonPressed {
    if ([_iTunes isRunning]) {
        [_iTunes nextTrack];
    }
}

- (void)previousButtonPressed {
    if ([_iTunes isRunning]) {
        [_iTunes backTrack];
    }
}

- (BOOL)isPlaying {
    BOOL isPlaying = NO;
    if ([_iTunes isRunning]) {
        isPlaying = _iTunes.playerState == iTunesEPlSPlaying;
    }
    
    return isPlaying;
}

- (NSString *)getTrackName {
    NSString *currentTrackName = @"";
    if ([_iTunes isRunning]) {
        currentTrackName = _iTunes.currentTrack.name;
    }
    
    return currentTrackName;
}

- (NSString *)getAlbum {
    NSString *currentAlbum = @"";
    if ([_iTunes isRunning]) {
        currentAlbum = _iTunes.currentTrack.album;
    }
    
    return currentAlbum;
}

- (NSString *)getArtist {
    NSString *currentArtist = @"";
    if ([_iTunes isRunning]) {
        currentArtist = _iTunes.currentTrack.artist;
    }
    
    return currentArtist;
}

- (NSImage *)getArtwork {
    NSImage *artwork = [NSImage imageNamed:@"artwork_default"];
    
    if ([_iTunes isRunning]) {
        SBElementArray *iTunesArtworks = _iTunes.currentTrack.artworks;
        if ([iTunesArtworks count] > 0) {
            artwork = [[NSImage alloc] initWithData:[[iTunesArtworks objectAtIndex:0] rawData]];
        }
    }

    return artwork;
}

- (double)progress {
    double progress = 0.0;
    if ([_iTunes isRunning]) {
        double duration = _iTunes.currentTrack.duration;
        double playerPosition = _iTunes.playerPosition;
        if (duration > 0.0 && playerPosition > 0.0) {
            progress = playerPosition / duration;
        }
    }

    return progress;
}

@end
