//
//  BLFunction+Extension.m
//  BLFunction
//
//  Created by camore on 2017/7/18.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLFunction+Extension.h"
//拼音获取
//通讯录
#import <AddressBook/AddressBook.h>
#import "pinyin.h"
#import "CommonTool.h"
#import "PPGetAddressBook.h"
@implementation CharAttributeModel

-(NSString *)description
{
    NSString * description = [NSString stringWithFormat:@"originChar = %@,type = %u,replaceString = %@,fullPinYin = %@",self.originChar,self.type,self.replaceString,self.fullPinYin];
    
    return description;
    
}

@end

@implementation BLFunction (Extension)

#pragma mark- 通讯录

/** 获取通讯录里所有人的信息*/
+(NSArray*)getAllPeoPleInTongXunLv
{
    
    ABAddressBookRef tmpAddressBook = nil;
    __block BOOL accessGranted = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
            accessGranted = greanted;
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //                dispatch_release(sema);
        
    }
    else
    {
        accessGranted=YES;
        tmpAddressBook = ABAddressBookCreate();
    }
    //取得本地所有联系人记录
    
    
    if (tmpAddressBook==nil) {
        return [NSMutableArray array];
    };
    NSArray* tmpPeoples = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    NSMutableArray* allpeoplearray=[NSMutableArray array];
    for(id tmpPerson in tmpPeoples)
    {
        LianXiRenModel * lianXiRen = [[LianXiRenModel alloc] init];
        
        
        lianXiRen.contacts_sex   =   @"1";
        
        {
            /////姓名
            NSString* peoplename = @"";
            
            //获取的联系人单一属性:Last name
            NSString* tmpLastName = (__bridge_transfer NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
            
            //获取的联系人单一属性:First name
            NSString* tmpFirstName = (__bridge_transfer NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
            
            //获取的联系人单一属性:middleName
            NSString * middleName = (__bridge_transfer NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonMiddleNameProperty);
            
            //            NSString * zhongYingName;//中美名称不同
            
            if([[[AppManager shareManager] getUserInfoForKey:UserLanguageSettingKey]isEqualToString:@"2"])
            {//名姓
                
                if(tmpFirstName.length>0)
                {
                    peoplename = [peoplename stringByAppendingString:tmpFirstName];
                }
                if(middleName.length>0)
                {
                    peoplename = [peoplename stringByAppendingString:middleName];
                }
                if(tmpLastName.length>0)
                {
                    peoplename = [peoplename stringByAppendingString:tmpLastName];
                }
            }
            else
            {//姓名
                if(tmpLastName.length>0)
                {
                    peoplename = [peoplename stringByAppendingString:tmpLastName];
                }
                if(tmpFirstName.length>0)
                {
                    peoplename = [peoplename stringByAppendingString:tmpFirstName];
                }
                if(middleName.length>0)
                {
                    peoplename = [peoplename stringByAppendingString:middleName];
                }
            }
            
            
            
            if(peoplename.length==0)
            {
                peoplename = @"未知";
            }
            lianXiRen.user_name      =   peoplename;
        }
        
        {
            ////电话
            //获取的联系人单一属性:Generic phone number
            NSMutableArray* phoneNumbers = [NSMutableArray array];
            
            
            ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
            
            for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
            {
                
                NSString* tmpPhoneIndex = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
                tmpPhoneIndex = [tmpPhoneIndex stringByReplacingOccurrencesOfString:@"-" withString:@""];
                tmpPhoneIndex = [tmpPhoneIndex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                
                if([tmpPhoneIndex length]>0)
                {
                    [phoneNumbers addObjectSafe:tmpPhoneIndex];
                }
            }
            
            CFRelease(tmpPhones);
            lianXiRen.user_phones    =   phoneNumbers;
        }
        
        
        {///头像
            if(ABPersonHasImageData((__bridge ABRecordRef)tmpPerson))
            {
                NSData *photoData = CFBridgingRelease(ABPersonCopyImageData((__bridge ABRecordRef)tmpPerson));
                
                lianXiRen.user_head_image = [UIImage imageWithData:photoData];
            }
            
        }
        
        {//公司
            
            //读取organization公司
            NSString *organization = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)tmpPerson, kABPersonOrganizationProperty);
            NSMutableArray * mutiArray  = [NSMutableArray array];
            [mutiArray addObjectSafe:organization];
            lianXiRen.user_company = mutiArray;
            
        }
        
        {//地址
            
            
            //读取地址多值
            ABMultiValueRef address = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonAddressProperty);
            int count = (int)ABMultiValueGetCount(address);
            NSMutableArray * array_address = [NSMutableArray array];
            for(int j = 0; j < count; j++)
            {
                //                //获取地址Label
                //                NSString* type = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
                ////                //获取該label下的地址6属性
                NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
                NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
                NSString* sheng  = [personaddress valueForKey:(NSString*)kABPersonAddressStateKey];
                NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
                NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
                NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
                //                NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
                
                NSString *adress = @"";
                NSMutableArray * mutiArray_address = [NSMutableArray array];
                if(country)
                {
                    [mutiArray_address addObjectSafe:[NSString stringWithFormat:@"国家:%@",country]];
                }
                if(sheng)
                {
                    [mutiArray_address addObjectSafe:[NSString stringWithFormat:@"省:%@",sheng]];
                }
                if(city)
                {
                    [mutiArray_address addObjectSafe:[NSString stringWithFormat:@"市:%@",city]];
                }
                if(street)
                {
                    [mutiArray_address addObjectSafe:[NSString stringWithFormat:@"街道:%@",street]];
                }
                if(zip)
                {
                    [mutiArray_address addObjectSafe:[NSString stringWithFormat:@"邮编:%@",zip]];
                }
                
                //地址字符串，可以按需求格式化
                adress = [CommonTool stringContentWithLineArray:mutiArray_address];
                
                [array_address addObjectSafe:adress];
            }
            
            lianXiRen.user_address = array_address;
        }
        
        {//日期
            
            //获取dates多值
            ABMultiValueRef dates = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonDateProperty);
            int datescount = (int)ABMultiValueGetCount(dates);
            
            NSMutableArray * muti_array = [NSMutableArray array];
            for (int y = 0; y < datescount; y++)
            {
                //获取dates Label
                NSString* datesLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
                //获取dates值
                NSString*  datesContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(dates, y) ;
                
                if([datesContent isKindOfClass:[NSDate class]])
                {
                    datesContent = [CommonTool getDateStringForDate:(NSDate*)datesContent];
                    
                }
                LianXiRenImportantDateModel * model = [[LianXiRenImportantDateModel alloc] init];
                model.string_dateType = datesLabel;
                model.string_dateContent = datesContent;
                
                [muti_array addObjectSafe:model];
            }
            
            lianXiRen.user_times = muti_array;
        }
        
        [allpeoplearray addObject:lianXiRen];
        
    }
    
    //释放内存
    
    CFRelease(tmpAddressBook);
    return allpeoplearray;
}



