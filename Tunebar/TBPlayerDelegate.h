#import <Foundation/Foundation.h>

@protocol TBPlayerDelegate <NSObject>

- (id)initWithBundleIdentifier:(NSString *)bundleIdentifier;
- (void)playButtonPressed;
- (void)nextButtonPressed;
- (void)previousButtonPressed;

- (BOOL)isPlaying;
- (NSString *)getArtist;
- (NSString *)getAlbum;
- (NSString *)getTrackName;
- (NSImage *)getArtwork;
- (double)progress;

@end
