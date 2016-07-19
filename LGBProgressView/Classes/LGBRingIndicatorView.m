//
//  LGBRingIndicatorView.m
//  LGBProgress
//
//  Created by lgb789 on 16/6/7.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBRingIndicatorView.h"

@interface LGBRingIndicatorLayer : CALayer
@property (nonatomic, strong) UIColor *ringColor;
@property (nonatomic, strong) UIColor *ringBackgroundColor;
@property (nonatomic, assign) CGFloat progress;
@end

@implementation LGBRingIndicatorLayer

@dynamic ringColor, ringBackgroundColor, progress;

+(BOOL)needsDisplayForKey:(NSString *)key
{
    return ([key isEqualToString:@"progress"] || [key isEqualToString:@"ringColor"] || [key isEqualToString:@"ringBackgroundColor"] || [super needsDisplayForKey:key]);
}

-(id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"progress"]) {
        CABasicAnimation *progressAnimation = [CABasicAnimation animation];
        progressAnimation.fromValue = [self.presentationLayer valueForKey:@"progress"];
        progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        return progressAnimation;
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx
{
    UIGraphicsPushContext(ctx);
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat lineWidth = 3.0;
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2 - lineWidth;
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0 endAngle:2 * M_PI clockwise:NO];
    
    [borderPath setLineWidth:lineWidth];
    
    [self.ringBackgroundColor set];

    [borderPath stroke];
    
    
    //progress
    if (self.progress > 0.0f) {
        CGFloat startAngle = -M_PI_2;
        CGFloat endAngle = startAngle + 2 * M_PI * self.progress;
        UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [progressPath setLineWidth:lineWidth];
        
        [self.ringColor set];
        
        [progressPath stroke];
        
        UIGraphicsPopContext();
    }
}

@end

@implementation LGBRingIndicatorView

#pragma mark - 公有方法 

#pragma mark - 重写父类方法

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

+(Class)layerClass
{
    return [LGBRingIndicatorLayer class];
}

#pragma mark - 代理

-(void)setStyle:(LGBProgressViewStyle)style
{
    LGBRingIndicatorLayer *layer = (LGBRingIndicatorLayer *)self.layer;
    switch (style) {
        case LGBProgressViewStyleLight:
            [layer setRingColor:kIndicatorDarColor];
            [layer setRingBackgroundColor:[UIColor lightGrayColor]];
            break;
        case LGBProgressViewStyleDark:
            [layer setRingColor:[UIColor whiteColor]];
            [layer setRingBackgroundColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:(animated ? 0.3 : 0.0)];
    LGBRingIndicatorLayer *layer = (LGBRingIndicatorLayer *)self.layer;
    [layer setProgress:progress];
    [CATransaction commit];
}

#pragma mark - 事件处理 

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置


@end
