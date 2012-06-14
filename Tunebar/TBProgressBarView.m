#import "TBProgressBarView.h"
#import "TBProgressBarImageView.h"

@implementation TBProgressBarView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSImage *progressBarImage = [NSImage imageNamed:@"progress_bar"];
        TBProgressBarImageView *progressBar = [[TBProgressBarImageView alloc] initWithFrame:NSMakeRect(0, 0, progressBarImage.size.width, progressBarImage.size.height)];
        progressBar.image = progressBarImage;
        
        [self addSubview:progressBar];
    }
    
    return self;
}

@end
