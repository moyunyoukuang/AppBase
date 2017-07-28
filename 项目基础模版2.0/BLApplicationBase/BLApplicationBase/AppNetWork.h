//
//  AppNetWork.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/17.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLNetWork.h"

#import "UserInfoModel.h"
#import "UserInfoRequestModel.h"

///  获取用户列表(测试样例)
#define UserListNetKey @"userList"

/**
{
    AppNetWork * network = [[AppNetWork alloc] init];
    __weak typeof(self) weakSelf = self;
    
    network.loadingInView = self.view;
    
    
    [network getUserListWithUser:request ReturnBlock:^(BLNetWorkResult *temResult, NSArray<__kindof UserInfoModel *> *userList) {
        __strong typeof(self) strongSelf = weakSelf;
        if(temResult.result_code == eNetStatusCodeSUCC)
        {
            [strongSelf gotUserinfo:userList];
            
        }
    }];
}
*/

@interface AppNetWork : BLNetWork


/** 获取用户列表(测试样例)*/
-(void)getUserListWithUser:(UserInfoRequestModel*)requestModel ReturnBlock:(void(^)(BLNetWorkResult *temResult , NSArray<__kindof UserInfoModel *> * userList))Block;





@end
