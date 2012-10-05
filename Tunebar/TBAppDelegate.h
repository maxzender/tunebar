#import <Cocoa/Cocoa.h>
#import "TBStatusItemViewDelegate.h"
@class TBPopoverWindowController, TBStatusItemView, TBPlayerController;

@interface TBAppDelegate : NSObject <NSApplicationDelegate, TBStatusItemViewDelegate> {
    TBPopoverWindowController *_popoverController;
    TBPlayerController *_playerController;
}

@property (nonatomic, strong, readonly) TBPopoverWindowController *popoverController;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;

@end
