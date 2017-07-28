//
//  BLFunction.m
//  BaiTang
//
//  Created by camore on 16/3/11.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLFunction.h"

@interface BLFunction ()



@end
@implementation BLFunction

static NSMutableArray * array_queueAction;

#pragma mark- ********************安全功能********************
/** 打开链接*/
+(void)opeUrl:(NSURL*)url
{
    if(!url)
    {
        return;
    }
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10)
    {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"success");
            }else{
                NSLog(@"no");
            }
        }];
        
    }
    else
    {
        [[UIApplication sharedApplication] openURL:url];
    }

}
#pragma mark- ********************顺序执行功能********************
/** 队列动作 (会在主线程触发)*/
+(void)addQueueAction:(void(^)(void))action
{
    @synchronized (self) {
        
        if(!array_queueAction)
        {
            array_queueAction = [NSMutableArray array];
        }
        [array_queueAction addObjectSafe:[action copy]];
        
    }
    
}

/** 开始操作 (会在主线程触发)*/
+(void)startQueueAction
{
    [self nextQueueAction];
}

/** 下个操作*/
+(void)nextQueueAction
{
    @synchronized (self) {
        if([array_queueAction count] > 0)
        {
            action_queue block = [array_queueAction objectAtIndexSafe:0];
            
            if(block)
            {
                [array_queueAction removeObject:block];
                dispatch_async(dispatch_get_main_queue(), ^{
                    block();
                });
                
            }
        }
        
    }
}
#pragma mark- ********************收集的功能********************


@end
