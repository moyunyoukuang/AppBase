//
//  AppDelegate.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/11.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "AppDelegate.h"
#import "BLNavigationVC.h"
#import "AppVC.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface AppDelegate ()
{
    /***************数据控制***************/
    
    /***************视图***************/
}
@end

@implementation AppDelegate

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    [self showWindows];
    
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







#pragma mark- ********************调用事件********************
#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************

#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图

//显示界面
-(void)showWindows
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [AppManager shareManager].mainWindows = self.window;
    
    AppVC * VC = [[AppVC alloc] init];
    VC.view.backgroundColor = WHITE;
    BLNavigationVC * navi = [[BLNavigationVC alloc] initWithRootViewController:VC];
    [AppManager shareManager].mainNavi = navi;
    [AppManager shareManager].currentNavi = navi;
    [AppManager shareManager].mainVC = VC;
    [self.window setRootViewController:navi];
    
    [self.window makeKeyAndVisible];
}

#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 被调用的功能

#pragma mark- ********************跳转其他页面********************

@end
