//
//  AppNetWork.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/17.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "AppNetWork.h"

@implementation AppNetWork


/** 获取用户列表(测试样例)*/
-(void)getUserListWithUser:(UserInfoRequestModel*)requestModel ReturnBlock:(void(^)(BLNetWorkResult *temResult , NSArray<__kindof UserInfoModel *> * userList))Block
{
    Block = [Block copy];
    if(!self.getNetworkResultBlock)
    {
        self.getNetworkResultBlock = ^(BLNetWorkResult *temResult){
            
            NSMutableArray * useList = [NSMutableArray array];
            if (temResult.result_code == eNetStatusCodeSUCC)
            {
                if(temResult.origineObject && [temResult.origineObject isKindOfClass:[NSDictionary class]])
                {
                    NSArray * array = temResult.origineObject[@"user_list"];
                    
                    for(int i = 0 ; i< [array count] ; i ++)
                    {
                        NSDictionary * dic = [array objectAtIndexSafe:i];
                        
                        if([dic isKindOfClass:[NSDictionary class]])
                        {
                            UserInfoModel * model = [[UserInfoModel alloc] initWithDictionary:dic];
                            [useList addObjectSafe:model];
                        }
                    }
                }
            }
            
            if(Block)
            {
                Block(temResult,useList);
            }
        };
    }
    
    
    NSMutableDictionary * parameter = [requestModel saveToDic];
//    [parameter setObjectSafe:userID forKey:@"userID"];//可以附加信息
    [self Tongyongjiekou:UserListNetKey Parameters:parameter];
    
}



@end
