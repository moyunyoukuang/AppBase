//
//  BLModel.h
//  BaiTang
//
//  Created by BLapple on 16/3/6.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLModelBasic : NSObject
/** 生成Model使用的对象*/
@property ( nonatomic , strong) id  origineObject;
/** 是否被选中*/
@property ( nonatomic , readwrite ) BOOL selected;

@end

/** 属性不要以以下划线_开始*/
@interface BLModel : BLModelBasic <NSCoding>

/** 用字典生成模型*/
-(instancetype)initWithDictionary:(NSDictionary*)diction;

/** 从BLmodel开始 所有的属性名*/
-(NSArray*)allPropertyNameList;

/** 保存为字典信息 这里只适用于纯string对象，对于其他类型，请根据需要自行编辑 (参考.m文件头部注释)*/
-(NSMutableDictionary*)saveToDic;

/** 信息是否变化 对比创建时的信息*/
-(BOOL)infoChanged;

@end




