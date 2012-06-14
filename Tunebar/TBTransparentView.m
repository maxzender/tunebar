#import "TBTransparentView.h"

@implementation TBTransparentView

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor clearColor] set];
    NSRectFill([self frame]);
}

@end
