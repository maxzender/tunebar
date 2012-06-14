#import <Cocoa/Cocoa.h>
#import "TBStatusItemViewDelegate.h"

@interface TBStatusItemView : NSView {
    BOOL _isHighlighted;
    NSImageView *_statusIconView;
}

@property (nonatomic, strong) id <TBStatusItemViewDelegate> delegate;
@property (nonatomic) BOOL isHighlighted;

@end
