//
//  TBControlOverlayView.m
//  Tunebar
//
//  Created by Max Zender on 14.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBControlOverlayView.h"

@implementation TBControlOverlayView

- (void)awakeFromNib {
    [self addTrackingRect:self.bounds owner:self userData:nil assumeInside:NO];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    // fade-in
    NSTimeInterval animationDuration = ANIMATION_DURATION;
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:animationDuration];
    [self.animator setAlphaValue:1];
    [NSAnimationContext endGrouping];
}

- (void)mouseExited:(NSEvent *)theEvent {
    // fade-out
    NSTimeInterval animationDuration = ANIMATION_DURATION;
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:animationDuration];
    [self.animator setAlphaValue:0];
    [NSAnimationContext endGrouping];
}

@end
