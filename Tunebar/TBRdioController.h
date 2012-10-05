#import <Foundation/Foundation.h>
#import "TBPlayerDelegate.h"
@class RdioApplication;

@interface TBRdioController : NSObject <TBPlayerDelegate> {
    RdioApplication *_rdio;
}

@end
