#import <Cocoa/Cocoa.h>
#import "TBStatusItemViewDelegate.h"
@class TBPopoverWindowController, TBStatusItemView, TBPlayerDispatcher;

@interface TBAppDelegate : NSObject <NSApplicationDelegate, TBStatusItemViewDelegate> {
    TBPopoverWindowController *_popoverController;
    TBPlayerDispatcher *_playerDispatcher;
}

@property (nonatomic, strong, readonly) TBPopoverWindowController *popoverController;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;

@end
