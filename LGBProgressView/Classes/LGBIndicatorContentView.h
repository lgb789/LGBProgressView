//
//  LGBIndicatorContentView.h
//  LGBProgress
//
//  Created by lgb789 on 16/6/7.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBIndicatorDelegate.h"

@interface LGBIndicatorContentView : UIView <LGBIndicatorDelegate>

-(instancetype)initWithContentView:(UIView *)contentView;

@end
