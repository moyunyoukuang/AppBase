//
//  DistanceControl.m
//  DrawSelection
//
//  Created by camore on 17/2/10.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "DistanceControl.h"

@implementation DistanceControl

/** 移动最小左边*/
-(void)moveMinLeft:(float)Min_left
{
    if(Min_left < self.relationStart)
    {
        float moveLength =  Min_left - self.relationStart;
        
        self.relationEnd += moveLength;
        self.relationStart += moveLength;
    }
}
/** 移动最大右边*/
-(void)moveMaxRight:(float)Max_right
{
    if(Max_right > self.relationEnd)
    {
        float moveLength = Max_right - self.relationEnd;
        
        self.relationEnd += moveLength;
        self.relationStart += moveLength;
    }
}


/** 获取对应的位置（按比例）*/
-(float)getRealLocationForRange:(float)range
{
    float realLocation = 0;
    /** 比例*/
    float percent = (range - self.relationStart)/( self.relationEnd - self.relationStart);
    
    realLocation = self.realLocation_start + ( self.realLocation_end - self.realLocation_start)*percent;
    
    if(realLocation < self.realLocation_start)
    {
        realLocation = self.realLocation_start;
    }
    
    if(realLocation > self.realLocation_end)
    {
        realLocation = self.realLocation_end;
    }
    
    return realLocation;
}


@end
