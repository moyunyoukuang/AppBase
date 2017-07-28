//
//  BallShadowView.m
//  DrawSelection
//
//  Created by camore on 17/2/9.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BallShadowView.h"
#import "PointCounter.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface BallShadowView () <CAAnimationDelegate>
{
    /***************数据控制***************/
    
    
    
    /***************视图***************/
    
    CAShapeLayer*           _shapeLayer;
}
@end

@implementation BallShadowView

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if(self)
    {
        [self chuShiHua];
        [self setUpViews];
    }
    return self;
}
-(void)chuShiHua
{
    
}

-(void)setUpViews
{
    
    self.backgroundColor = [UIColor clearColor];
    [self createAllView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
/** 显示视图 隐藏视图(放大缩小效果)*/
-(void)showView:(BOOL)show animate:(BOOL)animate
{
    if(self.isViewShowded == show)
    {
        return;
    }
  
    
//    
//    CATransform3D  tranceform = CATransform3DMakeScale (0.01, 0.01, 1.0);
//    
//    if(show)
//    {
//        tranceform = CATransform3DIdentity;
//
//    }
//    
//    if(animate)
//    {
//        _shapeLayer.transform = tranceform;
//    }
//    else
//    {
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
//        _shapeLayer.transform = tranceform;
//        [CATransaction commit];
//    }
    
    
    UIBezierPath * path = [self getBallPathForPoint:self.currentPoint dragPoint:self.dragPoint ];
    
    CGPathRef path_round = path.CGPath;
    CGPathRef path_null  = CGPathCreateWithRect(CGRectMake(self.currentPoint.x , self.currentPoint.y , 0, 0), NULL);
    
    CGPathRef path1 = path_round;
    CGPathRef path2 = path_null;
    
    if(show)
    {//显示
        path1 = path_null;
        path2 = path_round;
    }
    
    
    if(animate)
    {
        CAKeyframeAnimation * animation = [self createKeyframeAniamtionWithValue:@[(__bridge id)path1,(__bridge id)path2]];
        
        
        _shapeLayer.path = path2;
        [_shapeLayer removeAllAnimations];
        [_shapeLayer addAnimation:animation forKey:@"show"];
    }
    else
    {
        _shapeLayer.path = path2;
        [_shapeLayer removeAllAnimations];
    }
    
    
    CGPathRelease(path_null);

    
    
    self.isViewShowded = show;
}

/** 移动视图*/
-(void)moveViewToPoint:(CGPoint)point animate:(BOOL)animate
{
    

    
    self.currentPoint = point;
    self.dragPoint = point;
    
    
    CGPathRef path;
    BOOL needReleasePath = NO;
    if(self.isViewShowded)
    {
       //处理显示圆还是点
        UIBezierPath * path_round = [self roundRectPathForPoint:self.currentPoint Radius:self.outerRadius];
        path = path_round.CGPath;
    }
    else
    {
        CGPathRef path_null  = CGPathCreateWithRect(CGRectMake(self.currentPoint.x , self.currentPoint.y , 0, 0), NULL);
        path = path_null;
        needReleasePath = YES;
    }
    [self moveBallToPath:path animate:animate];
    
    if(needReleasePath)
    {
        CGPathRelease(path);
    }

}

/** 拖拉视图*/
-(void)DragViewToPoint:(CGPoint)point
{
    
    
    point.y = self.currentPoint.y;
    self.dragPoint = point;
    
    
    
    [self showBallAtPoint:self.currentPoint dragPoint:self.dragPoint ];
    
}

/** 爆炸效果*/
-(void)exPloreSelecteion
{
   
    CGPathRef path1 = CGPathCreateWithRect(CGRectMake(self.currentPoint.x , self.currentPoint.y , 0, 0), NULL);
//    CGPathRef path2 = CGPathCreateWithRect(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), NULL);

//    CGPathRef path2 = CGPathCreateWithRoundedRect(CGRectMake(self.currentPoint.x - self.frame.size.height/2,0, self.frame.size.height, self.frame.size.height), self.frame.size.height/2, self.frame.size.height/2, &CGAffineTransformIdentity);
    
    CGFloat ballWidth = self.frame.size.width;
    
    CGPathRef path2 = CGPathCreateWithRoundedRect(CGRectMake(self.currentPoint.x - ballWidth/2,(self.height - ballWidth)/2, ballWidth, ballWidth), ballWidth/2, ballWidth/2, &CGAffineTransformIdentity);
    
    
    CAKeyframeAnimation * animation = [self createKeyframeAniamtionWithValue:@[(__bridge id)path1,(__bridge id)path2] duration:0.35];
    
    _shapeLayer.path = path1;
    [_shapeLayer removeAllAnimations];
    [_shapeLayer addAnimation:animation forKey:@"explore"];
    
    CGPathRelease(path1);
    CGPathRelease(path2);
    
    self.isViewShowded = NO;
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************

#pragma mark- CAAnimationDelegate <NSObject>


/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim
{

}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_shapeLayer removeAnimationForKey:@"show"];
    [_shapeLayer removeAnimationForKey:@"move"];

}



#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{
    _shapeLayer = [CAShapeLayer new];
    [self.layer addSublayer:_shapeLayer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = [UIColor greenColor].CGColor;
    CGPathRef path_null  = CGPathCreateWithRect(CGRectMake(0 , 0 , 0, 0), NULL);
    _shapeLayer.path = path_null;
    CGPathRelease(path_null);
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图

/** 显示球视图*/
-(void)showBallAtPoint:(CGPoint)centerpoint dragPoint:(CGPoint)dragPoint
{
    {//如果在移动或者显示，则不操作
    
        CAAnimation * animation1 = [_shapeLayer animationForKey:@"move"];
        CAAnimation * animation2 = [_shapeLayer animationForKey:@"show"];
        if(animation1 || animation2)
        {
            return;
        }
    }
    
    
    UIBezierPath * path = [self getBallPathForPoint:centerpoint dragPoint:dragPoint ];
    
    
    
    
    if(path.CGPath)
    {
        CGPathRef prePath = _shapeLayer.path;
        
        if(!prePath)
        {
            prePath = CGPathCreateWithRect(CGRectMake(centerpoint.x + self.outerRadius/2, centerpoint.y + self.outerRadius/2, 0, 0), NULL);
            _shapeLayer.path = prePath;
            CGPathRelease(prePath);
        }
        
        CAKeyframeAnimation * animation = [self createKeyframeAniamtionWithValue:@[(__bridge id)prePath,(__bridge id)path.CGPath]];
        
        
        
        
        [_shapeLayer removeAllAnimations];
        _shapeLayer.path = path.CGPath;
        [_shapeLayer addAnimation:animation forKey:@"drag"];
        
    }

    
}



/** 动画移动到路径*/
-(void)moveBallToPath:(CGPathRef)path animate:(BOOL)animate
{
    CGPathRef prePath = _shapeLayer.path;
    if(!prePath)
    {
        prePath = CGPathCreateWithRect(CGRectMake(self.currentPoint.x , self.currentPoint.y , 0, 0), NULL);
        _shapeLayer.path = prePath;
        CGPathRelease(prePath);
    }
    if(animate)
    {
        CAKeyframeAnimation * animation = [self createKeyframeAniamtionWithValue:@[(__bridge id)prePath,(__bridge id)path]];
        animation.removedOnCompletion = YES;
        [_shapeLayer removeAllAnimations];
        _shapeLayer.path = path;
        [_shapeLayer addAnimation:animation forKey:@"move"];

    }
    else
    {
        _shapeLayer.path = path;
        [_shapeLayer removeAllAnimations];
    }
}



#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面

/** 获取球路径
 @param centerpoint 中心点位置
 @param dragPoint   托拽点位置
 */
-(UIBezierPath*)getBallPathForPoint:(CGPoint)centerpoint dragPoint:(CGPoint)dragPoint
{
    UIBezierPath * path = nil;
    
    /** 两点间的水平距离*/
    CGFloat r = [PointCounter howrizonDistanceBetweenPoints:centerpoint Point2:dragPoint];;

    
    if(r < self.centerRadius)
    {//拖拉距离不够 画圆
        path = [self roundRectPathForPoint:centerpoint Radius:self.outerRadius];
    }
    else
    {
        path = [self eggPathForCentPoint:centerpoint dragPoint:dragPoint ];
    }
    
    return path;
    
}

/** 圆形路径*/
-(UIBezierPath*)roundRectPathForPoint:(CGPoint)centerPoint Radius:(CGFloat)radius
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
//    [path addArcWithCenter:centerPoint radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    {//圆
        CGFloat radius = self.outerRadius;
        CGFloat sMagicNumber = 0.55228475;
        
        //中心点
        CGFloat centerX = centerPoint.x;
        CGFloat centerY = centerPoint.y;
        
        [path moveToPoint:CGPointMake(0 + centerX, -radius + centerY)];
        [path addCurveToPoint:CGPointMake(radius + centerX, 0 + centerY)  controlPoint1:CGPointMake(radius * sMagicNumber + centerX, -radius + centerY) controlPoint2:CGPointMake(radius+ centerX, -radius * sMagicNumber + centerY)];
        [path addCurveToPoint:CGPointMake(0 + centerX, radius + centerY)  controlPoint1:CGPointMake(radius + centerX, radius * sMagicNumber + centerY) controlPoint2:CGPointMake(radius * sMagicNumber + centerX, radius + centerY)];
        [path addCurveToPoint:CGPointMake(-radius + centerX, 0 + centerY)  controlPoint1:CGPointMake(-radius * sMagicNumber + centerX, radius + centerY) controlPoint2:CGPointMake(-radius + centerX , radius * sMagicNumber + centerY)];
        [path addCurveToPoint:CGPointMake(0 + centerX, -radius + centerY)  controlPoint1:CGPointMake(-radius + centerX , -radius * sMagicNumber + centerY) controlPoint2:CGPointMake(-radius * sMagicNumber + centerX , -radius + centerY)];
    }
    
    
    
    [path closePath];
    return path;
}

