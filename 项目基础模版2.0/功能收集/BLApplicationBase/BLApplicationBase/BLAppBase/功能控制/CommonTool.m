//
//  CommonTool.m
//  HouseDream
//
//  Created by yinxl on 13-12-23.
//  Copyright (c) 2013年 Shih Kingdom. All rights reserved.
//

#import "CommonTool.h"
#import <objc/runtime.h>

@implementation CommonTool

#pragma mark- 字符串处理

+(NSString *)UUID{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result ;
    
}

+ (NSString *)getRandomStringForLength:(NSInteger)length
{
    if (length <= 0)
    {
        return nil;
    }
    
    char data[length];
    
    for (int x = 0;x < length; )
    {
        int i = arc4random_uniform(3);
        if (i%3 == 0) {
            data[x++] = (char)('A' + (arc4random_uniform(26)));
        }
        else if (i%3 == 1)
        {
            data[x++] = (char)('a' + (arc4random_uniform(26)));
        }
        else
        {
            data[x++] = (char)('0' + (arc4random_uniform(10)));
        }
        
    }
    
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

+ (BOOL) stringIsNull:(NSString *)string {
    if ([string isKindOfClass:[NSNumber class]]) {
        return NO;
    }else{
        
        if (string == nil || string == NULL) {
            return YES;
        }
        if ([string isKindOfClass:[NSNull class]]) {
            return YES;
        }
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
        
    }
    return NO;
}

+ (BOOL)isStringA:(NSString*)stringa contain:(NSString*)stringb;
{
    if( [[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
    {
        return [stringa containsString:stringb];
    }
    
    
    if(stringb.length>0)
    {
        return [stringa rangeOfString:stringb].length>=stringb.length;
    }
    
    return NO;
}

/** 连接字符串 [a,b,c] -  返回 a-b-c*/
+(NSString *)combineStrings:(NSArray*)array_strings withSep:(NSString*)sep;
{
    NSString * result = @"";
 
    for ( int i = 0 ; i < [array_strings count] ; i ++ )
    {
        NSString * string_one = [array_strings objectAtIndexSafe:i];
        
        result = [result stringByAppendingString:string_one];
        
        if(i != [array_strings count]-1)
        {
            if( sep)
            {
                result = [result stringByAppendingString:sep];
            }
        }
    }
    
    
    
    
    return  result;
}

+(BOOL)isEmailValid:(NSString *)email{
    BOOL valid = NO;
    
    if (email) {
        // 电子邮箱正则表达式
        //        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSString *emailRegex = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
        
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        valid = [emailPredicate evaluateWithObject:email];
        
    }
    
    return valid;
}

/** 正确的电话号码0-9+*#*/
+ (BOOL)isValidatePhoneNumber:(NSString*)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+*#"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+ (BOOL)isvalidateNumber:(NSString*)number {
    
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

/** 将内容按顺序\n分行*/
+(NSString*)stringContentWithLineArray:(NSArray<NSString*>*)array
{
    NSMutableString * muti_string = [NSMutableString string];
    for ( int i = 0 ;  i  < [array count] ; i ++)
    {
        NSString * content = [array objectAtIndexSafe:i];
        if(i == 0)
        {//起始
            [muti_string appendString:content];
        }
        else
        {//非起始
            [muti_string appendString:[NSString stringWithFormat:@"\n%@",content]];
        }
        
    }
    return muti_string;
}

/** 位数处理  (8,2)  08 */
+ (NSString*)stringWidthForNumber:(NSInteger)number width:(NSInteger)width
{
    NSString * string_number = [NSString stringWithFormat:@"%ld",(long)number];
    
    NSInteger countNumber = string_number.length;
    
    if(countNumber < width)
    {
        for ( int i = 0 ; i < (width - countNumber) ; i ++)
        {
            string_number = [NSString stringWithFormat:@"0%@",string_number];
            
        }
    }
    
    return string_number;
    
}

#pragma mark- 时间处理

/** 获取时区*/
+(NSInteger)getTimeZone
{
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    //      NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    NSInteger timeZone = time/(3600);
    
    
    return timeZone;
}

/** 当前时间戳*/
+(NSString *)presentTimeStamp
{
    NSDate * datenow =[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([localeDate timeIntervalSince1970]*1000)];
    
    return timeSp;
}

+(NSDate*)currentDate
{
    NSDate * datenow = [NSDate date];
    //    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    //    NSDate * localeDate = [datenow  dateByAddingTimeInterval: interval];
    
    return datenow;
}

+(NSInteger)currentday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitDay ;
    NSDateComponents *comps=[calendar components:unitFlags fromDate:[self currentDate]];
    
    NSInteger day=[comps day];
    return day;
}


/** 当前的月*/
+ (NSInteger)currentMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitMonth  ;
    NSDateComponents *comps=[calendar components:unitFlags fromDate:[self currentDate]];
    
    NSInteger month = [comps month];
    return month;
}

/** 当前的年*/
+ (NSInteger)currentYear
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear  ;
    NSDateComponents *comps=[calendar components:unitFlags fromDate:[self currentDate]];
    
    NSInteger year = [comps year];
    return year;
}

/** 当前的小时*/
+ (NSInteger)currentHour
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitHour ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[self currentDate]];
    
    NSInteger hour = [comps hour];
    return hour;
}

