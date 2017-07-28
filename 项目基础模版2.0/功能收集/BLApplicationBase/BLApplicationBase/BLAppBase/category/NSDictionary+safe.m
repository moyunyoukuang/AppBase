//
//  NSMutableDictionary+Utility.m
//  CloudManager
//
//  Created by xiulian.yin on 15/4/11.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import "NSDictionary+safe.h"


@implementation NSDictionary (safe)



+(instancetype)dictionaryWithDictionarySafe:(NSDictionary *)dict
{
    id dic_create = nil;
    
    if(dic_create && [dict isKindOfClass:[NSDictionary class]])
    {
        dic_create = [self dictionaryWithDictionary:dict];
        
    }else
    {
        dic_create = [[self alloc] init];
    }
    return dic_create;
    
}

-(instancetype)initWithDictionarySafe:(NSDictionary *)otherDictionary
{
    if(otherDictionary && [otherDictionary isKindOfClass:[NSDictionary class]])
    {
        self = [self initWithDictionary:otherDictionary];
        
    }else
    {
        self = [self init];
    }
    return self;
    
}


@end


@implementation NSMutableDictionary (safe)



// 如果对象不为空，设置值，否则，将key对应原来的值去掉
- (void)setObjectSafe:(id)object forKey:(id<NSCopying>)aKey
{
    if (object)
    {
        if(aKey)
        {
            [self setObject:object forKey:aKey];
        }
        
    }
    else
    {
        if ([self objectForKey:aKey])
        {
            [self removeObjectForKey:aKey];
        }
//        [self setObject:@"" forKey:aKey];
    }
}


@end
