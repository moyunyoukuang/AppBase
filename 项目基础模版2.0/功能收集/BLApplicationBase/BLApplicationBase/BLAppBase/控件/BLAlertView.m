//
//  BLAlertView.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/12.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLAlertView.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性



@interface BLAlertView ()
{
    /***************数据控制***************/
    /** 弹出框底部高度*/
    CGFloat  jumpoutViewCenterY;
    
    /***************视图***************/
}
@end

@implementation BLAlertView



#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 通用视图创建*/
+(instancetype)customView
{
    id view = [[self alloc] initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight)];
    
    return view;

}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if(self)
    {
        
        [self chuShiHuaBLAlertView];
        [self setUpViewsBLAlertView];
    }
    return self;
}

-(void)chuShiHuaBLAlertView
{
    self.alphaClickDissmiss = NO;
    self.autoDissmiss  = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)setUpViewsBLAlertView
{
    
    [self createAllViewBLAlertView];
    

}

#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件

/** 在页面中显示 建议传 view.windows*/
-(void)showInView:(UIView *)view
{
    [self showInView:view animate:NO];
    
}

/** 在页面中显示 建议传 view.windows*/
-(void)showInView:(UIView *)view animate:(BOOL)animate
{
    self.isviewShowed = YES;
    self.alpha = 1 ;
    self.showAtView = view;
    [view addSubview:self];
    [view endEditing:YES];
    [view bringSubviewToFront:self];
    
    if(animate)
    {
        self.alpha = 0 ;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1 ;
        } completion:^(BOOL finished) {
         
        }];
    }
    [self viewShowed];
}

/** 延时隐藏*/
-(void)hideAfterDelay:(CGFloat)time_delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time_delay*NSEC_PER_SEC));
    
    __weak typeof(self) weakself = self;
    dispatch_after(popTime,dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakself;
        [strongSelf dissMissAlertAnimate:strongSelf.autoDissmissAnimate];
    });
    
}

/** 移除操作*/
-(void)dissMissAlert
{
    [self dissMissAlertAnimate:NO];
}

/** 移除操作*/
-(void)dissMissAlertAnimate:(BOOL)animate
{
    
    if(self.DissmissBlock)
    {
        self.DissmissBlock();
    }
    
    
    self.isviewShowed = NO;
    [self endEditing:YES];
    
    [self reportDismiss];
    
    if(animate)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0 ;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else
    {
        [self removeFromSuperview];
    }
    [self viewDissmissed];
}



/** 反馈确定*/
-(void)reportqueDing
{
    if(self.BLAlertViewDelegate && [self.BLAlertViewDelegate respondsToSelector:@selector(BLAlertViewQueding:)])
    {
        [self.BLAlertViewDelegate BLAlertViewQueding:self];
    }
    
    if(self.QueDingBlock)
    {
        self.QueDingBlock();
    }
    if(self.autoDissmiss)
    {
        [self autoDissmissAction];
    }
    
    
}
/** 反馈取消*/
-(void)reportquXiao
{
    if(self.BLAlertViewDelegate && [self.BLAlertViewDelegate respondsToSelector: @selector(BLAlertViewCancel:)])
    {
        [self.BLAlertViewDelegate BLAlertViewCancel:self];
    }
    if(self.QuXiaoBlock)
    {
        self.QuXiaoBlock();
    }
    if(self.autoDissmiss)
    {
        [self autoDissmissAction];
    }
}

/** 反馈选择*/
-(void)reportSelect:(NSInteger)selection content:(id)content
{
    if(!content)
    {
        content = [self.array_selection objectAtIndexSafe:selection];
    }
    
    if(self.BLAlertViewDelegate && [self.BLAlertViewDelegate respondsToSelector: @selector(BLAlertView:select:content:)])
    {
        [self.BLAlertViewDelegate BLAlertView:self select:selection content:content];
    }
    
    ActionBlock block = [self.array_selectionBlock objectAtIndexSafe:selection];
    
    if(block)
    {
        block();
    }
    
    if(self.autoDissmiss)
    {
        [self autoDissmissAction];
    }
}

-(void)reportDismiss
{
    if(self.BLAlertViewDelegate && [self.BLAlertViewDelegate respondsToSelector: @selector(BLAlerViewDissMiss:)])
    {
        [self.BLAlertViewDelegate BLAlerViewDissMiss:self];
    }
}

/** 点击选择后自动隐藏动作*/
-(void)autoDissmissAction
{
    [self dissMissAlertAnimate:self.autoDissmissAnimate];
}

#pragma mark- ********************点击事件********************
/** 点击背景*/
-(void)touchAlphaBack
{
    if(self.alphaClickDissmiss)
    {
        [self dissMissAlert];
    }
    
}

/** 确定操作*/
-(void)queDingClick
{
    [self reportqueDing];
}

/** 取消操作*/
-(void)quXiaoClick
{
    [self reportquXiao];
}


#pragma mark- ********************继承方法********************

/** 视图显示*/
-(void)viewShowed
{

}
/** 视图消失*/
-(void)viewDissmissed
{

}

#pragma mark- ********************代理方法********************
#pragma mark - 键盘发生改变执行
- (void)keyboardWillChange:(NSNotification *)note {
    
    NSDictionary *userInfo = note.userInfo;
    //移动的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //移动到的坐标
    CGRect keyFrame  = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self judgeJumpoutViewBottom:keyFrame.origin.y animateTime:duration];
}
/** 判断弹出视图的最底部位置*/
-(void)judgeJumpoutViewBottom:(CGFloat)bottom animateTime:(CGFloat)time_animate
{

    [UIView animateWithDuration:time_animate animations:^{
        
        if(  ScreenHeight - bottom > 10)
        {//弹出键盘
            self.jumpOut_view.bottom = bottom;
        }
        else
        {//缩回
            self.jumpOut_view.centerY = jumpoutViewCenterY;
        }
    }];
}

#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建黑色背景*/
-(void)createAllViewBLAlertView
{
    /** 设置黑色背景*/
    self.backblack_view = [[BLView alloc] initWithFrame:self.bounds];
    self.backblack_view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    [self.backblack_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAlphaBack)]];
    [self addSubview:self.backblack_view];
    
    ///弹出框
    self.jumpOut_view = [self createJumpoutView];
    if(self.jumpOut_view)
    {
        jumpoutViewCenterY = self.jumpOut_view.centerY;
        [self addSubview:self.jumpOut_view];
    }
    else
    {
        jumpoutViewCenterY = self.height/2;
    }
    
    
}

/** 创建弹出框*/
-(UIView*)createJumpoutView
{
    return nil;
}

#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************


@end
