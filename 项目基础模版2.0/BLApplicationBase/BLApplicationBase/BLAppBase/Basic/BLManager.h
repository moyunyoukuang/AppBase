
///保存信息key值
#define YesSetting    @"YES"

#define NoSetting     @"NO"

//收到推送信息
#define ReceiveRemoteNotification @"ReceiveRemoteNotification"

////国际化方法 文字转换
#define BLLocalized(key)   [[AppManager shareManager] getLocalizationStringFor:(key)]
#define BLLocalizedArray(array) [[AppManager shareManager] getLocalizationStringForArray:(array)]

///用户信息保存
/** 信息保存路径*/
#define   Userinfosavepath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndexSafe:0] stringByAppendingPathComponent:@"userinfo"]

///设备uuid
#define  DevieceUUID     @"BLAPPLEuuid"

///用户设备UDID keyChainKey
#define  DevieceUUID_keychainKey  @"BLappDevieceUUID_keychainKey"

///业务noti key
//登录冲突
#define  LoginChongtu    @"LoginChongtu"

//需要更新app
#define  AppNeedUpDate   @"AppNeedUpDate"

/** md5保密码*/
#define  ApiSecretCode   @"ApiSecretCode"

///用户登录token
#define  userTokenKey    @"userTokenKey"


////通知
/** 用户登录事件*/
#define UserLoginSuccessNotification @"UserLoginSuccessNotification"
/** 用户退出事件 */
#define UserExistLoginNotification  @"UserExistLoginNotification"

/////—————— 用户设置信息
//语言0"中文 (简体)“ 1”中文 (繁体)" 2"English"
#define UserLanguageSettingKey  @"UserLanguageSettingKey"

/** 用户上次弹出提示升级的时间 用来避免一天弹出多次升级信息*/
#define  usercancelUpdatetimekey @"usercancelUpdatetime"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BLMessagepop.h"






/** 基础管理类 单例
 视图接口
 网络接口
 信息接口
 事件接口
 业务接口
 */
@interface BLManager : NSObject
{
    /** 当前视图的tag值*/
    NSInteger              controllerTag;
    
    /** 当前使用的语言 0 简体中文 1 繁体中文 2 英文 */
    NSInteger               currentLanguage;
}
+(instancetype)shareManager;

///当前应用主视图
/** 应用主窗口*/
@property ( nonatomic , strong ) UIWindow * mainWindows;
/** 应用主navi*/
@property ( nonatomic , strong ) UINavigationController * mainNavi;
/** 应用主VC(当前的VC)*/
@property ( nonatomic , strong ) UIViewController * mainVC;
/** 当前的navi*/
@property ( nonatomic , strong ) UINavigationController * currentNavi;



#pragma mark- 网络接口

/** 应用版本号，1期:1.0*/
@property ( nonatomic , strong ) NSString * app_version;
/** 手机系统类型：android/ios*/
@property ( nonatomic , strong ) NSString * app_system;
/** 手机型号（例：小米4）*/
@property ( nonatomic , strong ) NSString * app_model;
/** 手机系统版本*/
@property ( nonatomic , strong ) NSString * os_version;
/** 设备号 */
@property ( nonatomic , strong ) NSString * device_id;
/** 推送token*/
@property ( nonatomic , strong ) NSString * device_token;

/** 用户标识*/
-(NSString*)userToken;

/** 当前网络状态 notReachable,2G,3G,4G,LTE,3G/4G,wifi*/
-(NSString *)wangluo;

#pragma mark- 保存获取信息

/** 保存信息*/
-(void)setUserinfo:(NSString*)info forkey:(NSString*)key;

/** 获取信息*/
-(NSString*)getUserInfoForKey:(NSString*)key;


/** 保存程序使用信息 不限制是否是string*/
-(void)setInfo:(id)info forkey:(NSString*)key;
/** 获取信息*/
-(id)getinfoforkey:(NSString*)key;



#pragma mark- 弹出吐丝信息

/** 当前显示的视图tag*/
-(NSInteger)currentControllerTag;


/** 设置当前的controll tag  */
-(void)setCurrentShowControllerTag:(NSInteger)controllerTag;

/** 展示吐司信息
 * @param message 展示信息
 * @param controllerTag    与当前tag不同 就不会显示 为nil时不去判断，直接显示
 */
-(BLMessagepop *)showtagMessage:(NSString*)message ControllerTag:(NSInteger)controllerTag;

/** 展示吐司信息
 * @param message 展示信息
 * @param controllerTag    与当前tag不同 就不会显示 为nil时不去判断，直接显示
 * @param level           展示tag的等级（高度不同）0-10  默认5级
 */
-(BLMessagepop *)showtagMessage:(NSString*)message ControllerTag:(NSInteger)controllerTag tagLevel:(BLTagMessageLevel)level;



#pragma mark- 统一获取信息
/** 当前时间的时间戳  每次获取的时间戳都会不同*/
-(NSString *)huoQuShiJian;

/** 改变国际化标准库 0 简体中文 1 繁体中文 2 英文*/
-(void)changeLocalizationSystemTo:(NSInteger)index_language;

/** 当前语言 0 简体中文 1 繁体中文 2 英文*/
-(NSInteger)currentLanguageSet;

/** 获取国际化文本*/
-(NSString *)getLocalizationStringFor:(NSString*)string;

/** 获取国际化文本*/
-(NSMutableArray<NSString*> *)getLocalizationStringForArray:(NSArray<NSString*>*)array_string;

#pragma mark- 继承结构
/**  退出到登陆界面 (便利app功能调用)*/
-(void)pushToLoginVC;

#pragma mark- 业务接口

/** 登陆成功*/
-(void)loginSuccessWithToken:(NSString*)token;

/** 登陆成功*/
-(void)loginSuccess;
/** app需要升级*/
-(void)appNeedUpDate;
/**  登录冲突被强踢*/
-(void)loginChongTu;
/**  退出登录 删除登录信息*/
-(void)existLogin;





@end
