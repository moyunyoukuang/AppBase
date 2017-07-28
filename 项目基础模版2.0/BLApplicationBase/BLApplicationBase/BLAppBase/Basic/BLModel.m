//
//  BLModel.m
//  BaiTang
//
//  Created by BLapple on 16/3/6.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLModel.h"

#import <objc/message.h>

@implementation  NSObject (ExtensionBLmodel)

/** 从BLmodel开始 所有的属性名*/
-(NSArray*)allPropertyNameList
{   //配合blmodel 接口
    return [NSMutableArray array];
}

@end

@implementation BLModelBasic

@end
/**
 {//参考http://www.itnose.net/detail/6428819.html
 
 #import <objc/runtime.h>
 #import <objc/message.h>
 
 @implementation HDFArchiveModel
 
 - (void)encodeWithCoder:(NSCoder *)aCoder {
 unsigned int outCount = 0;
 Ivar *ivars = class_copyIvarList([self class], &outCount);
 
 for (unsigned int i = 0; i < outCount; ++i) {
 Ivar ivar = ivars[i];
 
 // 获取成员变量名
 const void *name = ivar_getName(ivar);
 NSString *ivarName = [NSStringstringWithUTF8String:name];
 // 去掉成员变量的下划线
 ivarName = [ivarNamesubstringFromIndex:1];
 
 // 获取getter方法
 SEL getter = NSSelectorFromString(ivarName);
 if ([selfrespondsToSelector:getter]) {
 const void *typeEncoding = ivar_getTypeEncoding(ivar);
 NSString *type = [NSStringstringWithUTF8String:typeEncoding];
 
 // const void *
 if ([typeisEqualToString:@"r^v"]) {
 const char *value = ((const void *(*)(id, SEL))(void *)objc_msgSend)((id)self, getter);
 NSString *utf8Value = [NSStringstringWithUTF8String:value];
 [aCoderencodeObject:utf8ValueforKey:ivarName];
 continue;
 }
 // int
 else if ([typeisEqualToString:@"i"]) {
 int value = ((int (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);
 [aCoderencodeObject:@(value)forKey:ivarName];
 continue;
 }
 // float
 else if ([typeisEqualToString:@"f"]) {
 float value = ((float (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);
 [aCoderencodeObject:@(value)forKey:ivarName];
 continue;
 }
 
 id value = ((id (*)(id, SEL))(void *)objc_msgSend)((id)self, getter);
 if (value != nil && [valuerespondsToSelector:@selector(encodeWithCoder:)]) {
 [aCoderencodeObject:valueforKey:ivarName];
 }
 }
 }
 
 free(ivars);
 }
 
 - (instancetype)initWithCoder:(NSCoder *)aDecoder {
 if (self = [super init]) {
 unsigned int outCount = 0;
 Ivar *ivars = class_copyIvarList([self class], &outCount);
 
 for (unsigned int i = 0; i < outCount; ++i) {
 Ivar ivar = ivars[i];
 
 // 获取成员变量名
 const void *name = ivar_getName(ivar);
 NSString *ivarName = [NSStringstringWithUTF8String:name];
 // 去掉成员变量的下划线
 ivarName = [ivarNamesubstringFromIndex:1];
 // 生成setter格式
 NSString *setterName = ivarName;
 // 那么一定是字母开头
 if (![setterNamehasPrefix:@"_"]) {
 NSString *firstLetter = [NSStringstringWithFormat:@"%c", [setterNamecharacterAtIndex:0]];
 setterName = [setterNamesubstringFromIndex:1];
 setterName = [NSStringstringWithFormat:@"%@%@", firstLetter.uppercaseString, setterName];
 }
 setterName = [NSStringstringWithFormat:@"set%@:", setterName];
 // 获取getter方法
 SEL setter = NSSelectorFromString(setterName);
 if ([selfrespondsToSelector:setter]) {
 const void *typeEncoding = ivar_getTypeEncoding(ivar);
 NSString *type = [NSStringstringWithUTF8String:typeEncoding];
 NSLog(@"%@", type);
 
 // const void *
 if ([typeisEqualToString:@"r^v"]) {
 NSString *value = [aDecoderdecodeObjectForKey:ivarName];
 if (value) {
 ((void (*)(id, SEL, const void *))objc_msgSend)(self, setter, value.UTF8String);
 }
 
 continue;
 }
 // int
 else if ([typeisEqualToString:@"i"]) {
 NSNumber *value = [aDecoderdecodeObjectForKey:ivarName];
 if (value != nil) {
 ((void (*)(id, SEL, int))objc_msgSend)(self, setter, [valueintValue]);
 }
 continue;
 } else if ([typeisEqualToString:@"f"]) {
 NSNumber *value = [aDecoderdecodeObjectForKey:ivarName];
 if (value != nil) {
 ((void (*)(id, SEL, float))objc_msgSend)(self, setter, [valuefloatValue]);
 }
 continue;
 }
 
 // object
 id value = [aDecoderdecodeObjectForKey:ivarName];
 if (value != nil) {
 ((void (*)(id, SEL, id))objc_msgSend)(self, setter, value);
 }
 }
 }
 
 free(ivars);
 }
 
 return self;
 }
 + (void)test {
 HDFArchiveModel *archiveModel = [[HDFArchiveModel alloc]init];
 archiveModel.archive = @"标哥学习自动归档";
 archiveModel.session = "http://www.henishuo.com";
 archiveModel.totalCount = @(123);
 archiveModel.referenceCount = 10;
 archiveModel._floatValue = 10.0;
 
 NSString *path = NSHomeDirectory();
 path = [NSStringstringWithFormat:@"%@/archive", path];
 [NSKeyedArchiverarchiveRootObject:archiveModel
 toFile:path];
 
 HDFArchiveModel *unarchiveModel = [NSKeyedUnarchiverunarchiveObjectWithFile:path];
 
 }
 
 @end
 
 }
 
 
 */


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface BLModel ()
{
    /***************数据控制***************/
    
    /***************视图***************/
}
@end