/** 当前的分*/
+ (NSInteger)currentMinute
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitMinute ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[self currentDate]];
    
    NSInteger minute = [comps minute];
    return minute;
}

/** 获取日期 2016-09-06 03:06 获取 2016-09-06*/
+(NSString*)getDateStringInString:(NSString * )string_time
{
    NSArray * array_time1 = [string_time componentsSeparatedByString:@" "];
    NSString * hourStirng_time1 = [array_time1 objectAtIndexSafe:0];
    
    return hourStirng_time1;
}

/** 获取时间 2016-09-06  获取 03:06*/
+(NSString*)getTimeStringInString:(NSString * )string_time
{
    NSArray * array_time1 = [string_time componentsSeparatedByString:@" "];
    NSString * hourStirng_time1 = [array_time1 objectAtIndexSafe:1];
    
    return hourStirng_time1;
}

/** 获取年份 2016-06, 2016-06-01, 2016-06-01 12:33 获取2016*/
+(NSInteger)getYearInDateString:(NSString *)string_date
{
  
    
    NSArray * array_day  = [[self getDateStringInString:string_date] componentsSeparatedByString:@"-"];
    
    NSInteger year = [[array_day objectAtIndexSafe:0] integerValue];
    
    return year;
}


/** 获取月份 2016-06, 2016-06-01, 2016-06-01 12:33 获取6*/
+(NSInteger)getMonthInDateString:(NSString *)string_date
{
    NSArray * array_day  = [[self getDateStringInString:string_date] componentsSeparatedByString:@"-"];
    
    NSInteger month = [[array_day objectAtIndexSafe:1] integerValue];
    
    return month;
}

/** 获取日期 2016-06, 2016-06-01, 2016-06-01 12:33 获取1*/
+(NSInteger)getDayInDateString:(NSString *)string_date
{
    NSArray * array_day  = [[self getDateStringInString:string_date] componentsSeparatedByString:@"-"];
    
    NSInteger day = [[array_day objectAtIndexSafe:2] integerValue];
    
    return day;
    
}

/** 获取时间 2016-06, 2016-06-01, 2016-06-01 12:33 获取12*/
+(NSInteger)getHourInDateString:(NSString *)string_date
{
    
    NSArray * array_day  = [[self getTimeStringInString:string_date] componentsSeparatedByString:@":"];
    
    NSInteger hour = [[array_day objectAtIndexSafe:0] integerValue];
    
    return hour;
}

