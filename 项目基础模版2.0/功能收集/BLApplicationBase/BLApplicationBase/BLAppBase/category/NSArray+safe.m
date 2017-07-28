//
//  NSArray+Utility.m
//  CloudManager
//
//  Created by xiulian.yin on 15/4/11.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import "NSArray+safe.h"


//http://www.myexception.cn/mobile/1991065.html 很可惜不能用 method_exchangeImplementations来实现safe方法

@implementation NSArray (safe)

//+ (void)load {
//    {
//        ///交换方法，使可以调用覆盖前的方法
//        Method original, swizzle;
//        
//        original = class_getClassMethod(self, @selector(arrayWithArray:));
//        swizzle  = class_getClassMethod(self, @selector(arrayWithArraySafe:));
//        
//        if( original && swizzle)
//        {
//            method_exchangeImplementations(original, swizzle);
//        }
//        
//        
//        
//    }
//    
//    {
//        ///交换方法，使可以调用覆盖前的方法
//        Method original, swizzle;
//        
//        original = class_getInstanceMethod(self, @selector(initWithArray:));
//        swizzle  = class_getInstanceMethod(self, @selector(initWithArraySafe:));
//        
//        if( original && swizzle)
//        {
//            method_exchangeImplementations(original, swizzle);
//        }
//    }
//    
//    {
//        ///交换方法，使可以调用覆盖前的方法
//        Method original, swizzle;
//        
//        original = class_getInstanceMethod(self, @selector(objectAtIndex:));
//        swizzle  = class_getInstanceMethod(self, @selector(objectAtIndexSafe:));
//        
//        if( original && swizzle)
//        {
//            method_exchangeImplementations(original, swizzle);
//        }
//    }
//
//    
//}



+(instancetype)arrayWithArraySafe:(NSArray *)array
{
    id  array_create = nil;
    
    if(array && [array isKindOfClass:[NSArray class]])
    {
        array_create = [self arrayWithArray:array];
        
    }else
    {
        array_create = [[self alloc] init];
    }
    return array_create;
}

-(instancetype)initWithArraySafe:(NSArray *)array
{
    if(array && [array isKindOfClass:[NSArray class]])
    {
        self = [self initWithArray:array];
        
    }else
    {
        self = [self init];
    }
    return self;
    
}

- (id)objectAtIndexSafe:(NSUInteger)index
{
    id object = nil;
    if (index < [self count])
    {
        object = [self objectAtIndex:index];
    }
    
    return object;
}

/** 是否存在string值*/
- (BOOL)existStringValue:(NSString*)value
{
    for(int i = 0 ; i < [self count] ; i ++)
    {
        NSString * string = [self objectAtIndexSafe:i];
        
        if([string isKindOfClass:[NSString class]])
        {
            if([string isEqualToString:value])
            {
                return YES;
            }
        }
    }
    
    return NO;
}

/** 数组中相同的对象位置 */
-(NSInteger)indexForEquelObject:(id)anObject
{
    for(int i = 0 ; i < [self count] ; i ++)
    {
        id string = [self objectAtIndexSafe:i];
        
        if([string isEqual:anObject])
        {
            return i;
        }
    }
    
    return NSNotFound;
}


@end


@implementation NSMutableArray (safe)


//+ (void)load {
//    
//
//    
//    {
//        /** 获取SEL和Method */
//        SEL originSel = @selector(addObject:);
//        SEL overrideSel = @selector(addObjectSafe:);
//        
//        methodSwizzling([[self new] class], originSel, overrideSel);
//    }
//    
//    {
//        /** 获取SEL和Method */
//        SEL originSel = @selector(removeObjectAtIndex:);
//        SEL overrideSel = @selector(removeObjectAtIndexSafe:);
//        
//        methodSwizzling([[self new] class], originSel, overrideSel);
//    }
//    
//    {
//        /** 获取SEL和Method */
//        SEL originSel = @selector(removeObjectsInRange:);
//        SEL overrideSel = @selector(removeObjectsInRangeSafe:);
//        
//        methodSwizzling([[self new] class], originSel, overrideSel);
//    }
//    
//    {
//        /** 获取SEL和Method */
//        SEL originSel = @selector(removeLastObject);
//        SEL overrideSel = @selector(removeLastObjectsafe);
//        
//        methodSwizzling([[self new] class], originSel, overrideSel);
//    }
//    
//}


-(void)addObjectSafe:(id)anObject;
{
    if(anObject)
    {
        [self addObject:anObject];
    }
}

-(void)removeObjectAtIndexSafe:(NSInteger)index
{
    if( index >=0 && index < [self count])
    {
        [self removeObjectAtIndex:index];
    }
}

-(void)removeObjectsInRangeSafe:(NSRange)range
{
    if(range.location >= [self count])
    {
        return;
    }
    if(range.location+range.length > [self count])
    {
        range.length = [self count] - range.location;
    }
    [self removeObjectsInRange:range];
    
}


-(void)removeLastObjectsafe
{
    if([self count]>0)
    {
        [self  removeLastObject];
    }
}

@end

