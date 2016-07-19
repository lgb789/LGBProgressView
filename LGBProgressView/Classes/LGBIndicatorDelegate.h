//
//  LGBIndicatorDelegate.h
//  LGBProgress
//
//  Created by lgb789 on 16/6/7.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBProgressTypeDef.h"


#define kIndicatorDarColor [UIColor colorWithRed:59 / 255.0 green:59 / 255.0 blue:59 / 255.0 alpha:1]

@protocol LGBIndicatorDelegate <NSObject>

@optional
- (void)setStyle:(LGBProgressViewStyle)style;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
