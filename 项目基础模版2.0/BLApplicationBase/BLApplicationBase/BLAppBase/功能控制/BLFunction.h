//
//  BLFunction.h
//  BaiTang
//
//  Created by camore on 16/3/11.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^action_queue) (void);

/** 功能核心  用于处理业务*/
@interface BLFunction : NSObject
#pragma mark- ********************安全功能********************
/** 打开链接*/
+(void)opeUrl:(NSURL*)url;

#pragma mark- ********************顺序执行功能********************
/** 队列动作 (会在主线程触发,动作完成需要调用nextAction)*/
+(void)addQueueAction:(action_queue)action;

/** 开始操作 (会在主线程触发)*/
+(void)startQueueAction;

/** 下个操作 (会在主线程触发)*/
+(void)nextQueueAction;

#pragma mark- ********************收集的功能********************
//收集功能见功能扩展
/** 
 
 #pragma mark- 红包算法
 //红包算法 @"remainSize"剩余的红包数 @"remainMoney" 剩余的红包金钱
 +(double)getRandomMoneyPackage:(NSDictionary*)lastInfo;
 
 #pragma mark - Convert Video Format
 #import <AVFoundation/AVFoundation.h>
 +(void)convertToMP4:(AVURLAsset*)avAsset videoPath:(NSString*)videoPath succ:(void (^)())succ fail:(void (^)())fail;
 
 */


@end

