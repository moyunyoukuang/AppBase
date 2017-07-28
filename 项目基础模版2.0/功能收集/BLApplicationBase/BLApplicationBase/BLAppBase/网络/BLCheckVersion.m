//
//  CamoreCheckVersion.m
//  deLaiSu
//
//  Created by camore on 15/7/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//


#import "AppDelegate.h"
#import "BLCheckVersion.h"
#import "BLAlertView.h"


#define PuTongUpDateTag  1200

#define AppstoreUpDateTag 10000
@interface BLCheckVersion()<BLAlertViewDelegate>
{
    /** 获得的服务器升级地址 从服务器获取升级地址时使用*/
    NSString* upadateurl;
    
}

@end



@implementation BLCheckVersion

+(instancetype)shareManager
{
    static  BLCheckVersion * shareBLManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareBLManager = [[self alloc]init];
    });
    
    
    return shareBLManager;
}


/** 每日检查更新 一天最多一次*/
-(void)checkforUpadaDayly
{
    
    NSInteger day = [CommonTool currentday];
    if([[NSUserDefaults standardUserDefaults] integerForKey:usercancelUpdatetimekey] == day) {
        //如果今天检查过了，就不再检查
        return;
    }else{
        [[NSUserDefaults standardUserDefaults] setInteger:day forKey:usercancelUpdatetimekey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self checkforNormalUpdateWithLoader:NO];
        
    }

}

/** 检查普通更新*/
-(void)checkforNormalUpdateWithLoader:(BOOL)loader
{
    if(isAppStore)
    {
        [self checkAppstorewithloader:loader];
    }
    else
    {
        //非appstore 升级判断
    }
    
    
    
}


#pragma mark- appstrore
-(void)checkAppstorewithloader:(BOOL)loader
{

    
    BLMessagepop *hud=nil;
    if(loader)
    {
        UIView* showview = [BLManager shareManager].mainWindows;
        hud = [BLMessagepop customView];
        [hud showMessageType:BLMessageTypeLoading content:nil];
        [hud showInView:showview];
       
    }
    
    
    
    
    NSString *URL = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",APPstoreID];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithStringSafe:URL]];
    
    [request setHTTPMethod:@"POST"];
    
    __weak BLCheckVersion* weakself=self;
    __weak BLMessagepop* weakhud=hud;
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *recervedData, NSError *connectionError) {
       
        if([recervedData length]>0)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableContainers error:nil];
            NSArray *infoArray = [dic objectForKey:@"results"];
            NSString *currentVersion = VERSION_STR;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong BLCheckVersion* strongself=weakself;
                __strong BLMessagepop* stornghud=weakhud;
                [stornghud dissMissAlertAnimate:NO];
                
                if ([infoArray count]>0) {
                    NSDictionary *releaseInfo = [infoArray objectAtIndexSafe:0];
                    NSString *lastVersion = [releaseInfo objectForKey:@"version"];
                    if (![lastVersion isEqualToString:currentVersion] && ([lastVersion floatValue] >[currentVersion floatValue]) ) {

                        
                        BLSelectionInfoModel * model_message = [[BLSelectionInfoModel alloc] init];
                        model_message.title = @"发现新的版本";
                        
                        
                        BLSelectionpop * pop_selection = [BLSelectionpop customView];
                        pop_selection.BLAlertViewDelegate = self;
                        [pop_selection showMessageType:BLSelectionTypeSelection contentInfo:model_message];
                        pop_selection.tag = AppstoreUpDateTag;
                        [pop_selection showInView:[BLManager shareManager].mainWindows];
                        
                        
                        
                        return ;
                    }
                   
                }
                
                
                    if(loader)
                    {
                        [strongself showtagMessage:@"已是最新版本"];
                    }
                
            });

        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               __strong BLCheckVersion* strongself=weakself;
                __strong BLMessagepop* stornghud=weakhud;
                [stornghud dissMissAlertAnimate:NO];
                [strongself showtagMessage:@"未获取到数据，请稍候重试"];
            });
        
        }
        
        
    }];
    
    
}








#pragma mark- BLAlertViewDelegate <NSObject>

-(void)BLAlertViewCancel:(BLAlertView*)custom
{

}

-(void)BLAlertViewQueding:(BLAlertView*)custom
{
    if (custom.tag == PuTongUpDateTag  )//normalUpdate
    {
        if(upadateurl)
        {
            [BLFunction opeUrl:[NSURL URLWithStringSafe:upadateurl]];
          
        }
        
    }
    
    //appstore 更新
    if (custom.tag == AppstoreUpDateTag)//appstore
    {
        NSURL *url = [NSURL URLWithStringSafe:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?ls=1&mt=8",APPstoreID]];
        
         [BLFunction opeUrl:url];
        
    }
}



#pragma mark- tools
/** 显示提示信息*/
-(BLMessagepop *)showtagMessage:(NSString*)message
{
    return [[BLManager shareManager] showtagMessage:message ControllerTag:0];
}




@end
