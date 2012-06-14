#import "TBArtworkImageView.h"

@implementation TBArtworkImageView

- (void)drawRect:(NSRect)dirtyRect
{
    // draw rounded corners
    [NSGraphicsContext saveGraphicsState];
    
    int radius = 5;
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    NSPoint bottomLeftArcStart = NSMakePoint(0, radius);
    NSPoint bottomLeft = NSMakePoint(0, 0);
    NSPoint bottomLeftArcEnd = NSMakePoint(radius, 0);
    
    NSPoint bottomRightArcStart = NSMakePoint(self.bounds.size.width - radius, 0);
    NSPoint bottomRight = NSMakePoint(self.bounds.size.width, 0);
    NSPoint bottomRightArcEnd = NSMakePoint(self.bounds.size.width, radius);
    
    NSPoint topRightArcStart = NSMakePoint(self.bounds.size.width,
                                           self.bounds.size.height - radius);
    NSPoint topRight = NSMakePoint(self.bounds.size.width, self.bounds.size.height);
    NSPoint topRightArcEnd = NSMakePoint(self.bounds.size.width - radius,
                                         self.bounds.size.height);
    
    NSPoint topLeftArcStart = NSMakePoint(radius, self.bounds.size.height);
    NSPoint topLeft = NSMakePoint(0, self.bounds.size.height);
    NSPoint topLeftArcEnd = NSMakePoint(0, self.bounds.size.height - radius);
    
    // bottom left
    [path moveToPoint:bottomLeftArcStart];
    [path appendBezierPathWithArcFromPoint:bottomLeft toPoint:bottomLeftArcEnd radius:radius];
    [path lineToPoint:bottomRightArcStart];
    
    // bottom right
    [path appendBezierPathWithArcFromPoint:bottomRight toPoint:bottomRightArcEnd radius:radius];
    [path lineToPoint:topRightArcStart];
    
    // top right
    [path appendBezierPathWithArcFromPoint:topRight toPoint:topRightArcEnd radius:radius];
    [path lineToPoint:topLeftArcStart];
    
    // top left
    [path appendBezierPathWithArcFromPoint:topLeft toPoint:topLeftArcEnd radius:radius];
    [path lineToPoint:bottomLeft];

    [path addClip];

    [super drawRect:dirtyRect];
    [NSGraphicsContext restoreGraphicsState];
}

@end
