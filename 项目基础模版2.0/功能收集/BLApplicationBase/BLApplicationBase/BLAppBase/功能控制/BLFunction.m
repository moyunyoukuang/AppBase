//
//  BLFunction.m
//  BaiTang
//
//  Created by camore on 16/3/11.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLFunction.h"


@implementation BLFunction

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

#pragma mark- ********************收集的功能********************


@end
