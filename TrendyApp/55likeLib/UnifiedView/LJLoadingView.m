//
//  LJLoadingView.m
//  55likeLibDemo
//
//  Created by junseek on 2017/5/11.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "LJLoadingView.h"

@interface LJLoadingView ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *trackBackgroundShapeLayer;

@end

@implementation LJLoadingView

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _trackBackgroundColor = [UIColor clearColor];
    _trackColor = [UIColor redColor];
    _lineWidth = 1;
    _lineCap = kCALineCapRound;
    _animateDuration = 2.f;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.bounds.size.width != 0) {
        [self stopAnimations];
        [self startAnimations];
    }
}

- (void)addAnimations {
    
    if (![self.shapeLayer superlayer]) {
        
        CGFloat width = self.bounds.size.width;
        // 设置圆的外界矩形
        CGRect ovalRect = CGRectMake(_lineWidth/2, _lineWidth/2, width - _lineWidth, width - _lineWidth);
        // 设置圆的轨迹path
        CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:ovalRect].CGPath;
        // 设置为layer的path
        self.trackBackgroundShapeLayer.path = path;
        self.shapeLayer.path = path;
        // 添加进度条轨道
        [self.layer addSublayer:self.shapeLayer];
        // 添加背景轨道
        [self.layer addSublayer:self.trackBackgroundShapeLayer];
    }
    
    
    // 动画调整轨道的结束点 ---
    // 设置需要执行动画的属性path
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    // 设置动画的其实点和结束点
    strokeEndAnimation.fromValue = @0.0;
    strokeEndAnimation.toValue = @1.0;
    // 设置动画时间
    strokeEndAnimation.duration = _animateDuration;
    // 设置动画函数类型
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 动画调整轨道的开始点 相当于清除轨迹,
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0.0;
    strokeStartAnimation.toValue = @1.0;
    // 时间比绘制时少, 看上去清除比较快
    strokeStartAnimation.duration = _animateDuration*0.5;
    // 设置动画开始时间 在上面的动画执行完毕后在执行 --- 看上去就像是在清除轨道
    strokeStartAnimation.beginTime = _animateDuration;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    // 设置包含的动画, 先后顺序由设置的beginTime决定
    groupAnimation.animations = @[strokeEndAnimation, strokeStartAnimation];
    // 组动画执行时间 == 上面两个动画时间之和
    groupAnimation.duration = 1.5*_animateDuration;
    // 重复次数 设置为无限大
    groupAnimation.repeatCount = MAXFLOAT;
    // 设置模式
    groupAnimation.fillMode = kCAFillModeForwards;
    
    // 在使用旋转动画来旋转self.layer 使每次重合的位置动态变化
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @0.0;
    rotation.toValue = @(2 * M_PI);
    rotation.duration = _animateDuration;
    rotation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotation forKey:@"roration"];
    
    [self.shapeLayer addAnimation:groupAnimation forKey:@"group"];
    
    
}

- (void)stopAnimations {
    [self.shapeLayer removeAllAnimations];
    [self.layer removeAllAnimations];
    self.hidden=YES;
}

- (void)startAnimations {
    self.hidden=NO;
    [self addAnimations];
}

- (CAShapeLayer *)trackBackgroundShapeLayer {
    if (!_trackBackgroundShapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        // 设置线的端点的样式
        shapeLayer.lineCap = _lineCap;
        // 设置线宽
        shapeLayer.lineWidth = _lineWidth;
        // 设置stroke模式的颜色
        shapeLayer.strokeColor = _trackBackgroundColor.CGColor;
        // 不需要fill模式
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        // 设置stroke路径的开始点和结束点 两者的范围是 [0,1]
        // 所以我们更改这两个属性的值就可以实现动画的效果
        shapeLayer.strokeStart = 0.0;
        shapeLayer.strokeEnd = 1.0;
        _trackBackgroundShapeLayer = shapeLayer;
        
    }
    return _trackBackgroundShapeLayer;
}
- (CAShapeLayer *)shapeLayer {
    if(!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineCap = _lineCap;
        shapeLayer.lineWidth = _lineWidth;
        shapeLayer.strokeColor = _trackColor.CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeStart = 0.0;
        shapeLayer.strokeEnd = 1.0;
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