/** 获取分钟 2016-06, 2016-06-01, 2016-06-01 12:33 获取33*/
+(NSInteger)getMinuteInDateString:(NSString *)string_date
{
    NSArray * array_day  = [[self getTimeStringInString:string_date] componentsSeparatedByString:@":"];
    
    NSInteger minute = [[array_day objectAtIndexSafe:1] integerValue];
    
    return minute;
    
}

/** 获取当前的月份字段 例如：2016-06-03*/
+(NSString*)getCurrentDateString
{
    NSString * resutlString = nil;
    
    
    resutlString = [self getDateStringForDate:[self currentDate]];
    
    return resutlString;
}

/**  2016-08-09*/
+(NSString *)getDateStringForDate:(NSDate* )date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger year  = [comps year];
    NSInteger month = [comps month];
    NSInteger day   = [comps day];
    
    NSString * string_year   = [NSString stringWithFormat:@"%ld",(long)year];
    NSString * string_month  = [self stringWidthForNumber:month width:2] ;
    NSString * string_day    = [self stringWidthForNumber:day width:2] ;
    
    
    
    
    NSString * dateString = [NSString stringWithFormat:@"%@-%@-%@",string_year,string_month,string_day];
    
    if(year <= 0)
    {
        dateString = [NSString stringWithFormat:@"%@-%@",string_month,string_day];
    }
    
    return dateString;
    
}

/** 获取年月日显示字符串 2016-08-11 addDay：增加的日期*/
+ (NSString *)getShowStringForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day addDay:(NSInteger)addday
{
    NSInteger year_final = year;
    NSInteger month_final = month ;
    NSInteger day_final   = day + addday;
    
    /** 当前月有多少天*/
    NSInteger count_day_month = [self CountDayForYear:year month:month];
    
    
    
    while (day_final <= 0 || day_final > count_day_month) {
        
        ///纠正月 日
        if(day_final > count_day_month)
        {
            day_final = day_final - count_day_month;
            month_final ++;
        }
        
        if(day_final <= 0)
        {
            month_final --;
            
            while(month_final <=0 )
            {
                month_final += 12;
                year_final -- ;
            }
            count_day_month = [self CountDayForYear:year month:month];
            
            day_final += count_day_month;
            
        }
        
        // 纠正年月
        while(month_final <=0 )
        {
            month_final += 12;
            year_final -- ;
        }
        while(month_final >12 )
        {
            month_final -= 12;
            year_final ++ ;
        }
        
        
        count_day_month = [self CountDayForYear:year month:month];
        
    }
    
    
    
    
    NSString * finalString =  [NSString stringWithFormat:@"%ld-%@-%@",(long)year_final,[CommonTool stringWidthForNumber:month_final width:2],[CommonTool stringWidthForNumber:day_final width:2]];
    
    return finalString;
}

/** 计算某年某月有几天*/
+ (NSInteger)CountDayForYear:(NSInteger)year month:(NSInteger)month
{
    //    if(year<=0)
    //        return 31;
    switch(month)
    {
            
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:
            if((year%4!=0)||((year%100==0)&&(year%400!=0)))
                return 28;
            else
                return 29;
        default:
            return 0;
    };
    
}



/** 是否是今天  */
+(BOOL)isTimeStringToday:(NSString * )string_time
{
    NSString * hourStirng_time1 = [self getDateStringInString:string_time];
    
    NSInteger year = [self getYearInDateString:hourStirng_time1];
    NSInteger month = [self getMonthInDateString:hourStirng_time1];
    NSInteger day = [self getDayInDateString:hourStirng_time1];
    
    NSInteger currentYear = [self currentYear];
    NSInteger currentMonth = [self currentMonth];
    NSInteger currentDay = [self currentday];
    
    if(year == currentYear && month == currentMonth && day == currentDay)
    {
        return YES;
    }
    
    return NO;
}

#pragma mark- array

/** 数组添加不重复内容 @return yes 添加成功 no 添加失败，有重复*/
+(BOOL)array:(NSMutableArray*)muti_array AddNoSameContent:(NSString*)content
{
    if([self isArray:muti_array contain:content])
    {
        return NO;
    }
    else
    {
        [muti_array addObjectSafe:content];
        return YES;
    }
}


