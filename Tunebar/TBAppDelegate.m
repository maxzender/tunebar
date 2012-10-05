#import "TBAppDelegate.h"
#import "TBStatusItemView.h"
#import "TBPopoverWindowController.h"
#import "TBPlayerController.h"

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
    [_playerController registerForNotificationWithObserver:_popoverController
                                                selector:@selector(playerStateChanged:)];
}

- (void)popoverDidResignKey:(NSNotification *)notification {
    TBStatusItemView *statusItemView = (id)_statusItem.view;
    statusItemView.isHighlighted = NO;
}

- (TBPopoverWindowController *)popoverController {
    if (_popoverController == nil) {
        _playerController = [[TBPlayerController alloc] init];
        _popoverController = [[TBPopoverWindowController alloc] initWithStatusItem:_statusItem
                                                                    playerDelegate:_playerController];
        [self registerNotifications];
    }
    
    return _popoverController;
}

@end
