//
//  BLNetWork.m
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLNetWork.h"
#import "AFNetworking.h"


@interface BLNetWork()
/** 网络错误的返回*/
@property (nonatomic, strong) BLNetWorkResult *errorResult;

@end

@implementation BLNetWork


+(dispatch_queue_t)sharedQueue
{
    static  dispatch_queue_t queue ;
    if(!queue)
    {
       queue = dispatch_queue_create("afnetworkRequestQueue", NULL);
        
//        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
    }
    
    return queue;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
        
        
        BLNetWorkResult *errorResult= [[BLNetWorkResult alloc] init];
        [errorResult setResult_code:eNetStatusCodeNeterror];
        [errorResult setMessage:@"网络连接失败"];
        self.errorResult = errorResult;
        self.loadingCanTouch = YES;
        
        self.controllerTag = [[BLManager shareManager] currentControllerTag];
//        self.networkSpTag = random()%INT_MAX;
    }
    
    return self;
}


-(void)listenNetWorkProgress:(BLNetWorkProGress)progress
{
    self.NetworkProgressBlock = progress;

}

#pragma mark- 接口默认设置

- (NSString *)getCompleteRequestParameters:(NSDictionary *)temParameters forMessageName:(NSString *)OneMessageName
{
    BLManager * manager  = [BLManager shareManager];
    
    NSString* baseip = APPUrlPath;
    
    NSString *app_version = manager.app_version;
    
    NSString *app_system  = manager.app_system;
    
    NSString *app_model = manager.app_model;
    
    NSString *os_version = manager.os_version;
    
    NSString *device_id = manager.device_id;
    
    NSString *userToken = [manager userToken] ;
    if(!userToken)
    {
    userToken = @"";
    }
    
    NSString *pos_mode = [manager wangluo];
    if(!pos_mode)
    {
        pos_mode = @"";
    }
    
    NSString *request_num = [manager huoQuShiJian];
    
    if(request_num==nil)
    {
        request_num=@"";
    }
    
    NSString *messageName = OneMessageName;
    if(messageName == nil)
    {
        messageName = @"";
    }
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObjectSafe:baseip        forKey:@"ip"];
    [parameters setObjectSafe:app_version   forKey:@"app_version"];
    [parameters setObjectSafe:app_system    forKey:@"app_system"];
    [parameters setObjectSafe:app_model     forKey:@"app_model"];
    [parameters setObjectSafe:os_version    forKey:@"os_version"];
    [parameters setObjectSafe:device_id     forKey:@"device_id"];
    [parameters setObjectSafe:userToken     forKey:@"user_token"];
    [parameters setObjectSafe:pos_mode      forKey:@"pos_mode"];
    [parameters setObjectSafe:request_num   forKey:@"request_num"];
    [parameters setObjectSafe:messageName   forKey:@"message_name"];


    
    //默认接口信息修改
    if (temParameters) {
        for (NSString *thisKey in [temParameters allKeys]) {
            [parameters setObjectSafe:[temParameters objectForKey:thisKey] forKey:thisKey];
        }
    }
    
    //key的顺序
    NSArray * keyIndex = @[@"city",@"app_version",@"app_system",@"app_model",@"os_version",@"device_id",@"pos_index",@"pos_time",@"ispos",@"user_token",@"pos_mode",@"request_num",@"message_name",@"time_zone",@"lang"];
    
    /** 最终生成的url*/
    NSString * baoxianstring = [parameters objectForKey:@"ip"];
    
    /** 做md5的数值*/
    NSString * md5Kyes = @"";
    
    [parameters removeObjectForKey:@"ip"];
    
    NSString * string_keys = @"";
    for( int i = 0 ;i < [keyIndex count] ; i ++)
    {
        if(i != 0 )
        {
            string_keys = [string_keys stringByAppendingString:@"&"];
        }
        NSString * thisKey = [keyIndex objectAtIndexSafe:i];
        string_keys = [NSString stringWithFormat:@"%@%@=%@",string_keys,thisKey,[parameters objectForKey:thisKey]];
        md5Kyes = [NSString stringWithFormat:@"%@%@",md5Kyes,[parameters objectForKey:thisKey]];
    }
    
    baoxianstring = [baoxianstring stringByAppendingString:string_keys];
    
    NSString * apiSecret = [manager getUserInfoForKey:ApiSecretCode];
    
    if(!apiSecret || apiSecret.length == 0)
    {
        apiSecret = @"yiyaohttp";
    }
    md5Kyes = [md5Kyes stringByAppendingString:apiSecret];
    
    NSString* md5code = [md5Kyes MD5String];
    
    baoxianstring = [baoxianstring stringByAppendingString:[NSString stringWithFormat:@"&wirelesscode=%@",md5code]];
    
    
    return baoxianstring;
}
#pragma mark- 通用请求接口

