//
//  DrawSelectionView.h
//  DrawSelection
//
//  Created by camore on 17/2/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//


//http://www.jianshu.com/p/d6b4a9ad022e
#import <UIKit/UIKit.h>
#import "SelectionShadeButton.h"

//动画过程比例 占alpha 过程
//隐藏其他视图 比例
#define  hideOtherViewPercent     0.1
//重置圆球比例 (重置为圆形)
//#define  chongZhiBallPercent      (1.0/4.0)
#define  chongZhiBallPercent      (1.0/2.0)
//隐藏圆球比例
//#define  hideBallPercent          (1.0/2.0)
#define  hideBallPercent          1.0

//手指可滑动范围
#define DrawSelectionViewFingerControlLength  100.0f

//下拉显示的范围
#define DrawSelectionViewShowViewLength       50.0f


/** 滑动操作位置*/
@interface DrawActionPoint : NSObject

/** 开始位置*/
@property ( nonatomic , readwrite ) CGPoint startPoint;

/** 移动位置*/
@property ( nonatomic , readwrite ) CGPoint currentPoint;

/** 结束位置*/
@property ( nonatomic , readwrite ) CGPoint endPoint;

/** 视图移动位置不需要调整*/
@property ( nonatomic , readwrite ) BOOL   noNeedFixPosition;

/** 视图的起始下拉的高度*/
@property ( nonatomic , readwrite ) CGFloat startLocation;

@end


@class DrawSelectionView;
@protocol DrawSelectionViewDelegate <NSObject>
@optional
/** 视图alpha变化 移动时 alpha 变化 下拉长度*/
-(void)DrawSelectionView:(DrawSelectionView*)view changeAlpha:(CGFloat)alpha length:(CGFloat)length;
/** 视图选择某个选项*/
-(void)DrawSelectionView:(DrawSelectionView*)view SelectIndex:(NSInteger)index;
/** 视图选择结束 无论选择还是没选择都会调用*/
-(void)DrawSelectionViewFinish:(DrawSelectionView*)view ;
@end

@protocol DrawSelectionViewControl <NSObject>

///平滑设置操作
/** 开始位置*/
-(void)startAtPoint:(CGPoint)startPoint;
/** 移动点*/
-(void)moveToPoint:(CGPoint)point;
/** 结束移动*/
-(void)endAtPoint:(CGPoint)stopPoint;
@end


/** 下拉选择视图*/
@interface DrawSelectionView : UIView <DrawSelectionViewControl>

@property ( nonatomic , weak ) id <DrawSelectionViewDelegate> DrawSelectionViewDelegate;

/** 所关联的滑动视图*/
@property ( nonatomic , strong ) UIScrollView * associatedScrollView;

/** 滑动手势*/
@property ( nonatomic , strong ) UIPanGestureRecognizer * panGesture;

/** 中心点按钮*/
@property ( nonatomic , readwrite ) NSInteger centerButtonIndexDefault;

/** 动画显示出来了*/
-(BOOL)animating;

/** 设置关联的滑动视图*/
-(void)setAssociateWithScrollView:(UIScrollView*)scrollView;

/** 设置滑动的图像 按顺序，从左到右*/
-(void)addSelectionButton:(SelectionShadeButton*)button;

/** 设置中中心按钮（下拉时会旋转）*/
-(void)setCenterButtonIndex:(NSInteger)index;

@end
