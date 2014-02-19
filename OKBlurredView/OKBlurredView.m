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
    UIImageView *_blurView;
    GPUImageiOSBlurFilter *_blurFilter;
}

- (id)init
{
    self = [super init];
    if (self)
        [self _internalInit];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        [self _internalInit];

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        [self _internalInit];
    
    return self;
}

- (void)_internalInit
{
    _blurFilter = [GPUImageiOSBlurFilter new];
    _blurView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_blurView];
    _refreshRate = 10.0f;
    [self _updateTimer];
}

- (void)setRefreshRate:(float)refreshRate
{
    _refreshRate = refreshRate;

    [self _updateTimer];
}

- (void)_updateTimer
{
    [_fps invalidate];
    _fps = nil;
    NSTimeInterval delta = (1.0f / _refreshRate);
    _fps = [NSTimer scheduledTimerWithTimeInterval:delta
                                            target:self
                                          selector:@selector(_updateBackgroundBlur)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)_updateBackgroundBlur
{
    if (!_targetView)
        return;
    
    CGRect snapFrame = self.bounds;
    NSLog(@"x=%f, y=%f, w=%f, h=%f", snapFrame.origin.x, snapFrame.origin.y, snapFrame.size.width, snapFrame.size.height);
    UIGraphicsBeginImageContext(snapFrame.size);
    [_targetView drawViewHierarchyInRect:snapFrame afterScreenUpdates:YES];
    UIImage *bg = [_blurFilter imageByFilteringImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _blurView.image = bg;
}

@end
