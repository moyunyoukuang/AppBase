//
//  DistanceControl.h
//  DrawSelection
//
//  Created by camore on 17/2/10.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 距离控制器 使两个不同的距离对应等比例返回 并记录边距*/
@interface DistanceControl : NSObject

/** 开始点 结束点设置*/
@property ( nonatomic , readwrite ) float realLocation_start;

@property ( nonatomic , readwrite ) float realLocation_end;

@property ( nonatomic , readwrite) float relationStart;

@property ( nonatomic , readwrite) float relationEnd;

/** 获取对应的位置（按比例）*/
-(float)getRealLocationForRange:(float)range;

/** 移动最小左边 对比长度不变，改变对比的位置*/
-(void)moveMinLeft:(float)Min_left;
/** 移动最大右边 对比长度不变，改变对比的位置*/
-(void)moveMaxRight:(float)Max_right;

@end