/** 数组是否有内容 @return yes 重复 no 无*/
+(BOOL)isArray:(NSArray*)muti_array contain:(NSString*)content
{
    for ( NSString * string_content in muti_array )
    {
        if([string_content isKindOfClass:[NSString class]])
        {
            if([string_content isEqualToString:content])
            {
                return YES;
            }
        }
    }
    return NO;
}

/** 标号字符串 1、2、*/
+(NSArray*)arrayWithXuLieContent:(NSArray<NSString*>*)array
{
    NSMutableArray * array_muti = [NSMutableArray array];
    
    for ( int i = 0 ; i < [array count] ; i ++ )
    {
        NSString * content = [array objectAtIndexSafe:i];
        
        content = [NSString stringWithFormat:@"%d、%@",i+1,content];
        
        [array_muti addObjectSafe:content];
    }
    return array_muti;
    
}

/** 在数组中的位置 block 返回yes 时*/
+(NSInteger)indexInArray:(NSArray*)array  compair:(BOOL(^)(id content , NSInteger index))block
{
    NSInteger foundIndex = NSNotFound;
    if([array isKindOfClass:[NSArray class]])
    {
        for ( NSInteger i = 0 ; i < [array count] ; i ++)
        {
            NSString * content = [array objectAtIndexSafe:i];
            if(block(content,i))
            {
                foundIndex = i;
                break;
            }
        }
    }
    return foundIndex;
    
}

#pragma mark- url处理
/** 转换对象为https*/
+(id)makeHttpsSafeForContent:(id)content
{
    if(!httpsIsOpen){
        return content;
    }
    
    return  [self replaceText:@"http:" withText:@"https:" inContext:content];
}

/** 判断网址是否需要添加自认证*/
+(BOOL)isUrlNeedAddSelfCertificate:(id)url
{
    
    if(httpsIsOpen)
    {
        if([url isKindOfClass:[NSString class]])
        {
            return [self isUrlstring:url HeaderContainWords:ZiRenZhengHosts];
        }
        
        if([url isKindOfClass:[NSURL class]])
        {
            return [self isUrl:url HeaderContainWords:ZiRenZhengHosts];
        }
    }
    
    
    
    return NO;
}






/** 判断url是否包含域名*/
+(BOOL)isUrlstring:(NSString*)string_url HeaderContainWords:(NSArray*)array_word;
{
    BOOL contain = NO;
    
    NSURL * url = [NSURL URLWithStringSafe:string_url];
    
    NSString * string_host = url.host;
    
    for ( NSString * value in array_word )
    {
        if([string_host containsString:value])
        {
            contain = YES;
            break;
        }
    }
    
    return contain;
}

/** 判断url是否包含域名*/
+(BOOL)isUrl:(NSURL*)url HeaderContainWords:(NSArray*)array_word
{
    BOOL contain = NO;
    
    
    NSString * string_host = url.host;
    
    for ( NSString * value in array_word )
    {
        if([string_host containsString:value])
        {
            contain = YES;
            break;
        }
    }
    
    return contain;
}


/** 替换容器内的字符串*/
+(id)replaceText:(NSString*)text_move withText:(NSString*)text_replace inContext:(id)content
{
    //字符串
    if([content isKindOfClass:[NSString class]])
    {
        content = [content stringByReplacingOccurrencesOfString:text_move withString:text_replace];
    }
    //字典
    if([content isKindOfClass:[NSDictionary class]])
    {
        content = [self replaceText:text_move withText:text_replace inDiction:content];
    }
    //数组
    if([content isKindOfClass:[NSArray class]])
    {
        content = [self replaceText:text_move withText:text_replace inArray:content];
    }
    
    return content;
}

