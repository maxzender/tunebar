#import <Foundation/Foundation.h>

@protocol TBPlayerDelegate <NSObject>

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