-(void)ClearActionwith:(NSString*)messagename info:(NSDictionary*)temParameters
{
    [self Tongyongjiekou:messagename Parameters:temParameters showwithstring:nil showinview:nil showerrortag:NO precheckstate:NO treatblock:nil];
    
}


-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters
{
    [self Tongyongjiekou:message Parameters:temParameters showloader:YES];
}

-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters treatblock:(TreateBlock)block
{
    [self Tongyongjiekou:message Parameters:temParameters showwithstring:LoadingTip showinview:nil showerrortag:YES treatblock:block];
    
}


-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showloader:(BOOL)showloader
{
    if(showloader)
    {
        [self Tongyongjiekou:message Parameters:temParameters showwithstring:LoadingTip showinview:nil];
    }else
    {
        [self Tongyongjiekou:message Parameters:temParameters showwithstring:nil showinview:nil];
    }
    
}



-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview
{
    [self Tongyongjiekou:message Parameters:temParameters showwithstring:showstring showinview:showview showerrortag:YES];
}


-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview showerrortag:(BOOL)tag
{
    [self Tongyongjiekou:message Parameters:temParameters showwithstring:showstring showinview:showview showerrortag:tag treatblock:nil];
}


-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview showerrortag:(BOOL)tag treatblock:(TreateBlock)treat
{
   
    [self Tongyongjiekou:message Parameters:temParameters showwithstring:showstring showinview:showview showerrortag:tag precheckstate:YES treatblock:treat];
    
    
    
}


-(void)Tongyongjiekou:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview showerrortag:(BOOL)tag precheckstate:(BOOL)check treatblock:(TreateBlock)treat
{
    
    if(treat==nil)
    {
        treat=^(id data){
            return [[BLNetWorkResult alloc] initWithDictionary:data];
        };
        
    }
    
    if(!showview)
    {
        if(self.loadingInView)
        {
            showview = self.loadingInView;
        }
        else
        {
            //默认加载视图
            showview = [BLManager shareManager].mainVC.view;
        }
    }
    
    if(self.hideErroeTag)
    {
        tag = NO;
    }
    
    if(temParameters == nil)
    {//避免无参数
        temParameters = [NSDictionary dictionary];
    }
    
    if([[AppManager shareManager] userToken].length == 0 && !self.cancelTokenLimit)
    {//无用户token不请求
        
        return;
    }
    
    @try {
        
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
        session.requestSerializer = [AFJSONRequestSerializer serializer];
        
        session.responseSerializer.acceptableContentTypes = nil;
        session.securityPolicy = [AFSecurityPolicy defaultPolicy];
        session.securityPolicy.allowInvalidCertificates = YES;
        session.securityPolicy.validatesDomainName = NO;
        
        NSString* tongyongurl                   =   [self getCompleteRequestParameters:self.replaceParameter forMessageName:message];
        
        if(!tongyongurl ||tongyongurl.length == 0 )
        {//没有url 退出
            return;
        }
        tongyongurl = [CommonTool makeHttpsSafeForContent:tongyongurl];
        
        
        if([CommonTool isUrlNeedAddSelfCertificate:tongyongurl] )
        {//判断是否需要添加自认证
            [session setSecurityPolicy:[BLNetWork customSecurityPolicy]];
        }
        
        BLMessagepop * hud                      =   nil;
        
        if(showstring && !self.hideLoading)
        {
            
            hud             =   [BLMessagepop customView];
            
            [hud showMessageType:BLMessageTypeLoading content:showstring];//需要显示提示信息的需要扩展
            
            [hud showInView:showview];
            
            
            
            if(self.loadingCanTouch)
            {
                hud.userInteractionEnabled = NO;
            }
            else
            {
                hud.userInteractionEnabled = YES;
            }
            
        }
        
        
        
        [BLNetWork starttatusbarIndicator];
        __weak BLMessagepop* weakhud=hud;
        
        
        [session POST:tongyongurl parameters:temParameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
            if(self.NetworkProgressBlock)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.NetworkProgressBlock(uploadProgress,uploadProgress.fractionCompleted);
                });
                
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            __strong BLMessagepop* stornghud=weakhud;
            [BLNetWork stopstatusbarIndicator];
            
            
            [stornghud dissMissAlertAnimate:NO];
            
            
            NSDictionary * dic = [NSMutableDictionary dictionary] ;
            if([responseObject length]>0)
            {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            }
            
            
            BLNetWorkResult *netResult = treat(dic);
            
            if(netResult.result_code == eNetStatusCodeNeedlogin&&check)
            {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LoginChongtu object:nil];
                
            }
            
            if(netResult.result_code == eNetStatusCodeForbidUpdate&&check)
            {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:AppNeedUpDate object:nil];
                
            }
            
            if(netResult.result_code == eNetStatusCodeMd5KeyError)
            {

                [self getnewMd5key:message Parameters:temParameters showwithstring:showstring showinview:showview showerrortag:tag precheckstate:check treatblock:treat];
                
            }
            
            
            if(netResult.result_code != eNetStatusCodeSUCC && netResult.result_code != eNetStatusCodeMd5KeyError)
            {
                if(  tag && netResult.message.length > 0)
                {
                    [[BLManager shareManager] showtagMessage:message ControllerTag:self.controllerTag tagLevel:BLTagMessageLevelNomal];
                 
                }
            }
            
            if(_getNetworkResultBlock)
            {
                
                _getNetworkResultBlock(netResult);
            }
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [BLNetWork stopstatusbarIndicator];
            
            NSLog(@" response:%@",error);
            __strong BLMessagepop* stornghud=weakhud;
            
            [stornghud dissMissAlertAnimate:NO];
            
            if(tag)
            {
                [[BLManager shareManager] showtagMessage:@"网络出错" ControllerTag:self.controllerTag tagLevel:BLTagMessageLevelNomal];
                
            }
            
            if(_getNetworkResultBlock)
            {
                _getNetworkResultBlock(self.errorResult);
            }
            
        }];
     
        
    }
    @catch (NSException * __unused exception)
    {
        
    }
    @finally {
        
    }
    
    
    
}