/** 获取所有联系人 异步*/
-(void)getAllLianXiRen:(void(^)(NSArray         *   lianXiRen_paiXu_title_array,NSMutableArray<NSArray<LianXiRenModel*>*> * array_contacts))callbackBlock
{
    
    /** contacts name list*/
    __block NSArray         *   lianXiRen_paiXu_title_array;
    /** contacts list*/
    __block NSMutableArray<NSArray<LianXiRenModel*>*> *   array_contacts;
    //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        //装着所有联系人的字典
        
        
        //model 转换
        
        //联系人分组按拼音分组的Key值
        lianXiRen_paiXu_title_array = nameKeys;
        
        NSMutableArray * array_contacts_catch = [NSMutableArray array];
        for (int i = 0 ; i < [lianXiRen_paiXu_title_array count] ; i ++ )
        {
            NSString * key = [lianXiRen_paiXu_title_array objectAtIndex:i];
            
            NSArray * array_list = [addressBookDict objectForKey:key];
            
            NSMutableArray * array_contacts_sep = [NSMutableArray array];
            for ( int j = 0 ; j < [array_list count] ; j ++ )
            {
                PPPersonModel * model = [array_list objectAtIndexSafe:j];
                LianXiRenModel * model_transe = [[LianXiRenModel alloc] init];
                model_transe.user_name = model.name;
                model_transe.user_phones = model.mobileArray;
                model_transe.user_head_image = model.headerImage;
                
                [array_contacts_sep addObjectSafe:model_transe];
            }
            [array_contacts_catch addObjectSafe:array_contacts_sep];
        }
        array_contacts = array_contacts_catch;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callbackBlock(lianXiRen_paiXu_title_array,array_contacts);
        });
        
        
    } authorizationFailure:^{
        
    }];
    
    
}
#pragma mark- 获取拼音
/** 获取字符串中的拼音 首字母*/
+(NSString *)getPinYinFromString:(NSString*)string
{
    /** 返回拼音*/
    NSString* pinYinResult = @"#";
    //去除空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //判断是否为字母
    NSString    *regex = @"[A-Za-z]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if(string.length > 0)
    {
        /** 每个字符的拼音首字母*/
        NSMutableString * charStrings = [[NSMutableString alloc] init];
        for(int i = 0 ; i < string.length ; i ++)
        {
            /** 一个字符*/
            NSString * charString = [string substringWithRange:NSMakeRange(i, 1)];
            
            if([CommonTool isvalidateNumber:charString])
            {//如果是数字
                [charStrings appendString:[charString uppercaseString]];
                continue;
            }
            
            if([predicate evaluateWithObject:charString])
            {
                //如果是字母
                [charStrings appendString:[charString uppercaseString]];
                continue;
            }
            
            {
                //如果不是字母，则去获取
                unsigned short  d = [string characterAtIndex:i];
                char pinyin     = pinyinFirstLetter(d);
                [charStrings appendString:[[NSString stringWithFormat:@"%c",pinyin] uppercaseString]];
            }
        }
        pinYinResult = charStrings;
    }
    
    return pinYinResult;
}

