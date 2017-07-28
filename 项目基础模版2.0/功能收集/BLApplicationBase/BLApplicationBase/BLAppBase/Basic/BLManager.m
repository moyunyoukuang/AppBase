//
//  BLManager.m
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//




#import "BLManager.h"

#import "AppDelegate.h"
#import "Reachability.h"
#import "Keychain.h"
#import "CommonTool.h"

@interface  BLManager()
{
    /** 保存的用户信息*/
    NSMutableDictionary *  userinfodic;
    
    /** 上次反馈的时间戳 保证两次时间戳不一样*/
    long int               lastTime;
    
    /** 网络状态判断*/
    Reachability        *  Reachabili;
    
    /** 国际化处理bundle*/
    NSBundle            *   localizationBundle;

    
}
@end

@implementation BLManager

-(void)dealloc
{
    
}
+(instancetype)shareManager
{
    static  BLManager * shareBLManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareBLManager = [[[self class] alloc]init];
    });
    
    
    return shareBLManager;
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        //网络判断类
        Reachabili = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        //保存用户信息
        userinfodic = [[NSMutableDictionary alloc] initWithContentsOfFile:Userinfosavepath];
        if(userinfodic == nil)
        {
            userinfodic = [[NSMutableDictionary alloc] init];
        }
        
        
        //设备唯一id
        NSString * deviceid = [Keychain load:DevieceUUID_keychainKey];
        NSString * deviceid_Dic = [userinfodic objectForKey:DevieceUUID];
        
        if(!deviceid || deviceid.length == 0)
        {//设备ID无
            if(!deviceid_Dic || deviceid_Dic.length == 0)
            {
                deviceid_Dic = [CommonTool UUID];
                deviceid_Dic = [deviceid_Dic stringByReplacingOccurrencesOfString:@"-" withString:@""];
                [self setUserinfo:deviceid_Dic forkey:DevieceUUID];
            }
            deviceid = deviceid_Dic;
            [Keychain save:DevieceUUID_keychainKey data:deviceid];
        }else
        {
            if(![deviceid_Dic isEqualToString:deviceid])
            {//本地id与设备id不同
                deviceid_Dic = deviceid;
                [self setUserinfo:deviceid_Dic forkey:DevieceUUID];
            }
        }

        
        self.device_id = deviceid;
        
        ////初始化语言设置
        NSString * languageSetting = [self getUserInfoForKey:UserLanguageSettingKey];
        NSInteger choosen  = 0 ;
        if(languageSetting.length > 0 )
        {//设置过语言设置语言
             choosen  = [languageSetting integerValue];
        }
        else
        {//未设置程序语言和系统语言匹配
            if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
                NSArray *languages = [NSLocale preferredLanguages];
                NSString *language = [languages objectAtIndexSafe:0];
                if ([language hasPrefix:@"zh-Hans"]) {//开头匹配
                    choosen = 0;
                }
                else
                    if ([language hasPrefix:@"zh-Hant"]) {//开头匹配
                        choosen = 1;
                    }
                    else{
                        choosen = 2;
                    }
            }
        
        }
        
        [self changeLocalizationSystemTo:choosen];

        [self baseSetting];
        
       
        
    }
    return self;
}

-(void)baseSetting
{
   
    self.app_version    =   AppVerSionCode;
    self.app_system     =   @"iOS";
    self.app_model      =   [UIDevice currentDevice].model;
    if(!self.app_model)
    {
        self.app_model = @"";
    }
    self.os_version     =   [UIDevice currentDevice].systemVersion;
    if(!self.os_version)
    {
        self.os_version = @"";
    }
    self.device_id      =   self.device_id;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginChongTu) name:LoginChongtu object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appNeedUpDate) name:AppNeedUpDate object:nil];
    
    
}

#pragma mark- 代理方法



#pragma mark- 保存获取信息
//保存用户string信息
-(void)setUserinfo:(NSString*)info forkey:(NSString*)key
{
    if(info == nil && key != nil)
    {
        [userinfodic removeObjectForKey:key];
        [userinfodic writeToFile:Userinfosavepath atomically:YES];
    }
    
    if(info != nil && key != nil)
    {
        if( ![[userinfodic objectForKey:key]isEqualToString:info] )
        {
            [userinfodic setObjectSafe:info forKey:key];
            [userinfodic writeToFile:Userinfosavepath atomically:YES];
        }
    }
    
    if([key isEqualToString:UserLanguageSettingKey])
    {//修改语言设置
        
        [self changeLocalizationSystemTo:[info integerValue]];
    
    }
}

-(NSString*)getUserInfoForKey:(NSString*)key
{
    NSString* info = [userinfodic objectForKey:key];
    if(info == nil)
    {
        info = @"";
    }
    return info;
}


//保存程序使用信息 不限制是否是string
-(void)setInfo:(id)info forkey:(NSString*)key
{
    if(info == nil && key != nil)
    {
        [userinfodic removeObjectForKey:key];
        [userinfodic writeToFile:Userinfosavepath atomically:YES];
    }
    
    if(info != nil && key != nil)
    {
        [userinfodic setObjectSafe:info forKey:key];
        [userinfodic writeToFile:Userinfosavepath atomically:YES];
    }
}

-(id)getinfoforkey:(NSString*)key
{
    NSString* info = [userinfodic objectForKey:key];
    
    return info;
}


#pragma mark- 统一获取信息
//当前网络状态
-(NSString *)wangluo
{
    NSString* netstate=@"";
    
    netstate = [self networkingStatesFromStatebar];
    
    
    if(!netstate)
    {//从状态栏读取不成功
        switch ([Reachabili currentReachabilityStatus]) {
                
            case ReachableViaWiFi:
                
                netstate = @"wifi";
                break;
                
            case ReachableViaWWAN:
                
                netstate = @"3G/4G";
                break;
                
            case NotReachable:
                
                break;
                
            default:
                
                break;
        }
    }
    
    
    return netstate;
}