/** 自定义请求接口 */
-(void)ZidingyiUrl:(NSString*)Url Parameters:(NSDictionary *)temParameters
{
    if(temParameters == nil)
    {//避免无参数
        temParameters = [NSDictionary dictionary];
    }
    
    @try {
        if(!Url ||Url.length == 0 )
        {//没有url 退出
            return;
        }
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
        session.requestSerializer = [AFJSONRequestSerializer serializer];
        
        session.responseSerializer.acceptableContentTypes = nil;
        session.securityPolicy = [AFSecurityPolicy defaultPolicy];
        session.securityPolicy.allowInvalidCertificates = YES;
        session.securityPolicy.validatesDomainName = NO;
        
        
        Url = [CommonTool makeHttpsSafeForContent:Url];
        if([CommonTool isUrlNeedAddSelfCertificate:Url] )
        {
            [session setSecurityPolicy:[BLNetWork customSecurityPolicy]];
        }
        [BLNetWork starttatusbarIndicator];
        
        [session POST:Url parameters:temParameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [BLNetWork stopstatusbarIndicator];
            
            NSDictionary * dic = [NSMutableDictionary dictionary] ;
            if([responseObject length]>0)
            {
                dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            }
            
            BLNetWorkResult *netResult= [[BLNetWorkResult alloc] initWithDictionary:dic];
            [netResult setResult_code:eNetStatusCodeSUCC];//自定义接口 不按原接口走
        
            
            if(_getNetworkResultBlock)
            {
                _getNetworkResultBlock(netResult);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [BLNetWork stopstatusbarIndicator];
            if(_getNetworkResultBlock)
            {
                _getNetworkResultBlock(self.errorResult);
            }
        }];
        

        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}






#pragma mark- 获取md5验证码
/** 获取新的md5验证码*/
-(void)getnewMd5key:(NSString*)message Parameters:(NSDictionary *)temParameters showwithstring:(NSString*)showstring showinview:(UIView*)showview showerrortag:(BOOL)tag precheckstate:(BOOL)check treatblock:(TreateBlock)treat
{
//    BTNetWork *network = [[BTNetWork alloc] init];
//    
//    network.getNetworkResultBlock = ^(BLNetWorkResult *temResult){
//        
//        if (temResult.result_code == eNetStatusCodeSUCC)
//        {
//            if(temResult.result_json&& [temResult.result_json isKindOfClass:[NSDictionary class]])
//            {
//                NSString * key = temResult.result_json[@"key"];
//                
//                [[BTManager shareManager] setUserinfo:key forkey:ApiSecretCode];
//            }
//        }
//    };
//    
//    [network Tongyongjiekou:Sys_VersionKey Parameters:temParameters showloader:NO];
}
#pragma mark- 加载statusbar样式
static NSMutableArray* loadingtag=nil;

/** 开启顶部状态栏加载动画*/
+(void)starttatusbarIndicator
{
    
    if(loadingtag==nil)
    {
        loadingtag = [NSMutableArray array];
    }
    
    [loadingtag addObjectSafe:@""];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}

/** 停止顶部状态栏加载动画*/
+(void)stopstatusbarIndicator
{
    
    if(loadingtag.count >0)
    {
        [loadingtag removeLastObject];
    }
    
    if(loadingtag.count == 0)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

#pragma mark- https cer 
+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ykd365" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    NSString *cerPath2 = [[NSBundle mainBundle] pathForResource:@"camore" ofType:@"cer"];//证书的路径
    NSData *certData2 = [NSData dataWithContentsOfFile:cerPath2];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
//    securityPolicy.pinnedCertificates = @[certData];
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:certData,certData2, nil];
    return securityPolicy;
}


@end
