//
//  AppNetWork.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/17.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLNetWork.h"
#import "UserInfoModel.h"

///  获取用户列表(测试样例)
#define UserListNetKey @"userList"


@interface AppNetWork : BLNetWork


/** 获取用户列表(测试样例)*/
-(void)getUserListWithUserID:(NSString*)userID ReturnBlock:(void(^)(BLNetWorkResult *temResult , NSArray<__kindof UserInfoModel *> * userList))Block;





@end
