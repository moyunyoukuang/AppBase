//
//  BLSwipeGesture.m
//  DaJiShi
//
//  Created by camore on 16/11/8.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLSwipeGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
@implementation BLSwipeGesture

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    if(![self pointAvialble:point])
    {
        self.state = UIGestureRecognizerStateFailed;
    }
  
    
    
}

/** 判断点在可用区域*/
-(BOOL)pointAvialble:(CGPoint)point
{
    if(point.x >= self.avaliableRange.location && point.x <= self.avaliableRange.location + self.avaliableRange.length)
    {
        return YES;
    }
    
    return NO;
}

@end
