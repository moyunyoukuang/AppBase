//
//  BLNetWorkResult.m
//  BaiTang
//
//  Created by BLapple on 16/3/6.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLNetWorkResult.h"

@implementation BLNetWorkResult


- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"result_code"])
    {
        
        if([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
        {
            _result_code = (NetStatusCode)[key integerValue];
        }
        
        return;
    }
    [super setValue:value forKey:key];

}

@end
