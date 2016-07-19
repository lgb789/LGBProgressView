//
//  LGBProgressView.m
//  LGBProgress
//
//  Created by lgb789 on 16/6/1.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBProgressView.h"

#define kIndicatorMinSize    40.0f

NS_INLINE CGRect CGRect_Integral(CGRect rect) {
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    return (CGRect){{((CGFloat)floor(rect.origin.x*scale))/scale, ((CGFloat)floor(rect.origin.y*scale))/scale}, {((CGFloat)ceil(rect.size.width*scale))/scale, ((CGFloat)ceil(rect.size.height*scale))/scale}};
}

@interface LGBProgressView ()

@end

@implementation LGBProgressView

#pragma mark - 公有方法

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    [self updateSubviewsLayout];
    [self showAnimated:YES];
}

-(void)dismiss
{
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)setProgress:(CGFloat)progress
          animated:(BOOL)animated
{
    if ([self.indicatorView respondsToSelector:@selector(setProgress:animated:)]) {
        [self.indicatorView setProgress:progress animated:animated];
    }
}

-(void)reload
{
    [self updateSubviewsLayout];
}

#pragma mark - 重写父类方法

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.style = LGBProgressViewStyleDark;
        
        self.animationDuration = 0.4;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

-(void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    if (_detailText) {
//        [_detailText removeObserver:self forKeyPath:@"text"];
//    }
//    if (_text) {
//        [_text removeObserver:self forKeyPath:@"text"];
//    }
}

#pragma mark - 代理

#pragma mark - 事件处理 

-(void)tapHud:(UITapGestureRecognizer *)recognizer
{
    if (self.hudTap) {
        self.hudTap();
    }
}

-(void)orientationDidChange:(NSNotification *)notification
{
    [self updateSubviewsLayout];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if (object == _text || object == _detailText) {
////        [self updateSubviewsLayoutAnimated:NO];
//    }
//}

#pragma mark - 私有方法

-(void)updateSubviewsLayout
{
    CGFloat margin = 20;
    
    CGRect frame = self.superview.bounds;
    
    self.frame = frame;
    
    CGRect indicatorFrame = CGRectZero;
    CGRect textFrame = CGRectZero;
    CGRect detailTextFrame = CGRectZero;
    CGSize maxSize = CGSizeMake(CGRectGetWidth(frame) - margin * 2, CGRectGetHeight(frame) - margin * 2);
    
    if (_indicatorView) {
        if (CGRectIsEmpty(_indicatorView.bounds)) {
            indicatorFrame = CGRectMake(0, margin, kIndicatorMinSize, kIndicatorMinSize);
        }else{
            indicatorFrame = CGRectMake(0, margin, _indicatorView.bounds.size.width, _indicatorView.bounds.size.height);
            
        }
    }
    
    if (_text && _text.text) {
        CGSize size = [self.text sizeThatFits:maxSize];
        CGFloat textY = CGRectIsEmpty(indicatorFrame) ? margin : CGRectGetMaxY(indicatorFrame) + 10;
        textFrame = CGRectMake(0, textY, size.width, size.height);
    }
    
    if (_detailText && _detailText.text) {
        CGSize size = [self.detailText sizeThatFits:maxSize];
        CGFloat detailY = margin;
        if (!CGRectIsEmpty(textFrame)) {
            detailY = CGRectGetMaxY(textFrame) + 10;
        }else if (!CGRectIsEmpty(indicatorFrame)){
            detailY = CGRectGetMaxY(indicatorFrame) + 10;
        }
        detailTextFrame = CGRectMake(0, detailY, size.width, size.height);
    }
    
    CGFloat hudWidth = MAX(CGRectGetMaxX(detailTextFrame), (MAX(CGRectGetMaxX(indicatorFrame), CGRectGetMaxX(textFrame)))) + margin * 2;
    CGFloat hudHeight = MAX(CGRectGetMaxY(detailTextFrame), (MAX(CGRectGetMaxY(indicatorFrame), CGRectGetMaxY(textFrame)))) + margin;
    
    hudWidth = MAX(hudWidth, hudHeight);
    hudWidth = MIN(hudWidth, CGRectGetWidth(frame) - margin * 2);
    
    switch (self.style) {
        case LGBProgressViewStyleLight:
            self.hud.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
            if (_text) {
                _text.textColor = kIndicatorDarColor;
            }
            if (_detailText) {
                _detailText.textColor = kIndicatorDarColor;
            }
            break;
        case LGBProgressViewStyleDark:
            self.hud.backgroundColor = kIndicatorDarColor;
            if (_text) {
                _text.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
            }
            if (_detailText) {
                _detailText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
            }
            break;
        default:
            break;
    }
    
    CGRect hudFrame = self.hud.frame;
    
    switch (self.position) {
        case LGBProgressViewPositionCenter:
            hudFrame = CGRectMake(CGRectGetWidth(frame) / 2 - hudWidth / 2, CGRectGetHeight(frame) / 2 - hudHeight / 2, hudWidth, hudHeight);
            
            
            break;
        case LGBProgressViewPositionBottomCenter:
            hudFrame = CGRectMake(CGRectGetWidth(frame) / 2 - hudWidth / 2, CGRectGetHeight(frame) - hudHeight - margin, hudWidth, hudHeight);
            break;
        default:
            break;
    }
    
    
    
    
    if (!CGRectIsEmpty(indicatorFrame)) {
        indicatorFrame = CGRectMake(CGRectGetWidth(hudFrame) / 2 - CGRectGetWidth(indicatorFrame) / 2, CGRectGetMinY(indicatorFrame), CGRectGetWidth(indicatorFrame), CGRectGetHeight(indicatorFrame));
    }
    
    if (!CGRectIsEmpty(textFrame)) {
        textFrame = CGRectMake(margin, CGRectGetMinY(textFrame), CGRectGetWidth(hudFrame) - margin * 2, CGRectGetHeight(textFrame));
    }
    
    if (!CGRectIsEmpty(detailTextFrame)) {
        detailTextFrame = CGRectMake(margin, CGRectGetMinY(detailTextFrame), CGRectGetWidth(hudFrame) - margin * 2, CGRectGetHeight(detailTextFrame));
    }
    
    self.hud.frame = CGRect_Integral(hudFrame);
    
    _indicatorView.frame = CGRect_Integral(indicatorFrame);
    
    _text.frame = CGRect_Integral(textFrame);
    
    _detailText.frame = CGRect_Integral(detailTextFrame);
    
}

-(void)showAnimated:(BOOL)animated
{
    if (animated) {
        self.alpha = 0;
//        self.hud.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];

    }
}


#pragma mark - 成员变量初始化与设置

-(UIView *)hud
{
    if (_hud == nil) {
        _hud = [UIView new];
        _hud.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _hud.layer.cornerRadius = 8.0f;
        [self addSubview:_hud];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHud:)];
        _hud.userInteractionEnabled = YES;
        [_hud addGestureRecognizer:tap];
    }
    return _hud;
}

-(UILabel *)text
{
    if (_text == nil) {
        _text = [UILabel new];
        _text.backgroundColor = [UIColor clearColor];
        _text.numberOfLines = 0;
        _text.textAlignment = NSTextAlignmentCenter;
        _text.font = [UIFont boldSystemFontOfSize:16.0];
        [self.hud addSubview:_text];
        
//        [_text addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _text;
}

-(UILabel *)detailText
{
    if (_detailText == nil) {
        _detailText = [UILabel new];
        _detailText.backgroundColor = [UIColor clearColor];
        _detailText.numberOfLines = 0;
        _detailText.textAlignment = NSTextAlignmentCenter;
        _detailText.font = [UIFont boldSystemFontOfSize:14.0];
        [self.hud addSubview:_detailText];
        
//        [_detailText addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _detailText;
}

-(void)setIndicatorView:(UIView<LGBIndicatorDelegate> *)indicatorView
{
    if (_indicatorView == indicatorView) {
        return;
    }
    
    [_indicatorView removeFromSuperview];
    _indicatorView = indicatorView;
    
    [self.hud addSubview:_indicatorView];
    
    if ([_indicatorView respondsToSelector:@selector(setStyle:)]) {
        [_indicatorView setStyle:self.style];
    }
    
}

-(void)setStyle:(LGBProgressViewStyle)style
{
    _style = style;
    
    if (self.indicatorView && [self.indicatorView respondsToSelector:@selector(setStyle:)]) {
        [self.indicatorView setStyle:style];
    }
}

@end
