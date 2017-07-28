//
//  UserInfoRequestModel.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/18.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLModel.h"

@interface UserInfoRequestModel : BLModel

/** 用户id*/
@property ( nonatomic , strong ) NSString * user_id;

/** 用户id*/
@property ( nonatomic , readwrite ) NSInteger  user_id_number;

@end
