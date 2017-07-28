//
//  BLTapGesture.m
//  BLReader
//
//  Created by camore on 2017/6/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLTapGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
@implementation BLTapGesture

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    
    [super  touchesBegan:touches withEvent:event];
    self.startPoint = [touch locationInView:self.view.window];
    
    
    //    avaliableRect
    CGPoint point = [touch locationInView:self.view];
    if( self.avaliableRect.size.width > 0 && !CGRectContainsPoint(self.avaliableRect, point))
    {//不在可用区域
        self.state = UIGestureRecognizerStateFailed;
    }
}
- (void)reset {
    [super reset];
    self.startPoint = CGPointZero;
    
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

@end
