//
//  BLSwitchView.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/17.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLSwitchView.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface BLSwitchView ()
{
    /***************数据控制***************/
    
    /***************视图***************/
}
@end

@implementation BLSwitchView



#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if(self)
    {
        [self chuShiHuaBLSwitchView];
        [self setUpViewsBLSwitchView];
    }
    return self;
}
-(void)chuShiHuaBLSwitchView
{

}

-(void)setUpViewsBLSwitchView
{

    [self createAllViewBLSwitchView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件

/** 当前的状态*/
- (NSInteger)currentState
{
    return currentState;
}

/** 反馈状态变化*/
-(void)reportStateChange
{
    if([self.BLSwitchViewDelegate respondsToSelector:@selector(BLSwitchViewStateChanged:toState:)])
    {
        [self.BLSwitchViewDelegate BLSwitchViewStateChanged:self toState:currentState];
    }
}

/** 设置当前的状态
 @param animat  是否是动画
 */
- (void)setcurrentState:(NSInteger)state animat:(BOOL)animat
{
    if(currentState != state)
    {
        currentState = state;
    }
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllViewBLSwitchView
{

}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************


@end
