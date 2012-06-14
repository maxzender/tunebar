#import <Cocoa/Cocoa.h>

@interface TBScrollTextView : NSView {
    NSTimer *_scroller;
    NSPoint _point;
    CGFloat _stringWidth;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSDictionary *textAttributes;
@property (nonatomic) NSTimeInterval speed;

@end