//
//  BLNetWork.h
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLNetWorkResult.h"

//结果返回block
typedef void (^NetworkResultBlock) (BLNetWorkResult *);
//处理反馈结果block
typedef BLNetWorkResult* (^TreateBlock)(NSDictionary* dic);
//请求进度block
typedef void (^BLNetWorkProGress)(NSProgress *  uploadProgress , double percent);

@interface BLNetWork : NSObject

/** 返回结果block 未提取数据model化*/
@property (nonatomic, copy) NetworkResultBlock getNetworkResultBlock;

/** 请求进度block */
@property (nonatomic, copy) BLNetWorkProGress NetworkProgressBlock;


/** 默认接口数据替换参数*/
@property (nonatomic, strong) NSDictionary * replaceParameter;
/** 当前是哪个类型controll弹出的*/
@property ( nonatomic ,readwrite )NSInteger controllerTag;
///** 任务区分标识*/
//@property ( nonatomic ,readwrite )NSInteger networkSpTag;
/** 隐藏加载中视图 默认no */
@property ( nonatomic ,readwrite ) BOOL        hideLoading;

/** 隐藏返回提示 默认no*/
@property ( nonatomic , readwrite ) BOOL        hideErroeTag;

/** 取消token限制 */
@property ( nonatomic , readwrite ) BOOL        cancelTokenLimit;

/** 加载中可以点击 默认yes 可以点击界面*/
@property ( nonatomic , readwrite ) BOOL        loadingCanTouch;


/** 加载所在的视图*/
@property ( nonatomic , strong ) UIView     *   loadingInView;
-(void)listenNetWorkProgress:(BLNetWorkProGress)progress;

/** 接口url*/
- (NSString *)getCompleteRequestParameters:(NSDictionary *)temParameters forMessageName:(NSString *)OneMessageName;

///** 加载中是否可以返回,加载页面会下移64像素 给返回留出空位*/
//@property (nonatomic, readwrite)BOOL  loadingcangoback;
#pragma mark - 通用请求接口
///请求接口

/** 无任何附加操作的请求 只处理获得的数据结构
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 */
-(void)ClearActionwith:(NSString*)message info:(NSDictionary*)temParameters;

/** 通用的数据接口 默认添加加载进度
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 */
-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters;

/** 通用的数据接口 及相关设置
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 * @param block         如何处理返回信息
 */
-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters treatblock:(TreateBlock)block;

/** 通用的数据接口 及相关设置
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 * @param showloader    是否展示加载圈
 */
-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showloader:(BOOL)showloader;

/** 通用的数据接口 及相关设置
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 * @param showstring    请求时提示给用户的信息（现在只显示加载圈，不提示信息）
 * @param showview      加载圈，添加在哪个视图上
 */
-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview;

/** 通用的数据接口 及相关设置
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 * @param showstring    请求时提示给用户的信息（现在只显示加载圈，不提示信息）
 * @param showview      加载圈，添加在哪个视图上
 * @param tag           展示错误信息
 */
-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview showerrortag:(BOOL)tag;

/** 通用的数据接口 及相关设置
 * @param message       请求的接口
 * @param temParameters 请求附加信息
 * @param showstring    请求时提示给用户的信息（现在只显示加载圈，不提示信息）
 * @param showview      加载圈，添加在哪个视图上
 * @param tag           展示错误信息
 * @param check         是否处理错误信息(105,等，弹出提示框升级或者登录冲突信息)
 * @param treat         如何处理得到的数据信息(nil,自动换成常用处理)
 */
-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview showerrortag:(BOOL)tag precheckstate:(BOOL)check treatblock:(TreateBlock)treat;

/** 自定义网络接口 获取数据不处理数据结构*/
-(void)ZidingyiUrl:(NSString*)Url Parameters:(NSDictionary *)temParameters;


#pragma mark - 快捷请求接口


@end
