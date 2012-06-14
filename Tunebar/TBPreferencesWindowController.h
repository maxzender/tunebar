#import <Cocoa/Cocoa.h>

@interface TBPreferencesWindowController : NSWindowController

@property (nonatomic, unsafe_unretained) IBOutlet NSButton *displaySongCheckbox;
@property (nonatomic, unsafe_unretained) IBOutlet NSButton *displayArtistCheckbox;

@end
