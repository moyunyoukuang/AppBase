//
//  Tool.h
//  HouseDream
//
//  Created by yinxl on 13-12-23.
//  Copyright (c) 2013年 Shih Kingdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 工具核心 用于处理数据信息*/
@interface CommonTool : NSObject

#pragma mark- 字符串处理

/** 得到设备id*/
+ (NSString *)UUID;

/** 获取特定长度的随机字符串*/
+ (NSString *)getRandomStringForLength:(NSInteger)length;

/** string 是空字符串*/
+ (BOOL)stringIsNull:(NSString *)string;

/** A是否包含B*/
+ (BOOL)isStringA:(NSString*)stringa contain:(NSString*)stringb;

/** 连接字符串 [a,b,c] -  返回 a-b-c*/
+(NSString *)combineStrings:(NSArray*)array_strings withSep:(NSString*)sep;

/** 匹配邮箱是否符合格式*/
+ (BOOL)isEmailValid:(NSString *)email;

/** 是否输入为正确电话相关号码0-9+*#*/
+ (BOOL)isValidatePhoneNumber:(NSString*)number;

/** 是否全为数值0-9*/
+ (BOOL)isvalidateNumber:(NSString*)number;

/** 将内容按顺序\n分行*/
+(NSString*)stringContentWithLineArray:(NSArray<NSString*>*)array;

/** 位数处理  (8,2)  08  不足位补零*/
+ (NSString*)stringWidthForNumber:(NSInteger)number width:(NSInteger)width;

#pragma mark- 时间处理/数值处理
///标准时间表示方式  1989-09-05 23:45
/** 获取时区*/
+(NSInteger)getTimeZone;

/** 当前时间戳*/
+(NSString *)presentTimeStamp;

/** 当前时间*/
+(NSDate*)currentDate;

/** 当前的日期*/
+ (NSInteger)currentday;

/** 当前的月*/
+ (NSInteger)currentMonth;

/** 当前的年*/
+ (NSInteger)currentYear;

/** 当前的小时*/
+ (NSInteger)currentHour;

/** 当前的分*/
+ (NSInteger)currentMinute;

/** 获取日期 2016-09-06 03:06 获取 2016-09-06*/
+(NSString*)getDateStringInString:(NSString * )string_time;

/** 获取时间 2016-09-06 03:06 获取 03:06*/
+(NSString*)getTimeStringInString:(NSString * )string_time;

/** 获取年份 2016-06, 2016-06-01, 2016-06-01 12:33 获取2016*/
+(NSInteger)getYearInDateString:(NSString *)string_date;

/** 获取月份 2016-06, 2016-06-01, 2016-06-01 12:33 获取6*/
+(NSInteger)getMonthInDateString:(NSString *)string_date;

/** 获取日期 2016-06, 2016-06-01, 2016-06-01 12:33 获取1*/
+(NSInteger)getDayInDateString:(NSString *)string_date;

/** 获取时间 2016-06, 2016-06-01, 2016-06-01 12:33 获取12*/
+(NSInteger)getHourInDateString:(NSString *)string_date;

/** 获取分钟 2016-06, 2016-06-01, 2016-06-01 12:33 获取33*/
+(NSInteger)getMinuteInDateString:(NSString *)string_date;

/** 获取当前的日期字段 例如：2016-06-03*/
+(NSString*)getCurrentDateString;

/**  2016-08-09*/
+(NSString *)getDateStringForDate:(NSDate* )date;

/** 获取年月日显示字符串 2016-08-11 addDay：增加的日期 */
+ (NSString *)getShowStringForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day addDay:(NSInteger)addday;

/** 计算某年某月有几天*/
+ (NSInteger)CountDayForYear:(NSInteger)year month:(NSInteger)month;

/** 是否是今天  */
+(BOOL)isTimeStringToday:(NSString * ) string_time;


#pragma mark- array

/** 数组添加不重复内容 @return yes 添加成功 no 添加失败，有重复*/
+(BOOL)array:(NSMutableArray*)muti_array AddNoSameContent:(NSString*)content;

/** 数组是否有内容 @return yes 重复 no 无*/
+(BOOL)isArray:(NSArray*)muti_array contain:(NSString*)content;

/** 标号字符串 1、2、*/
+(NSArray*)arrayWithXuLieContent:(NSArray<NSString*>*)array;

/** 在数组中的位置 block 返回yes 时*/
+(NSInteger)indexInArray:(NSArray*)array  compair:(BOOL(^)(id content , NSInteger index))block;

#pragma mark- url处理

/** 转换对象为https*/
+(id)makeHttpsSafeForContent:(id)content;

/** 判断网址是否需要添加自认证*/
+(BOOL)isUrlNeedAddSelfCertificate:(id)url;

/** 判断url是否包含域名*/
+(BOOL)isUrlstring:(NSString*)string_url HeaderContainWords:(NSArray*)array_word;

/** 判断url是否包含域名*/
+(BOOL)isUrl:(NSURL*)url HeaderContainWords:(NSArray*)array_word;


#pragma mark- 其他处理

/** 检查两个对象是否相同 
 @param propertyMap 检查属性
 */
+ (BOOL)checkIsEqualObj:(id)obj1 andObj:(id)obj2 byMap:(NSDictionary *)propertyMap;

/** 将传来的所有类型的数据转换成字典*/
+(NSDictionary*)allTypeToDic:(id)jason;

/** 将传来的所有类型转换成jason string*/
+(NSString*)allTypeToString:(id)object;

@end
