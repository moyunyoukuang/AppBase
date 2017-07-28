//
//  SelectionShadeView.m
//  DrawSelection
//
//  Created by camore on 17/2/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "SelectionShadeView.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface SelectionShadeView  ()
{
    /***************数据控制***************/
    
    /***************视图***************/
    /** 球形阴影视图*/
    BallShadowView  *   ballShadow;
}


@end

@implementation SelectionShadeView

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

}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件

/** 设置视图最长伸缩*/
-(void)setLongestShenSuoLength:(CGFloat)length
{
    ballShadow.longgiesDragLength = length;
}

/** 设置中心点按钮（下拉时会旋转）*/
-(void)setCenterSelectionButton:(SelectionShadeButton*)button
{
    ballShadow.centerRadius  = button.frame.size.width;
    ballShadow.outerRadius   = button.frame.size.width*1.5;
    
    
    [ballShadow moveViewToPoint:button.center animate:NO];;
   
}



/** 移动视图*/
-(void)moveViewToPoint:(CGPoint)point animate:(BOOL)animate
{
    [ballShadow moveViewToPoint:point animate:animate];
}

/** 拖拽*/
-(void)drageToPoint:(CGPoint)dragPoint
{
    [ballShadow DragViewToPoint:dragPoint];

}

/** 设置显示隐藏视图*/
-(void)setShowView:(BOOL)show animate:(BOOL)animate
{
    [ballShadow showView:show animate:animate];
    
    self.isViewShowed = show;
    
}

/** 爆炸效果*/
-(void)exPloreSelecteion
{
    self.isViewShowed = NO;
    [ballShadow exPloreSelecteion];
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
-(void)createAllView
{
    ballShadow = [[BallShadowView alloc] initWithFrame:self.bounds];

    [ballShadow showView:NO animate:NO];
    [self addSubview:ballShadow];
    
    self.shadowView = ballShadow;
    
    
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************

@end
