//
//  NSObject+Extension.m
//  BLAppBase
//
//  Created by camore on 17/2/28.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/message.h>
//#import "objc/runtime.h"


//void methodSwizzling(Class class,SEL originSel,SEL overrideSel)
//{
//    Method originMethod = class_getInstanceMethod(class, originSel);
//    Method overrideMethod = class_getInstanceMethod(class, overrideSel);
//    
//    if (class_addMethod(class,
//                        originSel,
//                        method_getImplementation(overrideMethod),
//                        method_getTypeEncoding(originMethod)))
//    {
//        /** case1:NSMutableDictionary中没有-setObject:forKey:的实现 */
//        class_replaceMethod(class,
//                            overrideSel,
//                            method_getImplementation(originMethod),
//                            method_getTypeEncoding(originMethod));
//    }else{
//        /** case2:NSMutableDictionary中有-setObject:forKey:的实现   */
//        method_exchangeImplementations(originMethod, overrideMethod);
//    }
//    
//}

@implementation  NSObject (Extension)

/** 当前类的属性列表*/
-(NSArray*)currentPropertyNameList
{
    NSMutableArray * array_result = [NSMutableArray array];
    
    unsigned int  count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    
    for ( int i = 0 ; i < count ; i ++ )
    {
        Ivar   ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        //去掉下划线
        propertyName = [propertyName substringFromIndex:1];
        
        [array_result addObjectSafe:propertyName];
    }
    
    free(ivars);
    
    return array_result;
    
}

/** 返回model */
-(id)modelValue{
    return objc_getAssociatedObject(self, @"modelValue");
}

/** 设置model */
-(void)setModelValue:(id)value{
    if(value)
    {
        objc_setAssociatedObject(self, @"modelValue", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

/** 返回stringValue1 */
-(id)stringValue1{
    return objc_getAssociatedObject(self, @"stringValue1");
}

/** 设置stringValue1 */
-(void)setStringValue1:(id)value{
    if(value)
    {
        objc_setAssociatedObject(self, @"stringValue1", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

/** 返回stringValue2 */
-(id)stringValue2{
    return objc_getAssociatedObject(self, @"stringValue2");
}

/** 设置stringValue2 */
-(void)setStringValue2:(id)value{
    if(value)
    {
        objc_setAssociatedObject(self, @"stringValue2", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}

@end



