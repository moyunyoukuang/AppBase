//
//  BLSelectionpop.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/14.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLAlertView.h"
#import "BLModel.h"

typedef enum
{
    ///title content /button: confirm
    BLSelectionTypeMessage              = 1,
    ///title content /button: confirm cancel
    BLSelectionTypeSelection            = 2,
    
}BLSelectionType;

@interface BLSelectionInfoModel : BLModel

/** 标题*/
@property ( nonatomic , strong ) NSString * title;

/** 内容*/
@property ( nonatomic , strong ) NSString * content;

@end


/** 选择框*/
@interface BLSelectionpop : BLAlertView

/** 显示消息类型*/
-(void)showMessageType:(BLSelectionType)type contentInfo:(BLSelectionInfoModel*)contentInfo;

@end
