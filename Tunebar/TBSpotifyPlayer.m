#import "TBSpotifyPlayer.h"
#import "Spotify.h"

@implementation TBSpotifyPlayer

- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier {
    self = [super init];
    if (self) {
        _spotify = [SBApplication applicationWithBundleIdentifier:bundleIdentifier];
    }

    return self;
}

- (void)playButtonPressed {
    [_spotify playpause];
}

- (void)nextButtonPressed {
    if ([_spotify isRunning]) {
        [_spotify nextTrack];
    }
}

- (void)previousButtonPressed {
    if ([_spotify isRunning]) {
        [_spotify previousTrack];
    }
}

- (BOOL)isPlaying {
    BOOL isPlaying = NO;
    if ([_spotify isRunning]) {
        isPlaying = _spotify.playerState == SpotifyEPlSPlaying;
    }

    return isPlaying;
}

- (NSString *)getTrackName {
    NSString *currentTrackName = @"";
    if ([_spotify isRunning]) {
        currentTrackName = _spotify.currentTrack.name;
    }

    return currentTrackName;
}

- (NSString *)getAlbum {
    NSString *currentAlbum = @"";
    if ([_spotify isRunning]) {
        currentAlbum = _spotify.currentTrack.album;
    }

    return currentAlbum;
}

- (NSString *)getArtist {
    NSString *currentArtist = @"";
    if ([_spotify isRunning]) {
        currentArtist = _spotify.currentTrack.artist;
    }

    return currentArtist;
}

- (NSImage *)getArtwork {
    NSImage *artwork = [NSImage imageNamed:@"artwork_default"];

    if ([_spotify isRunning]) {
        artwork = _spotify.currentTrack.artwork;
    }

    return artwork;
}

- (double)progress {
    double progress = 0.0;
    if ([_spotify isRunning]) {
        double duration = _spotify.currentTrack.duration;
        double playerPosition = _spotify.playerPosition;
        if (duration > 0.0 && playerPosition > 0.0) {
            progress = playerPosition / duration;
        }
    }

    return progress;
}

@end