-(NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    BOOL find = NO;
    
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            NSString * value = [child valueForKeyPath:@"dataNetworkType"];
            if(value)
            {
                find = YES;
                type = [value intValue];
            }
            
        }
    }
    if(!find)
    {
        return nil;
    }
    
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

/** 当前时间的时间戳*/
-(NSString *)huoQuShiJian
{
    NSDate * datenow = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate * localeDate = [datenow  dateByAddingTimeInterval: interval];
    datenow = localeDate;
    
    /** 时间戳时间*/
    long int getTime = [datenow timeIntervalSince1970]*1000;
    if(getTime == lastTime)
    {
        //与上次时间相同的话，加一 保证不同
        getTime ++;
    }
    
    NSString * timeSp = [NSString stringWithFormat:@"%ld", getTime];
    
    lastTime = getTime;
    
    return timeSp;
}

/** 改变国际化标准库 0 简体中文 1 繁体中文 2 英文*/
-(void)changeLocalizationSystemTo:(NSInteger)index_language
{
    NSString * choosenBundle =  @"zh-Hans";
    switch (index_language) {
        case 0:
        {//简体中文
            choosenBundle =  @"zh-Hans";
        }
            break;
        case 1:
        {//繁体中文
            choosenBundle =  @"zh-Hant";
        }
            break;
        case 2:
        {//英文
            choosenBundle =  @"en";
        }
            break;
            
        default:
            break;
    }
    currentLanguage = index_language;
    
    localizationBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:choosenBundle ofType:@"lproj"]];
}

/** 当前语言 0 简体中文 1 繁体中文 2 英文*/
-(NSInteger)currentLanguageSet
{
    return currentLanguage;
}


/** 获取国际化文本*/
-(NSString *)getLocalizationStringFor:(NSString*)string
{
    if([string isKindOfClass:[NSString class]])
    {
        if(string.length > 0 )
        {
            NSString * content =  [localizationBundle localizedStringForKey:string value:nil table:@"Language"];
            if(content.length == 0 || !content)
            {
                content = string;
            }
            return content;
        }
    }
    else
    {//非string 原类型返回
        return string;
    }
 
    
    return @"";
}

/** 获取国际化文本*/
-(NSMutableArray<NSString*> *)getLocalizationStringForArray:(NSArray<NSString*>*)array_string
{
    NSMutableArray * array_muti = [NSMutableArray array];
    for ( NSInteger i = 0 ; i < [array_string count] ; i ++ )
    {
        NSString * string = [array_string objectAtIndexSafe:i];
        
        NSString * translate = [self getLocalizationStringFor:string];
        
        [array_muti addObjectSafe:translate];
    }
    
    return array_muti;
}



-(NSString*)userToken
{
    return [self getUserInfoForKey:userTokenKey];
}
#pragma mark- 弹出吐丝信息

/** 当前显示的视图类型*/
-(NSInteger)currentControllerTag
{
    return controllerTag;
}


/** 设置当前的controll tag */
-(void)setCurrentShowControllerTag:(NSInteger)NewControllerTag
{
    controllerTag = NewControllerTag;
}

/** 展示吐司信息
 *  message 展示信息
 *  controllerTag    与当前tag不同 就不会显示 为nil时不去判断，直接显示
 */
-(BLMessagepop *)showtagMessage:(NSString*)message ControllerTag:(NSInteger)checkControllerTag
{
    
    
    
    return  [self showtagMessage:message ControllerTag:checkControllerTag tagLevel:BLTagMessageLevelNomal];
    
}

/** 展示吐司信息
 *  message 展示信息
 *  controllerTag    与当前tag不同 就不会显示 为nil时不去判断，直接显示
 *  level           展示tag的等级（高度不同）0-10  默认5级
 */
-(BLMessagepop *)showtagMessage:(NSString*)message ControllerTag:(NSInteger)checkControllerTag tagLevel:(BLTagMessageLevel)level
{
  
    if(message == nil || ![message isKindOfClass:[NSString class]] || message.length == 0)
    {
        return nil;
    }
    
    if(level == 0)
    {
        level = BLTagMessageLevelNomal;
    }
    
    
    if(checkControllerTag == 0 ||  (controllerTag == 0) || controllerTag == checkControllerTag)
    {
        
        BLMessagepop * popMessage = [BLMessagepop customView];
        popMessage.messageLevel = level;
        [popMessage showMessageType:BLMessageTypeText content:message];
        [popMessage showInView:self.mainWindows];
        [popMessage hideAfterDelay:ErrorLableShowTime];
        
        return popMessage;
    }
    else
    {
        return nil;
    }
    
    
    
    
}



#pragma mark- 继承接口
/**  退出到登陆界面*/
-(void)pushToLoginVC
{
    
}

#pragma mark- 业务接口

/** 登陆成功*/
-(void)loginSuccessWithToken:(NSString*)token
{
 
    [self setUserinfo:token forkey:userTokenKey];
    
    [self loginSuccess];
    
}

/** app需要升级*/
-(void)appNeedUpDate
{

}
/**  登录冲突被强踢*/
-(void)loginChongTu
{
    [self existLogin];
}

/** 登陆成功*/
-(void)loginSuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginSuccessNotification object:self];
}

/**  退出登录 删除登录信息*/
-(void)existLogin
{
    [self setUserinfo:@"" forkey:userTokenKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserExistLoginNotification object:self];
}




@end
