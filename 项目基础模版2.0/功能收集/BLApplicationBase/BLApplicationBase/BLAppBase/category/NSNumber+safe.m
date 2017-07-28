//
//  NSNumberEXT.m
//  deLaiSu
//
//  Created by camore on 15/7/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSNumber+safe.h"

@implementation NSNumber(safe)
- (BOOL)isEqualToString:(NSString *)aString
{
    return [aString isEqualToString: [self stringValue] ];
}

-(NSInteger)length
{
    return [[self stringValue] length];
}
@end
