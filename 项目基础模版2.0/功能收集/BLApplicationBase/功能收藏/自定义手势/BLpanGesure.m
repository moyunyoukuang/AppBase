//
//  BLpanGesure.m
//  DaJiShi
//
//  Created by camore on 16/4/20.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLpanGesure.h"

@interface BLpanGesure ()
/** 起始滑动位置会有偏移，需要调整*/
@property ( nonatomic , readwrite ) BOOL  startChange;
@end

@implementation BLpanGesure
-(instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    
    if(self )
    {
        self.type = 3;
    }
    
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];

    [super  touchesBegan:touches withEvent:event];
    self.startPoint = [touch locationInView:self.view.window];
    
    self.point_mostLeft     = self.startPoint;
    self.point_mostRight    = self.startPoint;
    self.point_mostTop      = self.startPoint;
    self.point_mostDown     = self.startPoint;
    self.point_current      = self.startPoint;
    
//    avaliableRect
    CGPoint point = [touch locationInView:self.view];
    if(![self pointAvialble:point])
    {
        self.state = UIGestureRecognizerStateFailed;
    }
//    else
//    {
//        self.state = UIGestureRecognizerStateBegan;
//    }
    
    self.startChange = YES;
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    //滑动事件由上层处理 这里处理取消事件
    UITouch * touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self.view.window];
    /** 位移x*/
    CGFloat moveX = ticklePoint.x - self.startPoint.x;
    /** 位移y*/
    CGFloat moveY = ticklePoint.y - self.startPoint.y;
    
    if(self.startChange)
    {
        self.startChange = NO;
        self.startPoint = ticklePoint;
    }
    self.point_current = ticklePoint;
    
    CGPoint viewPoint = [touch locationInView:self.view];
    if( CGRectContainsPoint(self.view.bounds, viewPoint) )
    {
        self.currentPointInView = YES;
    }
    
    
    if(self.state == UIGestureRecognizerStatePossible || self.state == UIGestureRecognizerStateBegan)
    {
       
        
        switch (self.type) {
            case 1:
            {//左右 屏蔽上下
                if(ABS(moveY) >=8)
                {
                    self.state = UIGestureRecognizerStateFailed;
                }
            }
                break;
            case 2:
            {//上下 屏蔽左右
                if(ABS(moveX) >=8)
                {
                    self.state = UIGestureRecognizerStateFailed;
                }
            }
                break;
                
            default:
                break;
        }
        
        
        
    }
    
    if(ticklePoint.x < self.point_mostLeft.x)
    {
        self.point_mostLeft = ticklePoint;
    }
    
    if(ticklePoint.x > self.point_mostRight.x)
    {
        self.point_mostRight = ticklePoint;
    }
    
    if(ticklePoint.y < self.point_mostTop.y)
    {
        self.point_mostTop = ticklePoint;
    }
    
    if(ticklePoint.y > self.point_mostDown.y)
    {
        self.point_mostDown = ticklePoint;
    }
    
}

- (void)reset {
    [super reset];
    self.startPoint = CGPointZero;
    self.point_mostLeft     = self.startPoint;
    self.point_mostRight    = self.startPoint;
    self.point_mostTop      = self.startPoint;
    self.point_mostDown     = self.startPoint;
    
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self.view.window];
    self.point_current = ticklePoint;
    
    [super touchesEnded:touches withEvent:event];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self.view.window];
    self.point_current = ticklePoint;
    
    [super touchesCancelled:touches withEvent:event];

}


/** 判断点在可用区域*/
-(BOOL)pointAvialble:(CGPoint)point
{
    if(self.avaliableRange.length == 0)
    {
        return YES;
    }
    
    if(point.x > self.avaliableRange.location && point.x < self.avaliableRange.location + self.avaliableRange.length)
    {
        return YES;
    }
    return NO;
}

/** 设置手势识别失败*/
-(void)setFail
{
    self.state = UIGestureRecognizerStateFailed;
}


@end
