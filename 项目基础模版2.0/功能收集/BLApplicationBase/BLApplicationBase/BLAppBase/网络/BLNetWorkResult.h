//
//  BLNetWorkResult.h
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//
#import "BLModel.h"
#import <Foundation/Foundation.h>

typedef enum
{
    ///100 成功（无Message 或者值为null都行）
    eNetStatusCodeSUCC          = 100,
    ///101 业务失败：逻辑处理（Message返回错误消息、可能是用户名冲突、密码不正确等）
    eNetStatusCodeFAIL          = 101,
    ///102 系统失败：“系统繁忙”
    eNetStatusCodeBussiy        = 102,
    ///103 系统强踢（完全退出，暂时不考虑）
    eNetStatusCodeAccountError  = 103,
    ///104 强制升级模版
    eNetStatusCodeForbidUpdatemodel = 104,
    ///105 强制升级应用（不升级不让继续使用，需要再去请求升级接口）
    eNetStatusCodeForbidUpdate  = 105,
    ///106 就是需要用户进行验证，（手机号默认记录，跳转到输入验证码页）
    eNetStatusCodeNeedlogin     = 106,
    ///107 用户第一次进行验证，需要显示邀请码。
    eNetStatusCodeFirstlogin    = 107,
    ///108 应用url的MD5校验不正确。建议更新Key。
    eNetStatusCodeMd5KeyError   = 108,
    ///网络出错
    eNetStatusCodeNeterror      = 109,
}NetStatusCode;


@interface BLNetWorkResult : BLModel


/** 请求返回状态*/
@property (nonatomic, readwrite) NetStatusCode       result_code;
/** 状态提示信息*/
@property (nonatomic, strong) NSString              * message;
/** 返回的时间*/
@property (nonatomic, strong) NSString              * response_num;



@end
