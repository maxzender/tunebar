#import <Cocoa/Cocoa.h>
#import "TBStatusItemViewDelegate.h"
@class TBPopoverWindowController, TBStatusItemView, TBiTunesController;

@interface TBAppDelegate : NSObject <NSApplicationDelegate, TBStatusItemViewDelegate> {
    TBPopoverWindowController *_popoverController;
    TBiTunesController *_iTunesController;
}

@property (nonatomic, strong, readonly) TBPopoverWindowController *popoverController;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;

@end
