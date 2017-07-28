//
//  UserInfoModel.m
//  BLappleAppBase
//
//  Created by camore on 16/4/8.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserImportantModel

- (void)setValue:(nullable id)value forKey:(NSString *)key
{



    if([key isEqualToString:@"type"])
    {
       
        if([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
        {
            _type = [value integerValue];
        }
        
        return;
    }

    [super setValue:value forKey:key];

}

@end


@implementation UserInfoModel

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"user_important"])
    {
        NSMutableArray * mutiArray = [NSMutableArray array];
        if([value isKindOfClass:[NSArray class]])
        {
            for(int i = 0 ; i < [value count] ; i ++)
            {
                NSDictionary * dic = [value objectAtIndexSafe:i];
                UserImportantModel * model = [[UserImportantModel alloc] initWithDictionary:dic];
                [mutiArray addObjectSafe:model];
            }
        }
        _user_important = mutiArray;
        return;
    }
    
    
    
    [super setValue:value forKey:key];
    
}

@end
