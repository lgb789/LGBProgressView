//
//  LGBIndicatorContentView.m
//  LGBProgress
//
//  Created by lgb789 on 16/6/7.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBIndicatorContentView.h"

@interface LGBIndicatorContentView ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation LGBIndicatorContentView

#pragma mark - 公有方法

-(instancetype)initWithContentView:(UIView *)contentView
{
    self = [super init];
    if (self) {
        self.contentView = contentView;

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    
}

#pragma mark - 重写父类方法

#pragma mark - 代理

#pragma mark - 事件处理 

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置

-(void)setContentView:(UIView *)contentView
{
    if (_contentView == contentView) {
        return;
    }
    
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    
    [self addSubview:_contentView];
    
}

@end
