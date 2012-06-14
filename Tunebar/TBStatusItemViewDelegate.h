//
//  TBPlayerDelegate.h
//  Tunebar
//
//  Created by Max Zender on 05.06.12.
//  Copyright (c) 2012 Max Zender. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TBStatusItemViewDelegate <NSObject>

- (NSStatusItem *)statusItem;
- (void)statusItemClicked:(id)sender;

@end
