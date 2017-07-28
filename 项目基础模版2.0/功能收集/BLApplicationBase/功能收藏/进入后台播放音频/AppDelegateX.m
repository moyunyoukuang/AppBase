//
//  AppDelegateX.m
//  BLFunction
//
//  Created by camore on 2017/7/18.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "AppDelegateX.h"
#import <AVFoundation/AVFoundation.h>
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@implementation AppDelegateX
{
    /***************数据控制***************/
    /** 背景播放音频*/
    AVAudioPlayer *player;
    
    /** 后台播放id*/
    UIBackgroundTaskIdentifier   _bgTaskId;
    
    BOOL  _played;
    
    /***************视图***************/
    
}


#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterreption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    
    
    return YES;
}





#pragma mark- ********************调用事件********************
#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self backGroundPlay];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

        [player stop];
}

-(void)applicationWillResignActive:(UIApplication *)application
{
//    //开启后台处理多媒体事件
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession * session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    _bgTaskId = [self backgroundPlayerID:_bgTaskId];
    //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
}

-(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    //设置并激活音频会话类别
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
//    //允许应用程序接收远程控制
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
    newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}


-(void)handleInterreption:(NSNotification *)sender
{
    if(_played)
    {
        [player pause];
        _played=NO;
    }
    else
    {
        [player play];
        _played=YES;
    }
}





#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************


#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 被调用的功能
-(void)backGroundPlay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        const char bytes[] = {0x52, 0x49, 0x46, 0x46, 0x26, 0x0, 0x0, 0x0, 0x57, 0x41, 0x56, 0x45, 0x66, 0x6d, 0x74, 0x20, 0x10, 0x0, 0x0, 0x0, 0x1, 0x0, 0x1, 0x0, 0x44, 0xac, 0x0, 0x0, 0x88, 0x58, 0x1, 0x0, 0x2, 0x0, 0x10, 0x0, 0x64, 0x61, 0x74, 0x61, 0x2, 0x0, 0x0, 0x0, 0xfc, 0xff};
        NSData* data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
        NSString * docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        // Build the path to the database file
        NSString * filePath = [[NSString alloc] initWithString:
                               [docsDir stringByAppendingPathComponent: @"background.wav"]];
        [data writeToFile:filePath atomically:YES];
        NSURL *soundFileURL = [NSURL fileURLWithPath:filePath];
        //        OSStatus osStatus;
        NSError * error;
        //        NSString *version = [[UIDevice currentDevice] systemVersion];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: &error];
        
        //        if([version floatValue] >= 6.0f)
        //        {
        //
        //            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        //            [[AVAudioSession sharedInstance] setActive: YES error: &error];
        //
        //        }
        //        else
        //        {
        //            osStatus = AudioSessionSetActive(true);
        //
        //            UInt32 category = kAudioSessionCategory_MediaPlayback;
        //            osStatus = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
        //
        //            UInt32 allowMixing = true;
        //            osStatus = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof (allowMixing), &allowMixing );
        //        }
        [player stop];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        player.volume = 0.01;
        player.numberOfLoops = -1; //Infinite
        [player prepareToPlay];
        [player play];
        
        
    });
}



#pragma mark- ********************跳转其他页面********************


@end
