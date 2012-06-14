#import "TBProgressBarImageView.h"

@implementation TBProgressBarImageView

- (void)drawRect:(NSRect)dirtyRect
{
    // draw rounded corners
    [NSGraphicsContext saveGraphicsState];
    float radius = dirtyRect.size.height / 2;
    
    if (dirtyRect.size.width < radius) {
        dirtyRect.size.width = radius;
    }
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    NSPoint topLeftArcStart = NSMakePoint(radius, dirtyRect.size.height);
    NSPoint topLeftCorner = NSMakePoint(0, dirtyRect.size.height);
    NSPoint topLeftArcEnd = NSMakePoint(0, radius);
    
    NSPoint bottomLeftCorner = NSZeroPoint;
    NSPoint bottomLeftArcEnd = NSMakePoint(radius, 0);
    
    NSPoint bottomRightArcStart = NSMakePoint(dirtyRect.size.width - radius, 0);
    NSPoint bottomRightCorner = NSMakePoint(dirtyRect.size.width, 0);
    NSPoint bottomRightArcEnd = NSMakePoint(dirtyRect.size.width, radius);
    
    NSPoint topRightCorner = NSMakePoint(dirtyRect.size.width, dirtyRect.size.height);
    NSPoint topRightArcEnd = NSMakePoint(dirtyRect.size.width - radius, dirtyRect.size.height);
    
    // top left arc
    [path moveToPoint:topLeftArcStart];
    [path appendBezierPathWithArcFromPoint:topLeftCorner toPoint:topLeftArcEnd radius:radius];
    
    // bottom left arc
    [path appendBezierPathWithArcFromPoint:bottomLeftCorner toPoint:bottomLeftArcEnd radius:radius];
    
    // bottom right arc
    [path lineToPoint:bottomRightArcStart];
    [path appendBezierPathWithArcFromPoint:bottomRightCorner toPoint:bottomRightArcEnd radius:radius];
    
    // top right arc
    [path appendBezierPathWithArcFromPoint:topRightCorner toPoint:topRightArcEnd radius:radius];
    [path lineToPoint:topLeftArcStart];
    
    [path addClip];
    
    [super drawRect:dirtyRect];
    [NSGraphicsContext restoreGraphicsState];
}

@end
