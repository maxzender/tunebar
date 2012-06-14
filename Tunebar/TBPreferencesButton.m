#import "TBPreferencesButton.h"

@implementation TBPreferencesButton

- (void)mouseDown:(NSEvent *)theEvent
{
    // display menu at custom location
    NSPoint menuPosition = NSMakePoint(self.frame.origin.x, self.frame.origin.y - self.frame.size.height / 2);
    NSEvent *event = [NSEvent mouseEventWithType:NSLeftMouseDown
                                        location:menuPosition
                                   modifierFlags:NSLeftMouseDownMask
                                       timestamp:0
                                    windowNumber:self.window.windowNumber
                                         context:self.window.graphicsContext
                                     eventNumber:0
                                      clickCount:1
                                        pressure:1];
    [self setState:NSOnState];
    [self highlight:YES];
    
    if ([self menu])
    {
        [NSMenu popUpContextMenu:[self menu] withEvent:event forView:self];
    }
    
    [self setState:NSOffState];
    [self highlight:NO];
    
}

@end
