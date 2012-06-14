#import "TBPreferencesWindowController.h"

@implementation TBPreferencesWindowController
@synthesize displaySongCheckbox = _displaySongCheckbox,
            displayArtistCheckbox = _displayArtistCheckbox;

- (void)windowDidBecomeKey:(NSNotification *)notification {
    // set checkbox states
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TBDisplayArtistInMenubar"]) {
        [self.displayArtistCheckbox setState:NSOnState];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"TBDisplaySongNameInMenubar"]) {
        [self.displaySongCheckbox setState:NSOnState];
    }
}

- (IBAction)displaySong:(NSButton *)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (sender.state == NSOnState) {
        [defaults setBool:YES forKey:@"TBDisplaySongNameInMenubar"];
    } else {
        [defaults setBool:NO forKey:@"TBDisplaySongNameInMenubar"];
    }
}

- (IBAction)displayArtist:(NSButton *)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (sender.state == NSOnState) {
        [defaults setBool:YES forKey:@"TBDisplayArtistInMenubar"];
    } else {
        [defaults setBool:NO forKey:@"TBDisplayArtistInMenubar"];
    }
}

@end
