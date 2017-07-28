//
//  BLVC.h
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BLViews.h"


///标题栏
//返回按钮字体
#define NaviButtonFontSize  text_size_Main

//标题字体颜色
#define NaviTitleColor      color_text_main_black
//标题栏颜色
#define NaviColor           COLOR(246, 247, 248)
//标题栏高度
#define NaviHeight          (StatusHeight + BiLiH(57))
 
//底部 tabbar 高度
#define TabBarHeight        49


//返回按钮设置
#define BACKX BiLiH(2)
#define BACKY StatusHeight
#define BACKW BiLiH(57)
#define BACKH BiLiH(57)

#define BACKButtonRect  CGRectMake(BACKX, BACKY, BACKW, BACKH)
#define RightButtonRect CGRectMake(ScreenWith-BACKX-BACKW, BACKY, BACKW, BACKH)


#define StatusHeight 20

@class BLVC;

@protocol BLVCActionDelegate <NSObject>
@optional
/** 视图返回*/
-(void)BLVCViewBack:(BLVC*)VC;

@end


/** */
@interface BLVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

#pragma mark- 数据

/** 页面唯一tag值，每个页面都不一样，用来禁止其它页面显示弹出提示 自动设置，不用管*/
@property ( nonatomic , readwrite )NSInteger      controllerTag;
/** 视图动作代理*/
@property ( nonatomic , weak ) id <BLVCActionDelegate> BLVCActionDelegate;
/** 返回时是否返回到根视图 yes:返回到根视图(首页) no:返回到前一视图*/
@property ( nonatomic , readwrite ) BOOL     backToRoot;
/** 侧滑返回能否返回，用于区别个别页面 为YES时表示不能侧滑返回 主要用于 代理方法在返回时间调用的界面 */
@property ( nonatomic , readwrite ) BOOL     cancelSideslip;
/** 自动隐藏键盘 默认yes*/
@property ( nonatomic , readwrite ) BOOL     autoHideKeyboard;
/** 页面已经加载 viewdidload加载完成 至第一次出现*/
@property ( nonatomic , readwrite ) BOOL    pageLoadAlready;
/** 页面第一次出现  appear（未出现，至出现结束）*/
@property ( nonatomic , readwrite ) BOOL    viewFirstAppear;



#pragma mark- —————————————————————— 页面相关——————————————————————

/** naviview*/
@property ( nonatomic, strong ) UIView      *naviView;
/** 顶部title视图*/
@property ( nonatomic, strong ) UILabel     *titleLabel;
/** 返回按钮*/
@property ( nonatomic, strong ) BLButton    *backButton;
/** 左边按钮 默认同反回按钮*/
@property ( nonatomic, strong ) BLButton    *leftButton;
/** 右边按钮 默认隐藏*/
@property ( nonatomic ,strong ) BLButton    *rightButton;


/** 设置title*/
-(void)setTitle:(NSString *)title;
/** 隐藏返回按钮*/
-(void)setBackBtnHidden:(BOOL)hidden;
/** 隐藏标题栏*/
-(void)setNaviViewHiddent:(BOOL)hidden;
/** 隐藏键盘*/
- (void)hideKeyBoard;



#pragma mark- 快捷信息提示
/** 弹出提示消息*/
-(BLMessagepop *)showtagMessage:(NSString*)message;



#pragma mark- 显示加载中
-(void)showLoadingView:(BOOL)show;

#pragma mark- 功能方法
/** 暂停视图中的点击1s*/
-(void)delayTouchForSecond;

#pragma mark- 结构方法接口

/** 视图是否可见 (视图已经展示出来，通过appear接口判断)*/
-(BOOL)isVCvisiable;

/** 左边按钮点击*/
-(void)leftButtonClick;

/** 右边按钮点击*/
- (void)rightButtonClick;


/** 返回上一视图*/
- (void)popBack;
/** 反馈返回*/
-(void)reportPopBack;

/** 返回操作
 @param animate 是否带动画
 */
- (void)popBackAnimate:(BOOL)animate;





@end