/** 蛋形路径*/
-(UIBezierPath*)eggPathForCentPoint:(CGPoint)centerPoint dragPoint:(CGPoint)dragPoint
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    NSString * nofinish; //这里图方便只考虑水平方向上的拖拽
    
    
    /** 拖拽方向  1右，－1左*/
    CGFloat direction = -1;
    if(centerPoint.x < dragPoint.x)
    {
        direction = 1;
    }
    
    
    CGPoint dragEdge = CGPointMake( dragPoint.x + direction *(self.outerRadius - self.centerRadius ), centerPoint.y );
//    CGPoint centerEdge = CGPointMake(centerPoint.x - direction * self.outerRadius , centerPoint.y);
    
//    {//画椭圆
//        
//       
//        /** 两点间的水平距离*/
//        CGFloat r = [PointCounter howrizonDistanceBetweenPoints:dragEdge Point2:centerEdge];;
//
//        
//        
//        CGMutablePathRef cgPath =  CGPathCreateMutable();
//        
//        CGPoint leftPoint = dragEdge;
//        
//        if(direction == 1)
//        {
//            leftPoint = centerEdge;
//        }
//        CGPathAddEllipseInRect(cgPath, nil, CGRectMake(leftPoint.x, centerPoint.y - self.outerRadius , r, self.outerRadius*2));
//        
//        
//        path = [UIBezierPath bezierPathWithCGPath:cgPath];
//        CGPathRelease(cgPath);
//        
//    }
    
