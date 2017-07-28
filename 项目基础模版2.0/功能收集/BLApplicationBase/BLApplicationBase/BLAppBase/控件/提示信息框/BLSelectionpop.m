//
//  BLSelectionpop.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/14.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLSelectionpop.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@implementation BLSelectionInfoModel

@end

@interface BLSelectionpop ()
{
    /***************数据控制***************/
    
    /***************视图***************/
}
@end


@implementation BLSelectionpop



#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if(self)
    {
        [self chuShiHua];
        [self setUpViews];
    }
    return self;
}
-(void)chuShiHua
{
    self.alphaClickDissmiss = NO;
    self.autoDissmissAnimate = NO;
}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{

}

/** 显示消息类型*/
-(void)showMessageType:(BLSelectionType)type contentInfo:(BLSelectionInfoModel*)contentInfo
{
    UIView * view = [self createPopView];
    
    switch (type) {
        case BLSelectionTypeMessage:
        {
            [self addTiTleWithView:view content:contentInfo.title];
            [self addContentWithView:view content:contentInfo.content];
            self.alphaClickDissmiss = YES;
            view.userInteractionEnabled = NO;
        }
            break;
        case BLSelectionTypeSelection:
        {
            [self addTiTleWithView:view content:contentInfo.title];
            [self addContentWithView:view content:contentInfo.content];
            [self addConfirmCancelButtonWihtView:view];
            self.alphaClickDissmiss = NO;
            
        }
            break;
        default:
            break;
    }
    
    view.centerX = self.width/2;
    view.centerY = self.height/2;
    [self addSubview:view];
    self.jumpOut_view = view;
    
}

/** 创建弹出框*/
-(UIView*)createPopView
{
    UIView * view_back = [MyControl createViewWithFrame:CGRectMake(0, 0, self.width - SameH(30)*2, 0)];
    view_back.backgroundColor = color_second_view_white;
    [view_back setCornerRadius:4];
    
    return view_back;
}
/** 添加标题*/
-(UIView*)addTiTleWithView:(UIView*)view content:(NSString*)content
{
    if(content.length > 0)
    {
        UILabel * lable_title = [MyControl createLabelWithFrame:CGRectMake(SameH(20), 0, view.width - SameH(20)*2, 40) font:[UIFont systemFontOfSize:text_size_Main] title:content];
        lable_title.top = view.bottom;
        lable_title.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lable_title];
        view.height += lable_title.height;
    }
    
    
    return view;
}

/** 添加内容*/
-(UIView*)addContentWithView:(UIView*)view content:(NSString*)content
{
    if(content.length > 0)
    {
        UILabel * lable_content = [MyControl creaeteLabelWithString:content Font:[UIFont systemFontOfSize:text_size_content] width:view.width - SameH(20)*2];
        lable_content.left = SameH(20);
        lable_content.top = view.bottom;
        lable_content.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lable_content];
        view.height += lable_content.height + SameH(10);//10sep
    }
    
    return view;
}

/** 添加确定取消按钮*/
-(UIView*)addConfirmCancelButtonWihtView:(UIView*)view
{
    
    
    
    {//取消
        UIButton * button = [MyControl createButtonWithFrame:CGRectMake(0, 0, view.width/2, SameH(44)) target:self method:@selector(quXiaoClick)];
        button.top = view.height;
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:BLACK forState:UIControlStateNormal];
        [view addSubview:button];
        view.height += button.height;
        
        //sep
        [MyControl addSepViewWithView:view location:button.top downOrTop:NO];
    }
    
    {//确定
        UIButton * button = [MyControl createButtonWithFrame:CGRectMake(view.width/2, 0, view.width/2, SameH(44)) target:self method:@selector(queDingClick)];
        button.bottom = view.height;
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:BLACK forState:UIControlStateNormal];
        [view addSubview:button];
       
        //sep
        UIView * view_sep = [MyControl createSepViewWithHeight:button.height-1];
        view_sep.left = button.left;
        view_sep.top = button.top -1;
        [view addSubview:view_sep];
        
    }
    
    
    return view;

}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************

@end