/** 单个字符的属性*/
+(CharAttributeModel*)attributeForCharString:(NSString*)string
{
    CharAttributeModel * model_attribute = [[CharAttributeModel alloc] init];
    model_attribute.originChar = string;
    
    //去除空格
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(string.length > 0)
    {
        for(int i = 0 ; i < 1 ; i ++)
        {
            /** 一个字符*/
            NSString * charString = [string substringWithRange:NSMakeRange(0, 1)];
            
            if([CommonTool isvalidateNumber:charString])
            {//如果是数字
                
                model_attribute.type = CharAttributeTypeNumber;
                model_attribute.replaceString = charString;
                model_attribute.fullPinYin = charString;
                continue;
            }
            
            //判断是否为字母
            NSString    *regex = @"[A-Za-z]+";
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            if([predicate evaluateWithObject:charString])
            {
                //如果是字母
                
                model_attribute.type = CharAttributeTypeEnglish;
                model_attribute.replaceString = [charString uppercaseString];
                model_attribute.fullPinYin = [charString uppercaseString];
                continue;
            }
            
            {
                //如果不是字母，则去获取
                unsigned short  d = [string characterAtIndex:i];
                char pinyin     = pinyinFirstLetter(d);
                NSString * replaceString = [NSString stringWithFormat:@"%c",pinyin];
                if(![replaceString isEqualToString:@"#" ])
                {
                    // 汉字
                    model_attribute.type = CharAttributeTypeChinese;
                    model_attribute.replaceString = [[NSString stringWithFormat:@"%c",pinyin] uppercaseString];
                    ///去不音标
                    NSMutableString *pinyin = [charString mutableCopy];
                    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
                    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
                    
                    model_attribute.fullPinYin = [pinyin uppercaseString];
                    
                }
                else
                {
                    // 特殊字符
                    model_attribute.type = CharAttributeTypeUnkonwn;
                    model_attribute.replaceString = @"#";
                    model_attribute.fullPinYin = @"#";
                }
            }
        }
        
    }
    else
    {
        // 特殊字符
        model_attribute.type = CharAttributeTypeUnkonwn;
        model_attribute.replaceString = @"#";
        model_attribute.fullPinYin = @"#";
    }
    
    //    //将NSString装换成NSMutableString
    //    NSMutableString *pinyin = [chinese mutableCopy];
    //
    //    //将汉字转换为拼音(带音标)
    //    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //    NSLog(@"%@", pinyin);
    //
    //    //去掉拼音的音标
    //    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //    NSLog(@"%@", pinyin);
    //    kCFStringTransformToLatin
    //    kCFStringTransformMandarinLatin
    
    
    //    kCFStringTransformStripDiacritics ／／去掉音标
    return model_attribute;
}


