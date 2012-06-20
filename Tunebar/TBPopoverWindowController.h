#import <Cocoa/Cocoa.h>
#import "TBPlayerDelegate.h"

#define ANIMATION_DURATION .2
#define POPOVER_WIDTH 154.0
#define PROGRESS_BAR_X 112
#define PROGRESS_BAR_Y 14
#define PROGRESS_BAR_HEIGHT 8.0
#define SCROLL_SPEED 0.09
#define ARROW_POSITION -102.0

@class TBArtworkImageView, TBPreferencesWindowController, TBProgressBarView, TBScrollTextView;

@interface TBPopoverWindowController : NSWindowController <NSWindowDelegate> {
    BOOL _isVisible;
    NSStatusItem *_statusItem;
    TBPreferencesWindowController *_prefWindowController;
}

@property (nonatomic) BOOL isVisible;
@property (nonatomic, strong) id <TBPlayerDelegate> playerDelegate;
@property (nonatomic, strong, readonly) TBPreferencesWindowController *prefWindowController;

@property (nonatomic, unsafe_unretained) IBOutlet NSButton *playButton;
@property (nonatomic, unsafe_unretained) IBOutlet TBArtworkImageView *artworkView;
@property (nonatomic, unsafe_unretained) IBOutlet TBScrollTextView *artistTextField;
@property (nonatomic, unsafe_unretained) IBOutlet TBScrollTextView *trackTextField;
@property (nonatomic, unsafe_unretained) IBOutlet TBScrollTextView *albumTextField;
@property (nonatomic, strong) TBProgressBarView *progressBarView;
@property (nonatomic, unsafe_unretained) IBOutlet NSView *controlOverlay;

- (id)initWithStatusItem:(NSStatusItem *)statusItem playerDelegate:(id)delegate;

@end