@implementation BLModel

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(instancetype)initWithDictionary:(NSDictionary*)diction
{
   
    self = [super init];
    if(self)
    {
        if(diction && [diction isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary * mutiDIc = [[NSMutableDictionary alloc] init];
            for( NSString * key  in diction.allKeys )
            {
                NSString * object = [diction objectForKey:key];
                if([object isKindOfClass:[NSNumber class]])
                {
                    object = [(NSNumber*)object stringValue];
                }
                
                if(object)
                {
                    [mutiDIc setObjectSafe:object forKey:key];
                }
            }
            
            [self setValuesForKeysWithDictionary:mutiDIc];
            
        }
        self.origineObject = diction;
    }
    return self;
}

/** 用string(jason)生成模型*/
-(instancetype)initWithString:(NSString*)string_jason
{
    NSDictionary * dic = [CommonTool allTypeToDic:string_jason];
    return [self initWithDictionary:dic];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        {
            //读取属性
            NSArray * array_property = [self allPropertyNameList];
            for ( int i = 0 ; i < [array_property count] ; i ++ )
            {
                NSString * property = [array_property objectAtIndexSafe:i];
                [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
                
            }
        }

    }

    //    [NSKeyedArchiver archiveRootObject:self toFile:@""];
    //    [NSKeyedUnarchiver unarchiveObjectWithFile:@""]
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    {
        //保存属性
        NSArray * array_property = [self allPropertyNameList];
        for ( int i = 0 ; i < [array_property count] ; i ++ )
        {
            NSString * property = [array_property objectAtIndexSafe:i];
            [aCoder encodeObject:[self valueForKey:property] forKey:property];
        }
    }
    
}


#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
-(NSMutableDictionary*)saveToDic
{
    NSMutableDictionary * diction_save = [NSMutableDictionary dictionary] ;
    NSArray * array_property = [self allPropertyNameList];
    for ( int i = 0 ; i < [array_property count] ; i ++ )
    {
        NSString * property = [array_property objectAtIndexSafe:i];
        [diction_save setObjectSafe:[self valueForKey:property] forKey:property];
    }
    
    
    return diction_save;
}

/** 信息是否变化 对比创建时的信息*/
-(BOOL)infoChanged
{
    NSDictionary * dic_save = [self saveToDic];
    if( [self.origineObject isKindOfClass:[NSDictionary class]] && [dic_save isEqualToDictionary:self.origineObject])
    {
        return NO;
    }
    return YES;
}

/** 从BLmodel开始 所有的属性名*/
-(NSArray*)allPropertyNameList
{
    NSMutableArray * array_result = [NSMutableArray array];
    
    if([super isKindOfClass:[BLModel class]])
    {//获取上层的属性列表
 
        NSArray * array = [super allPropertyNameList] ;
        
        array_result = [array mutableCopy];
        
    }
    
    {
        //添加这层的属性列表
        NSArray * array_currentProperty = [self currentPropertyNameList];
        [array_result addObjectsFromArray:array_currentProperty];
    }
    
    return array_result;
    
}


#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************

#pragma mark- key&value
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //避免报错
    
    
}
- (nullable id)valueForUndefinedKey:(NSString *)key
{   //避免报错
    return nil;
}
//- (id)valueForKey:(NSString *)key
//{
//   return [super valueForKey:key];
//}
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面



