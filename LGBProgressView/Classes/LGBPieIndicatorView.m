//
//  LGBPieIndicatorView.m
//  LGBProgress
//
//  Created by lgb789 on 16/6/6.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBPieIndicatorView.h"

@interface LGBPieIndicatorLayer : CALayer
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *fillColor;
@end

@implementation LGBPieIndicatorLayer

@dynamic progress, color, fillColor;

+(BOOL)needsDisplayForKey:(NSString *)key
{
    return ([key isEqualToString:@"progress"] || [key isEqualToString:@"color"] || [key isEqualToString:@"fillColor"] || [super needsDisplayForKey:key]);
}

-(id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"progress"]) {
        CABasicAnimation *progressAnimation = [CABasicAnimation animation];
        progressAnimation.fromValue = [self.presentationLayer valueForKey:event];
        progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        return progressAnimation;
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx
{
    UIGraphicsPushContext(ctx);
    
    CGRect rect = self.bounds;
    
    CGPoint center = CGPointMake(rect.origin.x + (CGFloat)floor(rect.size.height / 2.0), rect.origin.y + (CGFloat)floor(rect.size.height / 2.0));
    CGFloat lineWidth = 2.0f;
    CGFloat radius = (CGFloat)floor(MIN(rect.size.width, rect.size.height) / 2.0) - lineWidth;
    
    //border && fill
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:NO];
    
    [borderPath setLineWidth:lineWidth];
    
    if (self.fillColor) {
        [self.fillColor setFill];
        [borderPath fill];
    }
    
    [self.color set];
    
    [borderPath stroke];

    //progress
    if (self.progress > 0.0) {
        UIBezierPath *progressPath = [UIBezierPath bezierPath];
        
        [progressPath setLineWidth:radius];
        
        CGFloat startAngle = -M_PI_2;
        CGFloat endAngel = startAngle + 2.0 * M_PI * self.progress;
        
        //radius 半径是从中心点到画线的宽的一半
        [progressPath addArcWithCenter:center radius:radius / 2 startAngle:startAngle endAngle:endAngel clockwise:YES];
        
        [progressPath stroke];
        
        UIGraphicsPopContext();
    }
}

@end

@implementation LGBPieIndicatorView

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
    return [LGBPieIndicatorLayer class];
}

#pragma mark - 代理

-(void)setStyle:(LGBProgressViewStyle)style
{
    switch (style) {
        case LGBProgressViewStyleLight:
            
            [(LGBPieIndicatorLayer *)self.layer setColor:kIndicatorDarColor];
            [(LGBPieIndicatorLayer *)self.layer setFillColor:[UIColor whiteColor]];
            break;
        case LGBProgressViewStyleDark:

            [(LGBPieIndicatorLayer *)self.layer setColor:[UIColor whiteColor]];
            [(LGBPieIndicatorLayer *)self.layer setFillColor:kIndicatorDarColor];
            break;
        default:
            break;
    }
}

-(void)setProgress:(CGFloat)progress
          animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:(animated ? 0.3 : 0.0)];
    [(LGBPieIndicatorLayer *)self.layer setProgress:progress];
    [CATransaction commit];
}

#pragma mark - 事件处理 

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置

@end