/** 获取字符串中的拼音 没有为# 字母为大写字母 数字为数字*/
+(NSMutableArray<CharAttributeModel*> *)getAttributeFromString:(NSString*)string
{
    NSMutableArray * array_result = [NSMutableArray array];
    
    for ( int i = 0 ; i < [string length] ; i ++ )
    {
        /** 一个字符*/
        NSString * charString = [string substringWithRange:NSMakeRange(i, 1)];
        
        CharAttributeModel * model_arrtibute = [self attributeForCharString:charString];
        
        [array_result addObjectSafe:model_arrtibute];
    }
    
    return array_result;
}

/** 获取首字母*/
+(NSString*)getFirstCharFromeAttributeArray:(NSArray<CharAttributeModel*>*)array_attribute
{
    NSMutableString * string_muti = [NSMutableString string];
    for ( int i = 0 ; i < [array_attribute count] ; i ++ )
    {
        CharAttributeModel * model = [array_attribute objectAtIndexSafe:i];
        
        if(model.replaceString)
        {
            [string_muti appendString:model.replaceString];
        }
    }
    
    
    return string_muti;
}
/** 获取全部字母*/
+(NSString*)getFullCharFromeAttributeArray:(NSArray<CharAttributeModel*>*)array_attribute
{
    NSMutableString * string_muti = [NSMutableString string];
    for ( int i = 0 ; i < [array_attribute count] ; i ++ )
    {
        CharAttributeModel * model = [array_attribute objectAtIndexSafe:i];
        
        if(model.fullPinYin)
        {
            [string_muti appendString:model.fullPinYin];
        }
    }
    
    
    return string_muti;
}

/** 将 ABCDEF 转换为  222333*/
+(NSString*)changePinYinToNumber:(NSString*)string
{
    NSDictionary * dic = @{@"A":@"2",
                           @"B":@"2",
                           @"C":@"2",
                           @"D":@"3",
                           @"E":@"3",
                           @"F":@"3",
                           @"G":@"4",
                           @"H":@"4",
                           @"I":@"4",
                           @"J":@"5",
                           @"K":@"5",
                           @"L":@"5",
                           @"M":@"6",
                           @"N":@"6",
                           @"O":@"6",
                           @"P":@"7",
                           @"Q":@"7",
                           @"R":@"7",
                           @"S":@"7",
                           @"T":@"8",
                           @"U":@"8",
                           @"V":@"8",
                           @"W":@"9",
                           @"X":@"9",
                           @"Y":@"9",
                           @"Z":@"9",
                           };
    
    
    
    NSString* stringResult = @"";
    
    
    if(string.length > 0)
    {
        /** 每个字符的拼音首字母*/
        NSMutableString * charStrings = [[NSMutableString alloc] init];
        for(int i = 0 ; i < string.length ; i ++)
        {
            /** 一个字符*/
            NSString * charString = [string substringWithRange:NSMakeRange(i, 1)];
            
            NSString * string_replace = [dic objectForKey:charString];
            
            if(string_replace.length > 0 )
            {
                charString = string_replace;
            }
            [charStrings appendString:charString];
        }
        stringResult = charStrings;
    }
    
    
    
    return stringResult;
}


/** 用拼音进行排序 @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
 @param array   排序的内容
 @param key     如果array 中是字符串key没有作用 如果是对象，则为排序的key值
 @param return  排序出来的顺序 @[@{@"key":key,@"objects":[object]}] 数组－>字典->(key,objects)
 */