#pragma mark- ********************跳转其他页面********************


//- (void)setNilValueForKey:(NSString *)key
//{
//
//}



- (id)valueForKey:(NSString *)key
{
   id value = [super valueForKey:key];
    
    //把数值类型变为字符串类型
    if([value isKindOfClass:[NSNumber class]])
    {
        value = [(NSNumber*)value stringValue];
    }
    
    return value;
}


//- (void)setValue:(nullable id)value forKey:(NSString *)key
//{
//    if([key isEqualToString:@"tag_group_arr"])
//    {
//        NSMutableArray * mutiArray = [NSMutableArray array];
//        if([value isKindOfClass:[NSArray class]])
//        {
//            for(int i = 0 ; i < [value count] ; i ++)
//            {
//                NSDictionary * dic = [value objectAtIndexSafe:i];
//                TagGroupModel * model = [[TagGroupModel alloc] initWithDictionary:dic];
//                [mutiArray addObjectSafe:model];
//            }
//        }
//        _tag_group_arr = mutiArray;
//        return;
//    }
//
//
//    if([key isEqualToString:@"review_notice"])
//    {
//        ReviewNoticeModel * model = nil;
//        if([value isKindOfClass:[NSDictionary class]])
//        {
//            model = [[ReviewNoticeModel alloc] initWithDictionary:value];
//        }
//        _review_notice = model;
//        return;
//    }
//
//    [super setValue:value forKey:key];
//
//}

///** 保存为dicinfo*/
//-(NSMutableDictionary*)saveToDic
//{
//    NSMutableDictionary * mutiDic = [[NSMutableDictionary alloc] init];
//
//    [mutiDic setObjectSafe:self.time_cycle forKey:@"time_cycle"];
//    [mutiDic setObjectSafe:self.type forKey:@"type"];
//    [mutiDic setObjectSafe:self.value forKey:@"value"];
//    [mutiDic setObjectSafe:self.work_state forKey:@"work_state"];
//    [mutiDic setObjectSafe:self.sign_state forKey:@"sign_state"];
//    [mutiDic setObjectSafe:self.page forKey:@"page"];
//    [mutiDic setObjectSafe:self.page_index forKey:@"page_index"];
//
//
//    return mutiDic;
//}

//- (id)copyWithZone:(NSZone *)zone
//{
//    TargetModel *copy = [[[self class] allocWithZone:zone] init];
//    copy.target_price = [self.target_price copy];
//    copy.target_time  = [self.target_time copy];
//    copy.target_num = [self.target_num copy];
//    copy.target_contacts  = [self.target_contacts copy];
//    copy.percent      = self.percent;
//    return copy;
//}



@end





