#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"
@class iTunesApplication;

@interface TBiTunesPlayer : NSObject <TBPlayerDelegate> {
    iTunesApplication *_iTunes;
}

@end
