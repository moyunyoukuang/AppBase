//
//  BLMessagepop.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/13.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLMessagepop.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface BLMessagepop ()
{
    /***************数据控制***************/
    
    /** 当前视图类型*/
    BLMessageType    currentType;
    
    /***************视图***************/
    
    ///信息视图
    BLLabel         *   lable_message;
    
    
    ///加载中视图
    /** 加载中动画*/
    UIActivityIndicatorView *   loading_indicator_view;
}
@end


@implementation BLMessagepop



#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(void)dealloc
{
    [loading_indicator_view stopAnimating];
}

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
    self.backblack_view.backgroundColor = [UIColor clearColor];
    self.alphaClickDissmiss = NO;
    self.messageLevel = BLTagMessageLevelNomal;
    self.userInteractionEnabled = NO;
    self.autoDissmissAnimate = YES;
}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件

-(void)showMessageType:(BLMessageType)type content:(NSString*)content
{
    [self createViewWihtType:type content:content];
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************

-(void)viewShowed
{
    [super viewShowed];
    [loading_indicator_view startAnimating];
}

-(void)viewDissmissed
{
    [super viewDissmissed];
    [loading_indicator_view stopAnimating];
}

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

-(void)createViewWihtType:(BLMessageType)type content:(NSString*)content
{
    currentType = type;
    switch (type) {
        case BLMessageTypeText:
        {//文本
            if(content.length > 0)
            {
                lable_message = [MyControl creaeteLabelWithString:content Font:[UIFont systemFontOfSize:text_size_content]];
                lable_message.adjustsFontSizeToFitWidth = NO;
                lable_message.textAlignment = NSTextAlignmentCenter;
                lable_message.opaque = NO;
                lable_message.textColor = WHITE;
                lable_message.width     += 15;
                lable_message.height    += 15;
                lable_message.backgroundColor = BLACK;
                [lable_message setCornerRadius:lable_message.height/2.0];
                lable_message.centerY = self.backblack_view.height - self.messageLevel;
                lable_message.centerX = self.backblack_view.width/2;
                [self.backblack_view addSubview:lable_message];
            }
            
            
            
        }
            break;
        case BLMessageTypeLoading:
        {//加载中
            loading_indicator_view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            loading_indicator_view.center = self.backblack_view.center;
            
            [self.backblack_view addSubview:loading_indicator_view];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************

@end
