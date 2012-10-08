#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"
@class RdioApplication;

@interface TBRdioPlayer : NSObject <TBPlayerDelegate> {
    RdioApplication *_rdio;
}

@end
