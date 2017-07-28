//
//  BLthreadControll.m
//  BLReader
//
//  Created by camore on 2017/5/23.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLthreadControll.h"

@implementation BLthreadControll
{
    /** 在运行中*/
    __block BOOL   isrunning;
    /** 应该停止*/
    __block BOOL   shouldStop;
    /** 当前使用的队列*/
    __block dispatch_queue_t controlThread;
}

-(void)dealloc
{

}

/** control 返回yes 会一直执行*/
-(void)startCircleWithBlock:(threadControl)control;
{
    control = [control copy];
    isrunning = YES;
    controlThread = dispatch_queue_create("controlThread", NULL);
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(controlThread, ^{
        __strong typeof(self) strongSelf = weakSelf;
        @autoreleasepool {
            while (!shouldStop  && control()) {
                
            }
          
            [strongSelf end];
        }
    });
    
    
}

-(void)stop
{
    shouldStop = YES;
}

-(void)end
{
    isrunning = NO;
}

/** 在运行*/
-(BOOL)isRunning
{
    return isrunning;
}
@end
