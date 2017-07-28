//
//  PointCounter.m
//  DrawSelection
//
//  Created by camore on 17/2/10.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "PointCounter.h"

@implementation PointCounter
/** 两点间的距离*/
+(CGFloat)distanceBetweenPoint1:(CGPoint)p1 Point2:(CGPoint)p2
{
    CGFloat deltaX = p2.x - p1.x;
    CGFloat deltaY = p2.y - p1.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}

/** 水平间距*/
+(CGFloat)howrizonDistanceBetweenPoints:(CGPoint)p1 Point2:(CGPoint)p2
{
    CGFloat deltaX = p2.x - p1.x;
    CGFloat deltaY = 0;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}

/** 竖直间距*/
+(CGFloat)verticalDistanceBetweenPoints:(CGPoint)p1 Point2:(CGPoint)p2
{
    CGFloat deltaX = 0;
    CGFloat deltaY = p2.y - p1.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}

///** 计算两点的水平夹角*/
//+(CGFloat)points2Degrees:(CGPoint)p1 Point2:(CGPoint)p2
//{
//    
//    double angle = Math.atan2(y2-y1,x2-x1);
//    return (float) Math.toDegrees(angle);
//
//}

@end
