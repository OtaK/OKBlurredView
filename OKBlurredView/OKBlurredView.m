//
//  OKBlurredView.m
//  OKBlurredView
//
//  Created by Mathieu Amiot on 18/02/2014.
//  Copyright (c) 2014 Mathieu Amiot. All rights reserved.
//

#import "OKBlurredView.h"
#import "GPUImageiOSBlurFilter.h"

@implementation OKBlurredView
{
    NSTimer *_fps;
    UIView *_blurView;
    GPUImageiOSBlurFilter *_blurFilter;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _blurFilter = [GPUImageiOSBlurFilter new];

        _blurView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_blurView];

        self.refreshRate = 30.0f;
    }
    return self;
}

- (void)setRefreshRate:(float)refreshRate {
    _refreshRate = refreshRate;

    [self _updateTimer];
}

- (void)_updateTimer
{
    [_fps invalidate];
    _fps = nil;
    _fps = [NSTimer timerWithTimeInterval:(1.0f / _refreshRate)
                                   target:self
                                 selector:@selector(_updateBackgroundBlur)
                                 userInfo:nil
                                  repeats:YES];
}

- (void)_updateBackgroundBlur
{
    if (!self.superview)
        return;

    CGRect snapBounds = self.bounds;
    UIGraphicsBeginImageContext(snapBounds.size);
    [self.superview drawViewHierarchyInRect:snapBounds afterScreenUpdates:YES];
    UIImage *bg = [_blurFilter imageByFilteringImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _blurView.backgroundColor = [UIColor colorWithPatternImage:bg];
    [_blurView setNeedsDisplay];
}

@end