//    {//圆
//        path = [UIBezierPath bezierPath];
//        CGFloat radius = self.outerRadius;
//        CGFloat sMagicNumber = 0.55228475;
//        
//        //中心点
//        CGFloat centerX = dragPoint.x;
//        CGFloat centerY = dragPoint.y;
//        
//        //圆
////        [path moveToPoint:CGPointMake(0, -radius)];
////        [path addCurveToPoint:CGPointMake(radius, 0)  controlPoint1:CGPointMake(radius * sMagicNumber, -radius) controlPoint2:CGPointMake(radius, -radius * sMagicNumber)];
////        [path addCurveToPoint:CGPointMake(0, radius)  controlPoint1:CGPointMake(radius, radius * sMagicNumber) controlPoint2:CGPointMake(radius * sMagicNumber, radius)];
////        [path addCurveToPoint:CGPointMake(-radius, 0)  controlPoint1:CGPointMake(-radius * sMagicNumber, radius) controlPoint2:CGPointMake(-radius , radius * sMagicNumber)];
////        [path addCurveToPoint:CGPointMake(0, -radius)  controlPoint1:CGPointMake(-radius , -radius * sMagicNumber) controlPoint2:CGPointMake(-radius * sMagicNumber , -radius)];
//        
//        
//        [path moveToPoint:CGPointMake(0 + centerX, -radius + centerY)];
//        //右边
//        radius = self.outerRadius*1.5;
//        [path addCurveToPoint:CGPointMake(radius + centerX, 0 + centerY)  controlPoint1:CGPointMake(radius * sMagicNumber + centerX, -radius + centerY) controlPoint2:CGPointMake(radius+ centerX, -radius * sMagicNumber + centerY)];
//        [path addCurveToPoint:CGPointMake(0 + centerX, radius + centerY)  controlPoint1:CGPointMake(radius + centerX, radius * sMagicNumber + centerY) controlPoint2:CGPointMake(radius * sMagicNumber + centerX, radius + centerY)];
//        //左边
//        radius = self.outerRadius*0.8;
//        [path addCurveToPoint:CGPointMake(-radius + centerX, 0 + centerY)  controlPoint1:CGPointMake(-radius * sMagicNumber + centerX, radius + centerY) controlPoint2:CGPointMake(-radius + centerX , radius * sMagicNumber + centerY)];
//        [path addCurveToPoint:CGPointMake(0 + centerX, -radius + centerY)  controlPoint1:CGPointMake(-radius + centerX , -radius * sMagicNumber + centerY) controlPoint2:CGPointMake(-radius * sMagicNumber + centerX , -radius + centerY)];
//        
//        
//        
//        
//    }
    
    {//蛋
        path = [UIBezierPath bezierPath];
        CGFloat radius = self.outerRadius;
        CGFloat sMagicNumber = 0.55228475;
        

        
        //中心点
        CGFloat centerX = centerPoint.x;
        CGFloat centerY = centerPoint.y;
        
        /** 边缘增加的距离*/
        CGFloat distance = [PointCounter howrizonDistanceBetweenPoints:centerPoint Point2:dragEdge];
        distance -= self.outerRadius;
        
       
        
        float longRadius  = radius  + distance*0.55f;
        float shortRadius = radius  + distance*0.15f;
        
        if(shortRadius > self.outerRadius)
        {
            shortRadius = self.outerRadius;
        }
        
        
        
        if(distance*0.45 < self.outerRadius - self.centerRadius)
        {//中心移动距离在接受范围内
            centerX += direction*distance*0.45;
        }
        else
        {
            longRadius  = radius  + distance - (self.outerRadius - self.centerRadius);
            centerX += direction*(self.outerRadius - self.centerRadius);
            
        }
        

        
        
        float leftRadius = longRadius;
        float rightRadius = shortRadius;
        
        if( centerPoint.x < dragPoint.x )
        {
            leftRadius = shortRadius;
            rightRadius = longRadius;
        }
        
        
        //右边
        [path moveToPoint:CGPointMake(0 + centerX, -radius + centerY)];
        [path addCurveToPoint:CGPointMake(rightRadius + centerX, 0 + centerY)  controlPoint1:CGPointMake(rightRadius * sMagicNumber + centerX, -radius + centerY) controlPoint2:CGPointMake(rightRadius+ centerX, -radius * sMagicNumber + centerY)];
        [path addCurveToPoint:CGPointMake(0 + centerX, radius + centerY)  controlPoint1:CGPointMake(rightRadius + centerX, radius * sMagicNumber + centerY) controlPoint2:CGPointMake(rightRadius * sMagicNumber + centerX, radius + centerY)];
        
        //左边
        [path addCurveToPoint:CGPointMake(-leftRadius + centerX, 0 + centerY)  controlPoint1:CGPointMake(-leftRadius * sMagicNumber + centerX, radius + centerY) controlPoint2:CGPointMake(-leftRadius + centerX , radius * sMagicNumber + centerY)];
        [path addCurveToPoint:CGPointMake(0 + centerX, -radius + centerY)  controlPoint1:CGPointMake(-leftRadius + centerX , -radius * sMagicNumber + centerY) controlPoint2:CGPointMake(-leftRadius * sMagicNumber + centerX , -radius + centerY)];
    }

    [path closePath];
    return path;
}



- (CAKeyframeAnimation *)createKeyframeAniamtionWithValue:(NSArray *)value{

    return [self createKeyframeAniamtionWithValue:value duration:0.1];
}

- (CAKeyframeAnimation *)createKeyframeAniamtionWithValue:(NSArray *)value duration:(CGFloat)duration{
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyframeAnimation.values  = value;
    keyframeAnimation.duration = duration;
    keyframeAnimation.delegate = self;
    keyframeAnimation.removedOnCompletion = YES;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    return keyframeAnimation;
}

#pragma mark- ********************跳转其他页面********************

@end
