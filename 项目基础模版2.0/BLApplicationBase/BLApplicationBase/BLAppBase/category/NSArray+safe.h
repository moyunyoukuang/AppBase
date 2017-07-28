//
//  NSArray+Utility.h
//  CloudManager
//
//  Created by xiulian.yin on 15/4/11.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (safe)

+(instancetype)arrayWithArraySafe:(NSArray *)array;

-(instancetype)initWithArraySafe:(NSArray *)array;

- (id)objectAtIndexSafe:(NSUInteger)index;

/** 是否存在string值*/
- (BOOL)existStringValue:(NSString*)value;

/** 数组中相同的对象位置 没有返回NSNotFound*/
- (NSInteger)indexForEquelObject:(id)anObject;

@end



@interface NSMutableArray (safe)


-(void)addObjectSafe:(id)anObject;

-(void)removeObjectAtIndexSafe:(NSInteger)index;

-(void)removeObjectsInRangeSafe:(NSRange)range;

-(void)removeLastObjectsafe;



@end
