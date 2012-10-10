#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"
@class SpotifyApplication;

@interface TBSpotifyPlayer : NSObject <TBPlayerDelegate> {
    SpotifyApplication *_spotify;
}

@end

