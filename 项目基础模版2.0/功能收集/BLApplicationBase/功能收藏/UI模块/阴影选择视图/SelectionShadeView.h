//
//  SelectionShadeView.h
//  DrawSelection
//
//  Created by camore on 17/2/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//
#import "SelectionShadeButton.h"
#import "BallShadowView.h"
#import <UIKit/UIKit.h>
/** 滑动选择圆点 拉伸效果*/
@interface SelectionShadeView : UIView

@property ( nonatomic , strong ) BallShadowView * shadowView;

/** 视图是否显示出来了 yes 显示 no 隐藏*/
@property ( nonatomic , readwrite ) BOOL isViewShowed;



///下拉设置操作
/** 设置中心点按钮（下拉时会旋转）*/
-(void)setCenterSelectionButton:(SelectionShadeButton*)button;



///平滑设置操作
/** 拖拽*/
-(void)drageToPoint:(CGPoint)dragPoint;

/** 移动视图*/
-(void)moveViewToPoint:(CGPoint)point animate:(BOOL)animate;

/** 设置显示隐藏视图*/
-(void)setShowView:(BOOL)show animate:(BOOL)animate;

/** 爆炸效果*/
-(void)exPloreSelecteion;

/** 设置视图最长伸缩*/
-(void)setLongestShenSuoLength:(CGFloat)length;
@end
