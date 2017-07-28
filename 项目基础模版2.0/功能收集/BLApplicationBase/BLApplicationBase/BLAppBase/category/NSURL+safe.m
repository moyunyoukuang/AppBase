//
//  dss.m
//  deLaiSu
//
//  Created by camore on 15/10/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSURL+safe.h"
#import "objc/runtime.h"


@implementation NSURL (safe)


+ (nullable instancetype)URLWithStringSafe:(NSString *)URLString
{
    URLString = [CommonTool makeHttpsSafeForContent:URLString];
    
    NSURL * url = [NSURL URLWithString:URLString];
    
    if(url == nil)
    {
        url = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return url;
}


////大部分collection类都是类族无法使用switch method方案
//+ (void)load {
//    ///交换方法，使可以调用覆盖前的方法
//    Method original, swizzle;
//    
//    original = class_getClassMethod(self, @selector(URLWithString:));
//    swizzle = class_getClassMethod(self, @selector(URLWithStringSafe:));
//    
//    if( original && swizzle)
//    {
//        method_exchangeImplementations(original, swizzle);
//    }
//    
//}
//
//
//+ (nullable instancetype)URLWithStringSafe:(NSString *)URLString
//{
//    URLString = [CommonTool makeHttpsSafeForContent:URLString];
//    
//    NSURL * url = [NSURL URLWithStringSafe:URLString];
//
//    if(url == nil)
//    {
//        url = [NSURL URLWithStringSafe:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    }
//  
//    return url;
//}



@end