+(NSMutableArray *)paiXuWithPinYin:(NSArray*)array key:(NSString*)key
{
    /** 排序的结果*/
    NSMutableArray * jieGuoArray = [NSMutableArray array];
    
    /** 全部的object*/
    NSMutableArray * allList = [NSMutableArray array];
    
    for ( int i = 0 ; i < [array count] ; i ++ )
    {
        /** 排序的对比单位*/
        NSMutableDictionary * cellDic = [[NSMutableDictionary alloc] init];
        /** 对比的单位*/
        id conparaObject = [array objectAtIndexSafe:i];
        //对比的单位
        [cellDic setObjectSafe:conparaObject forKey:@"object"];
        
        if([conparaObject isKindOfClass:[NSString class]])
        {
            //如果是字符串
            //对比的拼音
            [cellDic setObjectSafe:[self getPinYinFromString:conparaObject ]forKey:@"conpaireString"];
        }
        else
        {
            if([conparaObject respondsToSelector:@selector(valueForKey:)] && [conparaObject valueForKey:key])
            {
                //如果是其他object
                //对比的拼音
                [cellDic setObjectSafe:[self getPinYinFromString:[conparaObject valueForKey:key] ]forKey:@"conpaireString"];
            }
            else
            {
                //对比的拼音
                [cellDic setObjectSafe:@"#" forKey:@"conpaireString"];
            }
        }
        [allList addObject:cellDic];
        
    }
    
    //按照拼音首字母对这些object进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"conpaireString" ascending:YES]];
    [allList sortUsingDescriptors:sortDescriptors];
    
    
    ///将这些排序后的object 按首字母进行归类
    
    NSMutableArray * keys = [NSMutableArray array];
    
    [jieGuoArray addObjectSafe:keys];
    for(int i = 0 ; i < [allList count]; i ++)
    {
        /** 被排序元素*/
        id object = [[allList objectAtIndexSafe:i] objectForKey:@"object"];
        /** 拼音 首字母*/
        NSString * key = [[[allList objectAtIndexSafe:i] objectForKey:@"conpaireString"] substringToIndex:1];
        
        /** 对应字母下的字符*/
        NSMutableArray * key_objects;
        
        /** 以key为标注的列表已经存在*/
        BOOL  existKey = NO;
        for(NSString * preKey in keys)
        {
            if([preKey isEqualToString:key])
            {
                existKey = YES;
                break;
            }
        }
        
        if(existKey)
        {
            key_objects = [jieGuoArray lastObject];
            
        }
        else
        {
            [keys addObjectSafe:key];
            key_objects = [NSMutableArray array];
            [jieGuoArray addObjectSafe:key_objects];
        }
        [key_objects addObjectSafe:object];
        
    }
    
    return jieGuoArray;
}

/** 用首字母排序
 @param array   排序的内容
 @param key     如果array 中是字符串key没有作用 如果是对象，则为排序的key值
 @param return  排序出来的顺序 @[[key] [object],[object],[object]] 第一个为排序的key array
 */
