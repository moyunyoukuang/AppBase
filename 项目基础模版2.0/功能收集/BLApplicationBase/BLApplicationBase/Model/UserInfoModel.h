//
//  UserInfoModel.h
//  BLappleAppBase
//
//  Created by camore on 16/4/8.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLModel.h"




@interface UserImportantModel : BLModel

/** 类型*/
@property ( nonatomic , readwrite ) NSInteger type;

/** 值*/
@property ( nonatomic , strong ) NSString * value;

@end


@interface UserInfoModel : BLModel

/** 用户姓名*/
@property ( nonatomic , strong ) NSString * user_name;

/** 用户性别 1男 0女*/
@property ( nonatomic , strong ) NSString * user_sex;

/** 用户  重要时间  常用地址*/
@property ( nonatomic , strong ) NSMutableArray <UserImportantModel*> * user_important;

@end