/** 替换字典容器内的字符串*/
+(NSMutableDictionary * )replaceText:(NSString*)text_move withText:(NSString*)text_replace inDiction:(NSDictionary*)content
{
    NSMutableDictionary * dicBefore = (NSMutableDictionary*)content;
    
    if(![dicBefore isKindOfClass:[NSDictionary class]])
    {
        return [self replaceText:text_move withText:text_replace inContext:dicBefore];
    }
    
    if(![dicBefore isKindOfClass:[NSMutableDictionary class]])
    {
        dicBefore = [dicBefore mutableCopy];
    }
    
    NSArray * array_key = dicBefore.allKeys;
    for ( NSInteger i = 0 ; i < [array_key count] ; i ++)
    {
        NSString * key = [array_key objectAtIndexSafe:i];
        id content = [dicBefore objectForKey:key];
        
        content = [self replaceText:text_move withText:text_replace inContext:content];
        
        [dicBefore setObjectSafe:content forKey:key];
        
    }
    
    return dicBefore;
    
}
/** 替换array容器内的字符串*/
+(NSMutableArray * )replaceText:(NSString*)text_move withText:(NSString*)text_replace inArray:(NSArray*)array
{
    NSMutableArray * arrayBefore = (NSMutableArray*)array;
    
    if(![arrayBefore isKindOfClass:[NSArray class]])
    {
        return [self replaceText:text_move withText:text_replace inContext:arrayBefore];
    }
    
    if(![arrayBefore isKindOfClass:[NSMutableArray class]])
    {
        arrayBefore = [arrayBefore mutableCopy];
    }
    
    
    for ( NSInteger i = 0 ; i < [arrayBefore count] ; i ++)
    {
        
        id content = [arrayBefore objectAtIndexSafe:i];
        
        content = [self replaceText:text_move withText:text_replace inContext:content];
        
        [arrayBefore replaceObjectAtIndex:i withObject:content];
        
    }
    
    return arrayBefore;
    
}

#pragma mark- 其他处理
// 比较obj1与Obj2是否相同，在propertyMap中存放两个对象要对比的属性的映射关系,key-obj1的属性名，value-对应要比较的obj2的属性名
+ (BOOL)checkIsEqualObj:(id)obj1 andObj:(id)obj2 byMap:(NSDictionary *)propertyMap
{
    BOOL isEqual = YES;
    NSArray *arrayKeys = [propertyMap allKeys];
    
    for (NSString *obj1Property in arrayKeys)
    {
        NSString *obj2Property = [propertyMap objectForKey:obj1Property];
        Ivar iVar1 = class_getInstanceVariable([obj1 class], [obj1Property UTF8String]);
        Ivar iVar2 = class_getInstanceVariable([obj2 class], [obj2Property UTF8String]);
        id propertyValue1 = object_getIvar(obj1, iVar1);
        id propertyValue2 = object_getIvar(obj2, iVar2);
        
        if (![propertyValue1 isEqual:propertyValue2])
        {
            return NO;
        }
    }
    
    return isEqual;
}

/** 将网页传来的所有类型的数据转换成字典*/
+(NSDictionary*)allTypeToDic:(id)json
{
    NSDictionary * temDic = nil;
    if([json isKindOfClass:[NSDictionary class]])
    {
        temDic = json;
    }
    
    if([json isKindOfClass:[NSString class]] && [json length]>0)
    {
        temDic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    }
    
    if([json isKindOfClass:[NSData class]] && [json length]>0)
    {
        temDic = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    }
    
    if([temDic isKindOfClass:[NSDictionary class]])
    {
        return temDic;
    }
    else
    {
        return nil;
    }
    
}

/** 将传来的所有类型转换成jason string*/
+(NSString*)allTypeToString:(id)object
{
    if(object && [NSJSONSerialization isValidJSONObject:object])
    {
        NSData *jasonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
        if(jasonData)
        {
            NSString * jasonString = [[NSString alloc] initWithData:jasonData encoding:NSUTF8StringEncoding];
            
            return jasonString;
        }
    }
    
    return nil;
}



@end
