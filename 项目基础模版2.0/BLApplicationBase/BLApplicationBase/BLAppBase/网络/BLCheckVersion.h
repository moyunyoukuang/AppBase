//
//  CamoreCheckVersion.h
//  deLaiSu
//
//  Created by camore on 15/7/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BLCheckVersion : NSObject


+(instancetype)shareManager;

/** 每日检查更新 一天最多一次*/
-(void)checkforUpadaDayly;

/** 检查普通更新*/
-(void)checkforNormalUpdateWithLoader:(BOOL)loader;

@end
