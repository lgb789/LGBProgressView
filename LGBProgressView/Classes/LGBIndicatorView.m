//
//  LGBIndicatorView.m
//  LGBProgress
//
//  Created by lgb789 on 16/6/1.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBIndicatorView.h"

@interface LGBIndicatorView ()
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation LGBIndicatorView

#pragma mark - 公有方法 

#pragma mark - 重写父类方法

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.indicatorView];
        [self.indicatorView startAnimating];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.indicatorView.frame = self.bounds;
}

#pragma mark - 代理

-(void)setStyle:(LGBProgressViewStyle)style
{
    switch (style) {
        case LGBProgressViewStyleLight:
            [self.indicatorView setColor:[UIColor grayColor]];
            break;
        case LGBProgressViewStyleDark:
            [self.indicatorView setColor:[UIColor whiteColor]];
            break;
        default:
            break;
    }
}

#pragma mark - 事件处理 

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置

-(UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _indicatorView;
}

@end
