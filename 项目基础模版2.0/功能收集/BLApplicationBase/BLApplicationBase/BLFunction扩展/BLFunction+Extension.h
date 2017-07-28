//
//  BLFunction+Extension.h
//  BLFunction
//
//  Created by camore on 2017/7/18.
//  Copyright © 2017年 BLapple. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "LianXiRenModel.h"
#import "BLFunction.h"
typedef enum
{
    //数字
    CharAttributeTypeNumber  = 1,
    //英文字符
    CharAttributeTypeEnglish = 2,
    //中文字符
    CharAttributeTypeChinese = 3,
    //特殊字符
    CharAttributeTypeUnkonwn = 4,
}CharAttributeType;

/** 字符的属性*/
@interface CharAttributeModel : NSObject

/** 原字符*/
@property ( nonatomic , strong ) NSString * originChar;

/** 字符类型*/
@property ( nonatomic , readwrite ) CharAttributeType type;

/** 代表字符 排序是用来排序的字符 数字 英文是大些字母 拼音 特殊字符是“#”*/
@property ( nonatomic , strong )    NSString * replaceString;

/** 中文对应的全拼*/
@property ( nonatomic , strong )    NSString * fullPinYin;


@end

/** 功能扩展 将一些不常用的功能扩展出来 需要时可以导入使用*/
@interface BLFunction (Extension)

/** 获取通讯录里所有人的信息 [LianXiRenModel]*/
+(NSArray<LianXiRenModel*>*)getAllPeoPleInTongXunLv;

/** 获取所有联系人 异步*/
-(void)getAllLianXiRen:(void(^)(NSArray         *   lianXiRen_paiXu_title_array,NSMutableArray<NSArray<LianXiRenModel*>*> * array_contacts))callbackBlock;

#pragma mark- 拼音 处理
/** 获取字符串中首字母的拼音 没有为# 字母为大写字母 数字为数字*/
+(NSString *)getPinYinFromString:(NSString*)string;
/** 获取字符串中每个字符对应的拼音 没有为# 字母为大写字母 数字为数字*/
+(NSMutableArray<CharAttributeModel*>*)getAttributeFromString:(NSString*)string;
/** 获取首字母*/
+(NSString*)getFirstCharFromeAttributeArray:(NSArray<CharAttributeModel*>*)array_attribute;
/** 获取全部字母*/
+(NSString*)getFullCharFromeAttributeArray:(NSArray<CharAttributeModel*>*)array_attribute;


/** 将 ABCDEF 转换为  222333*/
+(NSString*)changePinYinToNumber:(NSString*)string;

/** 用拼音进行排序 @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
 @param array   排序的内容
 @param key     如果array 中是字符串key没有作用 如果是对象，则为排序的key值
 @return        排序出来的顺序 @[[key] [object],[object],[object]] 第一个为排序的key array
 */
+(NSMutableArray *)paiXuWithPinYin:(NSArray*)array key:(NSString*)key;

/** 用首字母排序
 @param array   排序的内容
 @param key     如果array 中是字符串key没有作用 如果是对象，则为排序的key值
 @return        排序出来的顺序 @[[key] [object],[object]] 第一个为排序的key
 */
+(NSMutableArray *)paiXuWithFirstChar:(NSArray*)array key:(NSString*)key;

/** 以关键值重新排序*/
+(NSMutableArray *)paiXu:(NSArray*)array key:(NSString*)key;
#pragma mark- 红包算法
//红包算法 @"remainSize"剩余的红包数 @"remainMoney" 剩余的红包金钱
+(double)getRandomMoneyPackage:(NSDictionary*)lastInfo;

#pragma mark - Convert Video Format
+(void)convertToMP4:(AVURLAsset*)avAsset videoPath:(NSString*)videoPath succ:(void (^)())succ fail:(void (^)())fail;


@end