+(NSMutableArray *)paiXuWithFirstChar:(NSArray*)array key:(NSString*)key
{
    /** 排序的结果*/
    NSMutableArray * jieGuoArray = [NSMutableArray array];
    
    /** 全部的object*/
    NSMutableArray * allList = [NSMutableArray array];
    
    for ( int i = 0 ; i < [array count] ; i ++ )
    {
        /** 排序的对比单位*/
        NSMutableDictionary * cellDic = [[NSMutableDictionary alloc] init];
        /** 对比的单位*/
        id conparaObject = [array objectAtIndexSafe:i];
        //对比的单位
        [cellDic setObjectSafe:conparaObject forKey:@"object"];
        
        if([conparaObject isKindOfClass:[NSString class]])
        {
            //如果是字符串
            
            NSString * conpaiString = conparaObject;
            if(conpaiString.length > 0)
            {//首字符
                conpaiString = [conpaiString substringWithRange:NSMakeRange(0, 1)];
            }
            else
            {
                conpaiString = @"#";
            }
            
            [cellDic setObjectSafe:conpaiString forKey:@"conpaireString"];
            
            
            
        }
        else
        {
            if([conparaObject respondsToSelector:@selector(valueForKey:)] && [conparaObject valueForKey:key])
            {
                //如果是其他object
                NSString * conpaiString = [conparaObject valueForKey:key];
                if(conpaiString.length > 0)
                {//首字符
                    conpaiString = [conpaiString substringWithRange:NSMakeRange(0, 1)];
                }
                else
                {
                    conpaiString = @"#";
                }
                [cellDic setObjectSafe:conpaiString forKey:@"conpaireString"];
            }
            else
            {
                //对比的拼音
                [cellDic setObjectSafe:@"#" forKey:@"conpaireString"];
            }
        }
        [allList addObject:cellDic];
        
    }
    
    //按照拼音首字母对这些object进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"conpaireString" ascending:YES]];
    [allList sortUsingDescriptors:sortDescriptors];
    
    
    ///将这些排序后的object 按首字母进行归类
    
    NSMutableArray * keys = [NSMutableArray array];
    
    [jieGuoArray addObjectSafe:keys];
    for(int i = 0 ; i < [allList count]; i ++)
    {
        /** 被排序元素*/
        id object = [[allList objectAtIndexSafe:i] objectForKey:@"object"];
        /** 拼音 首字母*/
        NSString * key = [[[allList objectAtIndexSafe:i] objectForKey:@"conpaireString"] substringToIndex:1];
        
        /** 对应字母下的字符*/
        NSMutableArray * key_objects;
        
        /** 以key为标注的列表已经存在*/
        BOOL  existKey = NO;
        for(NSString * preKey in keys)
        {
            if([preKey isEqualToString:key])
            {
                existKey = YES;
                break;
            }
        }
        
        if(existKey)
        {
            key_objects = [jieGuoArray lastObject];
            
        }
        else
        {
            [keys addObjectSafe:key];
            key_objects = [NSMutableArray array];
            [jieGuoArray addObjectSafe:key_objects];
        }
        [key_objects addObjectSafe:object];
        
    }
    
    return jieGuoArray;
}

