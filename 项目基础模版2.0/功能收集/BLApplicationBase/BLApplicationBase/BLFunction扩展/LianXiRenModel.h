//
//  LianXiRenModel.h
//  BaiTang
//
//  Created by BLapple on 16/3/12.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLModel.h"

/** 联系人重要日期*/
@interface LianXiRenImportantDateModel : BLModel
/** 日期类型*/
@property ( nonatomic , strong ) NSString * string_dateType;
/** 内容*/
@property ( nonatomic , strong ) NSString * string_dateContent;

@end

/** 通讯录联系人model*/
@interface LianXiRenModel : BLModel

/**  用户头像*/
@property ( nonatomic , strong ) UIImage * user_head_image;

/**  用户名字*/
@property ( nonatomic , strong ) NSString * user_name;

/**  用户电话*/
@property ( nonatomic , strong ) NSMutableArray * user_phones;

/**  用户性别 男：“1” 女：“0”*/
@property ( nonatomic , strong ) NSString * contacts_sex;

/**  公司*/
@property ( nonatomic , strong ) NSMutableArray * user_company;
/**  地址*/
@property ( nonatomic , strong ) NSMutableArray * user_address;
/**  日期*/
@property ( nonatomic , strong ) NSMutableArray <LianXiRenImportantDateModel*> * user_times;

@end
