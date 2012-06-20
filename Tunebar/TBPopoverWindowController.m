#import "TBPopoverWindowController.h"
#import "TBArtworkImageView.h"
#import "TBPreferencesWindowController.h"
#import "TBProgressBarView.h"
#import "TBScrollTextView.h"

@implementation TBPopoverWindowController
@synthesize artworkView = _artworkView,
            artistTextField = _artistTextField,
            trackTextField = _trackTextField,
            albumTextField = _albumTextField,
            progressBarView = _progressBarView,
            playButton = _playButton,
            playerDelegate = _playerDelegate,
            controlOverlay = _controlOverlay;

#pragma mark Initializers

- (id)initWithStatusItem:(NSStatusItem *)statusItem playerDelegate:(id)delegate {
    self = [super initWithWindowNibName:@"PopoverWindow"];
    if (self) {
        _statusItem = statusItem;
        _isVisible = NO;
        self.playerDelegate = delegate;
    }
    
    return self;
}

- (void)awakeFromNib {
    [self.window setLevel:NSPopUpMenuWindowLevel + 1];
    [self.window setOpaque:NO];
    [self.window setBackgroundColor:[NSColor clearColor]];
    self.progressBarView = [[TBProgressBarView alloc] initWithFrame:NSMakeRect(PROGRESS_BAR_X, PROGRESS_BAR_Y, PROGRESS_BAR_WIDTH, PROGRESS_BAR_HEIGHT)];
    [self.window.contentView addSubview:self.progressBarView];
    
    [self.controlOverlay setAlphaValue:0.0];
    
    // set the shadow
    NSShadow *textShadow = [[NSShadow alloc] init];
    NSSize shadowSize = NSMakeSize(1, -1);
    [textShadow setShadowColor:[NSColor blackColor]];
    [textShadow setShadowOffset:shadowSize];
    [textShadow setShadowBlurRadius:1.0];
    
    // the text's attributes
    NSDictionary *backgroundTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          [NSColor grayColor], NSForegroundColorAttributeName,
                                          textShadow, NSShadowAttributeName,
                                          [NSFont fontWithName:@"Lucida Grande" size:12], NSFontAttributeName,
                                          nil];
    NSDictionary *foregroundTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [NSColor whiteColor], NSForegroundColorAttributeName,
                                         textShadow, NSShadowAttributeName,
                                         [NSFont fontWithName:@"Lucida Grande" size:13], NSFontAttributeName,
                                         nil];
    
    self.artistTextField.textAttributes = backgroundTextAttributes;
    self.trackTextField.textAttributes = foregroundTextAttributes;
    self.albumTextField.textAttributes = backgroundTextAttributes;
    
    self.artistTextField.speed = SCROLL_SPEED;
    self.trackTextField.speed = SCROLL_SPEED;
    self.albumTextField.speed = SCROLL_SPEED;
}

- (void)windowDidLoad {
    [self updateTrackInfo];
    [self updatePlayButtonState];
    
    // initially set the current progress and then watch it
    [self updateProgressBarWidth];
    [self watchProgress];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)playButtonPressed:(NSButton *)sender {
    [self.playerDelegate playButtonPressed];
}

- (IBAction)nextButtonPressed:(NSButton *)sender {
    [self.playerDelegate nextButtonPressed];
}

- (IBAction)previousButtonPressed:(NSButton *)sender {
    [self.playerDelegate previousButtonPressed];
}


#pragma mark -
#pragma mark Notifications

- (void)windowDidResignKey:(NSNotification *)notification {
    self.isVisible = NO;
}

- (void)playerStateChanged:(NSNotification *)notification {
    [self updatePlayButtonState];
    [self updateTrackInfo];
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isVisible {
    return _isVisible;
}

- (void)setIsVisible:(BOOL)flag {
    if (_isVisible != flag) {
        if (_isVisible) {
            [self closePopover];
        } else {
            [self openPopover];
        }
    }
    
    _isVisible = flag;
}

- (TBPreferencesWindowController *)prefWindowController {
    if (_prefWindowController == nil) {
        _prefWindowController = [[TBPreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindow"];
    }
    
    return _prefWindowController;
}

#pragma mark -
#pragma mark Popover control

- (void)openPopover {
    NSRect statusItemRect = _statusItem.view.window.frame;
    NSRect panelRect = self.window.frame;
    panelRect.origin.x = roundf(NSMidX(statusItemRect) - NSWidth(panelRect) / 2) + ARROW_POSITION;
    panelRect.origin.y = NSMaxY(statusItemRect) - NSHeight(panelRect) - statusItemRect.size.height + 6;
    
    NSRect animationOriginRect = panelRect;
    animationOriginRect.origin.y = NSMaxY(statusItemRect) - NSHeight(panelRect) - (statusItemRect.size.height * 2);
                                             
    [NSApp activateIgnoringOtherApps:NO];
    [self.window setAlphaValue:0];
    [self.window setFrame:animationOriginRect display:YES];
    [self.window makeKeyAndOrderFront:nil];
    
    NSTimeInterval animationDuration = ANIMATION_DURATION;
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:animationDuration];
    [[self.window animator] setFrame:panelRect display:YES];
    [[self.window animator] setAlphaValue:1];
    [NSAnimationContext endGrouping];
}

- (void)closePopover {
    NSTimeInterval animationDuration = ANIMATION_DURATION;
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:animationDuration];
    [[[self window] animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    
    dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * ANIMATION_DURATION * 2), dispatch_get_main_queue(), ^{
        if (!_isVisible) {
            [self.window orderOut:nil];
        }
    });
}

#pragma mark -
#pragma mark Updating the player

- (void)updatePlayButtonState {
    NSImage *playButtonImage = [NSImage imageNamed:@"play_button.png"];
    NSImage *playButtonAltImage = [NSImage imageNamed:@"play_button_active.png"];
    
    if ([self.playerDelegate isPlaying]) {
        playButtonImage = [NSImage imageNamed:@"pause_button.png"];
        playButtonAltImage = [NSImage imageNamed:@"pause_button_active.png"];
    }
    
    [self.playButton setImage:playButtonImage];
    [self.playButton setAlternateImage:playButtonAltImage];
}

- (void)updateTrackInfo {
    NSString *trackName = [self.playerDelegate getTrackName];
    NSString *artist = [self.playerDelegate getArtist];
    NSString *album = [self.playerDelegate getAlbum];
    NSImage *artwork = [self.playerDelegate getArtwork];
    
    [artwork setSize:self.artworkView.frame.size];
    self.artworkView.image = artwork;
    
    if (trackName.length == 0) {
        trackName = @"";
    }
    
    if (artist.length == 0) {
        artist = @"";
    }
    
    self.albumTextField.text = album;
    self.trackTextField.text = trackName;
    self.artistTextField.text = artist;
}

- (void)watchProgress {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [self updateProgressBarWidth];
        [self watchProgress];
    });
}

- (void)updateProgressBarWidth {
    double progress = [self.playerDelegate progress];
    NSRect progressFrame = self.progressBarView.frame;
    progressFrame.size.width = round(progress * PROGRESS_BAR_WIDTH);
    [self.progressBarView setFrame:progressFrame];
    [self.progressBarView setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark Preferences menu

- (IBAction)openPreferences:(NSMenuItem *)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [self.prefWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)quitApplication:(NSMenuItem *)sender {
    [NSApp terminate:nil];
}

@end
