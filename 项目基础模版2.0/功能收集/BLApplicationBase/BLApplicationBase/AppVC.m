//
//  AppVC.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/11.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "AppVC.h"
#import "BLCheckVersion.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface AppVC ()
{
    /***************数据控制***************/
    
    /***************视图***************/
}
@end

@implementation AppVC



#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BLCheckVersion shareManager] checkforUpadaDayly];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self chuShiHua];

    [self setUpViews];

//    [self showLoadingView:YES];
//    [self showtagMessage:@"testmessage"];
}

-(void)chuShiHua
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
//    [self showtagMessage:@"testmessage"];
    
//    BLSelectionInfoModel * model_message = [[BLSelectionInfoModel alloc] init];
//    model_message.title = @"发现新的版本";
//    model_message.content = @"发现新的版本";
//    
//    BLSelectionpop * pop_selection = [BLSelectionpop customView];
//    [pop_selection showMessageType:BLSelectionTypeMessage contentInfo:model_message];
//    [pop_selection showInView:[BLManager shareManager].mainWindows];
    
    
//    NSString * net = [[BLManager shareManager] wangluo];
//    NSLog(@"net = %@",net);
    
    
    
}

-(void)setUpViews
{
    [self setTitle:@""];

    [self createNavi];

    [self createAllView];

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
/** 创建navi*/
-(void)createNavi
{

}

/** 创建所有视图*/
-(void)createAllView
{


}

#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 被调用的功能



#pragma mark- ********************跳转其他页面********************

@end
