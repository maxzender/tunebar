#import "TBStatusItemView.h"

@implementation TBStatusItemView
@synthesize delegate = _delegate;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isHighlighted = NO;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // remove old imageview from superview
    [_statusIconView removeFromSuperview];
    
    [self.delegate.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.isHighlighted];
    
    NSImage *statusIcon = self.isHighlighted ? [NSImage imageNamed:@"statusicon_highlight"] : [NSImage imageNamed:@"statusicon_default"];
    
    _statusIconView = [[NSImageView alloc] initWithFrame:
                                   NSMakeRect(0, 0, statusIcon.size.width,
                                              statusIcon.size.height)];    
    [_statusIconView setImage:statusIcon];
    [self addSubview:_statusIconView];

}

- (void)mouseDown:(NSEvent *)event {
    [self.delegate statusItemClicked:self];
}

- (BOOL)isHighlighted {
    return _isHighlighted;
}

- (void)setIsHighlighted:(BOOL)flag {
    if (_isHighlighted != flag) {
        _isHighlighted = flag;
        [self setNeedsDisplay:YES];
    }
}

@end