/** 以关键值重新排序*/
+(NSMutableArray *)paiXu:(NSArray*)array key:(NSString*)key
{
    /** 排序的结果*/
    NSMutableArray * jieGuoArray = [NSMutableArray array];
    
    /** 全部的object*/
    NSMutableArray * allList = [NSMutableArray array];
    
    for ( int i = 0 ; i < [array count] ; i ++ )
    {
        /** 排序的对比单位*/
        NSMutableDictionary * cellDic = [[NSMutableDictionary alloc] init];
        /** 对比的单位*/
        id conparaObject = [array objectAtIndexSafe:i];
        //对比的单位
        [cellDic setObjectSafe:conparaObject forKey:@"object"];
        
        if([conparaObject isKindOfClass:[NSString class]])
        {
            //如果是字符串
            
            NSString * conpaiString = conparaObject;
            if(conpaiString.length > 0)
            {//首字符
                //                conpaiString = [conpaiString substringWithRange:NSMakeRange(0, 1)];
            }
            else
            {
                conpaiString = @"#";
            }
            
            [cellDic setObjectSafe:conpaiString forKey:@"conpaireString"];
            
            
            
        }
        else
        {
            if([conparaObject respondsToSelector:@selector(valueForKey:)] && [conparaObject valueForKey:key])
            {
                //如果是其他object
                NSString * conpaiString = [conparaObject valueForKey:key];
                if(conpaiString.length > 0)
                {//首字符
                    //                    conpaiString = [conpaiString substringWithRange:NSMakeRange(0, 1)];
                }
                else
                {
                    conpaiString = @"#";
                }
                [cellDic setObjectSafe:conpaiString forKey:@"conpaireString"];
            }
            else
            {
                //对比的拼音
                [cellDic setObjectSafe:@"#" forKey:@"conpaireString"];
            }
        }
        [allList addObject:cellDic];
        
    }
    
    //按照拼音首字母对这些object进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"conpaireString" ascending:YES]];
    [allList sortUsingDescriptors:sortDescriptors];
    
    for(int i = 0 ; i < [allList count]; i ++)
    {
        /** 被排序元素*/
        id object = [[allList objectAtIndexSafe:i] objectForKey:@"object"];
        
        [jieGuoArray addObjectSafe:object];
    }
    
    
    return jieGuoArray;
    
    
    //    {
    //        // 重新对所有大写字母Key值里面对应的的联系人数组进行排序
    //        //1.遍历联系人字典中所有的元素
    //        //利用到多核cpu的优势:参考:http://blog.sunnyxx.com/2014/04/30/ios_iterator/
    //        [addressBookDict enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, NSMutableArray * _Nonnull keyPeopleArray, BOOL * _Nonnull stop) {
    //            //2.对每个Key值对应的数组里的元素来排序
    //            [keyPeopleArray sortUsingComparator:^NSComparisonResult(PPPersonModel*  _Nonnull obj1, PPPersonModel  *_Nonnull obj2) {
    //
    //                return [obj1.name localizedCompare:obj2.name];
    //            }];
    //
    //        }];
    //
    //        // 将addressBookDict字典中的所有Key值进行排序: A~Z
    //        NSArray *peopleNameKey = [[addressBookDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    //
    //    }
    
    //    {
    //        //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    //        [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *peopleNameKey) {
    //            //addressBookDict:装着所有联系人的字典
    //            //peopleNameKey:联系人分组按拼音分组的Key值;
    //            //刷新 tableView
    //            [self.tableView reloadData];
    //        } authorizationFailure:^{
    //            NSLog(@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录");
    //        }];
    //    }
    
    
    //    {
    //        //获取没有经过排序的联系人模型
    //        [PPGetAddressBook getOriginalAddressBook:^(NSArray<PPPersonModel *> *addressBookArray) {
    //            //addressBookArray:原始顺序的联系人数组
    //            //刷新 tableView
    //            [self.tableView reloadData];
    //        } authorizationFailure:^{
    //            NSLog(@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录");
    //        }];
    //    }
}


#pragma mark- 红包算法
+(double)getRandomMoneyPackage:(NSDictionary*)lastInfo
{
    //剩余的红包数
    NSInteger remainSize = [lastInfo[@"remainSize"] integerValue];
    // 剩余的红包金钱
    double    remainMoney = [lastInfo[@"remainMoney"] doubleValue];
    
    if(remainSize == 1 || remainSize <= 0 )
    {
        NSLog(@"%f",remainMoney);
        
        return remainMoney;
    }
    
    double min = 0.01;
    double max = remainMoney*2 / remainSize;
    double money = (double)(rand())* max/RAND_MAX  ;
    
    money = [self doubleFormat:money];
    
    money = ((money <= min) ? 0.01 : money);
    
    if(remainMoney < 0.01)
    {
        money = remainMoney;
    }
    remainSize -- ;
    remainMoney -= money;
    
    
    ///输出其他结果
    NSDictionary * dic = @{@"remainSize":[NSNumber numberWithInteger:remainSize],@"remainMoney":[NSNumber numberWithDouble:remainMoney]};
    [self getRandomMoneyPackage:dic];
    
    return  money;
    
}

//保留两位小数
+(double)doubleFormat:(double)doubleValue
{
    NSInteger intValue = doubleValue * 100;
    
    double result =  intValue/100.0;
    return result;
}

#pragma mark - Convert Video Format
+(void)convertToMP4:(AVURLAsset*)avAsset videoPath:(NSString*)videoPath succ:(void (^)())succ fail:(void (^)())fail {
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality])
        
    {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        
        exportSession.outputURL = [NSURL fileURLWithPath:videoPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        CMTime start = CMTimeMakeWithSeconds(0, avAsset.duration.timescale);
        
        CMTime duration = avAsset.duration;
        
        CMTimeRange range = CMTimeRangeMake(start, duration);
        
        exportSession.timeRange = range;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                    fail();
                    break;
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"Export canceled");
                    fail();
                    break;
                default:
                    succ();
                    break;
            }
        }];
    }
}



@end
