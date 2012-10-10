#import <Foundation/Foundation.h>

@protocol TBStatusItemViewDelegate <NSObject>

- (NSStatusItem *)statusItem;
- (void)statusItemClicked:(id)sender;

@end
