#import "TBScrollTextView.h"

@implementation TBScrollTextView
@synthesize text = _text,
            speed = _speed,
            textAttributes = _textAttributes;

-(void) setText:(NSString *)newText {
    _text = newText;
    _stringWidth = [newText sizeWithAttributes:_textAttributes].width;
    _point = NSZeroPoint;
    //_point = NSMakePoint((self.frame.size.width / 2) - (_stringWidth / 2), 0);

    if (_scroller == nil && _speed > 0 && _text != nil && _stringWidth > self.frame.size.width) {
        _scroller = [NSTimer scheduledTimerWithTimeInterval:_speed target:self selector:@selector(moveText:) userInfo:nil repeats:YES];
    } else if (_scroller != nil && _stringWidth <= self.frame.size.width) {
        [_scroller invalidate];
        _scroller = nil;
    }
    
    [self setNeedsDisplay:YES];
}

-(void) moveText:(NSTimer *)timer {
    _point.x = _point.x - 1.0f;
    [self setNeedsDisplay:YES];
}

-(void) drawRect:(NSRect)dirtyRect {
    if (_point.x + _stringWidth < 0) {
        _point.x += _stringWidth + 20;
    }
    
    [_text drawAtPoint:_point withAttributes:_textAttributes];
    
    if (_point.x < 0) {
        NSPoint otherPoint = _point;
        otherPoint.x += _stringWidth + 20;
        [_text drawAtPoint:otherPoint withAttributes:_textAttributes];
    }
}

@end
