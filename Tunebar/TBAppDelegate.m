#import "TBAppDelegate.h"
#import "TBStatusItemView.h"
#import "TBPopoverWindowController.h"
#import "TBiTunesController.h"

@implementation TBAppDelegate
@synthesize statusItem = _statusItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self setDefaultPreferences];
    [self setupStatusItem];
}

- (void)setDefaultPreferences {
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:NO], @"TBDisplaySongNameInMenubar",
                                 [NSNumber numberWithBool:NO], @"TBDisplayArtistInMenubar",
                                 nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
}

- (void)setupStatusItem {
    CGFloat thickness = [[NSStatusBar systemStatusBar] thickness];
    
    TBStatusItemView *statusItemView = [[TBStatusItemView alloc] initWithFrame:
                                        (NSRect){.size={thickness,thickness}}];
    statusItemView.delegate = self;
    
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    _statusItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    
    [_statusItem setEnabled:YES];
    [_statusItem setView:statusItemView];

}

- (void)statusItemClicked:(TBStatusItemView *)sender {
    self.popoverController.isVisible = !self.popoverController.isVisible;
    sender.isHighlighted = !sender.isHighlighted;
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(popoverDidResignKey:)
                                                 name:NSWindowDidResignKeyNotification
                                               object:nil];
    [_iTunesController registerNotificationsWithObserver:_popoverController
                                                selector:@selector(playerStateChanged:)];
}

- (void)popoverDidResignKey:(NSNotification *)notification {
    TBStatusItemView *statusItemView = (id)_statusItem.view;
    statusItemView.isHighlighted = NO;
}

- (TBPopoverWindowController *)popoverController {
    if (_popoverController == nil) {
        _iTunesController = [[TBiTunesController alloc] init];
        _popoverController = [[TBPopoverWindowController alloc] initWithStatusItem:_statusItem
                                                                    playerDelegate:_iTunesController];
        [self registerNotifications];
    }
    
    return _popoverController;
}

@end
