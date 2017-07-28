//
//  PointCounter.h
//  DrawSelection
//
//  Created by camore on 17/2/10.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PointCounter : NSObject

/** 两点间的距离*/
+(CGFloat)distanceBetweenPoint1:(CGPoint)p1 Point2:(CGPoint)p2;

/** 水平间距*/
+(CGFloat)howrizonDistanceBetweenPoints:(CGPoint)p1 Point2:(CGPoint)p2;

/** 竖直间距*/
+(CGFloat)verticalDistanceBetweenPoints:(CGPoint)p1 Point2:(CGPoint)p2;

///** 计算两点的水平夹角*/
//+(CGFloat)points2Degrees:(CGPoint)p1 Point2:(CGPoint)p2;

@end
