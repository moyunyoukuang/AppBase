//
//  BLMessagepop.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/13.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLAlertView.h"


typedef enum
{
    BLTagMessageLevelNomal        = 150,
    BLTagMessageLevelLow          = 120,
    BLTagMessageLevelHigh         = 180,
    
}BLTagMessageLevel;

typedef enum
{
    ///黑色吐丝信息
    BLMessageTypeText            = 1,
    ///加载中
    BLMessageTypeLoading         = 2,
    
}BLMessageType;

/** 信息提示框 加载中 */
@interface BLMessagepop : BLAlertView

/** 消息等级 默认 TagMessageLevelNomal 影响消息显示位置*/
@property ( nonatomic , readwrite ) BLTagMessageLevel messageLevel;


/** 显示消息类型*/
-(void)showMessageType:(BLMessageType)type content:(NSString*)content;

@end
