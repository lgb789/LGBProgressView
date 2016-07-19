//
//  LGBProgressView.h
//  LGBProgress
//
//  Created by lgb789 on 16/6/1.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBIndicatorDelegate.h"
#import "LGBProgressTypeDef.h"
#import "LGBIndicatorContentView.h"
#import "LGBIndicatorView.h"
#import "LGBPieIndicatorView.h"
#import "LGBRingIndicatorView.h"
#import <UIKit/UIKit.h>

typedef void (^HudTapAction) (void);

@interface LGBProgressView : UIView

@property (nonatomic, strong) UIView*                       hud;
@property (nonatomic, strong) UILabel*                      text;
@property (nonatomic, strong) UIView<LGBIndicatorDelegate>* indicatorView;
@property (nonatomic, strong) UILabel*                      detailText;
@property (nonatomic, assign) CGFloat                       animationDuration;
@property (nonatomic, assign) LGBProgressViewStyle          style;
@property (nonatomic, copy) HudTapAction                    hudTap;
@property (nonatomic, assign) LGBProgressViewPosition       position;

- (void)showInView:(UIView*)view;

- (void)dismiss;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

-(void)reload:(BOOL)animated;

@end
