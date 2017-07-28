//
//  BallShadowView.h
//  DrawSelection
//
//  Created by camore on 17/2/9.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 球形阴影视图 拖拉效果*/
@interface BallShadowView : UIView

/** 中心区域大小 越小，拖拉的效果越尖*/
@property ( nonatomic , readwrite ) CGFloat centerRadius;

/** 外围区域大小*/
@property ( nonatomic , readwrite ) CGFloat outerRadius;

/** 当前所在点*/
@property (nonatomic , readwrite ) CGPoint currentPoint;

/** 拖拽所在点*/
@property (nonatomic , readwrite ) CGPoint dragPoint;

/** 最长拖拽距离 (影响拖拽效果：伸缩比)*/
@property (nonatomic , readwrite ) CGFloat longgiesDragLength;

/** 视图是否显示出来了 yes 圆 no 点*/
@property (nonatomic , readwrite ) BOOL isViewShowded;

/** 显示视图 隐藏视图(放大缩小效果)*/
-(void)showView:(BOOL)show animate:(BOOL)animate;

/** 移动视图*/
-(void)moveViewToPoint:(CGPoint)point animate:(BOOL)animate;

/** 拖拉视图*/
-(void)DragViewToPoint:(CGPoint)point;

/** 爆炸效果*/
-(void)exPloreSelecteion;
@end
