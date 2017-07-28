//
//  NSMutableDictionary+Utility.h
//  CloudManager
//
//  Created by xiulian.yin on 15/4/11.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (safe)

+(instancetype)dictionaryWithDictionarySafe:(NSDictionary *)dict;

-(instancetype)initWithDictionarySafe:(NSDictionary *)otherDictionary;

@end


@interface NSMutableDictionary (safe)

- (void)setObjectSafe:(id)object forKey:(id<NSCopying>)aKey;


@end
