//
//  BLthreadControll.h
//  BLReader
//
//  Created by camore on 2017/5/23.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>




//返回yes 继续，no退出
typedef BOOL (^threadControl)(void);

/** 线程控制器 可以开启一个线程执行一个方法 (用于线程控制)*/
@interface BLthreadControll : NSObject

/** control 返回yes 会一直执行*/
-(void)startCircleWithBlock:(threadControl)control;

-(void)stop;

/** 在运行*/
-(BOOL)isRunning;

@end
