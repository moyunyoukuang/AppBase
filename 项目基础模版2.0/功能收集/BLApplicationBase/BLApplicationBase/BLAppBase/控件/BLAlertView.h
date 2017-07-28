//
//  BLAlertView.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/12.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLViews.h"


@class BLAlertView;

@protocol BLAlertViewDelegate <NSObject>

@optional
/** 取消操作*/
-(void)BLAlertViewCancel:(BLAlertView*)custom;
/** 确定操作*/
-(void)BLAlertViewQueding:(BLAlertView*)custom;
/** 选择操作*/
-(void)BLAlertView:(BLAlertView*)custom select:(NSInteger)selection content:(id)content;
/** 界面消失*/
-(void)BLAlerViewDissMiss:(BLAlertView*)View;

@end


/** 弹出框提示框 提示信息，选择框*/
@interface BLAlertView : BLView

@property ( nonatomic , weak ) id <BLAlertViewDelegate> BLAlertViewDelegate;

/** 点击空白区域消失 默认no */
@property ( nonatomic , readwrite)  BOOL        alphaClickDissmiss;

/** 选择完成后,自动消失*/
@property ( nonatomic , readwrite ) BOOL        autoDissmiss;

/** 自动隐藏时使用动画*/
@property ( nonatomic , readwrite ) BOOL        autoDissmissAnimate;

/** 是否显示出来了*/
@property ( nonatomic , readwrite ) BOOL        isviewShowed;

/** 输入textfield 用来获取输入信息*/
@property ( nonatomic , strong ) UITextField *  shuRu;

/** 黑色背景*/
@property ( nonatomic , strong ) BLView     *   backblack_view;

/** 弹出框*/
@property ( nonatomic , strong ) UIView     *   jumpOut_view;

/** 展示在哪个视图中*/
@property ( nonatomic , weak ) UIView       *   showAtView;

/** 选项*/
@property ( nonatomic , strong ) NSArray    *   array_selection;


////行为动作
/** 确定行为*/
@property ( nonatomic , copy ) ActionBlock  QueDingBlock;

/** 取消行为*/
@property ( nonatomic , copy ) ActionBlock  QuXiaoBlock;

/** 消失行为*/
@property ( nonatomic , copy ) ActionBlock  DissmissBlock;

/** 选择行为*/
@property ( nonatomic , copy ) NSArray <ActionBlock>* array_selectionBlock;

/** 通用视图创建*/
+(instancetype)customView;


/** 在页面中显示 建议传 view.windows*/
-(void)showInView:(UIView *)view;

/** 在页面中显示 建议传 view.windows*/
-(void)showInView:(UIView *)view animate:(BOOL)animate;

/** 延时隐藏*/
-(void)hideAfterDelay:(CGFloat)time_delay;

/** 移除操作*/
-(void)dissMissAlert;

/** 移除操作*/
-(void)dissMissAlertAnimate:(BOOL)animate;

///接口用 定义行为
/** 创建弹出框*/
-(UIView*)createJumpoutView;

/** 确定操作*/
-(void)queDingClick;
/** 取消操作*/
-(void)quXiaoClick;
/** 视图显示*/
-(void)viewShowed;
/** 视图消失*/
-(void)viewDissmissed;


/** 反馈操作*/
-(void)reportqueDing;
/** 反馈操作*/
-(void)reportquXiao;
/** 反馈选择*/
-(void)reportSelect:(NSInteger)selection content:(id)content;
/** 反馈视图消失*/
-(void)reportDismiss;

@end
