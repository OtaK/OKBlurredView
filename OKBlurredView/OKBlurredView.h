//
//  OKBlurredView.h
//  OKBlurredView
//
//  Created by Mathieu Amiot on 18/02/2014.
//  Copyright (c) 2014 Mathieu Amiot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OKBlurredView : UIView

@property (nonatomic, setter=setRefreshRate:) float refreshRate;
@property (nonatomic) IBOutlet UIView *targetView;

@end
