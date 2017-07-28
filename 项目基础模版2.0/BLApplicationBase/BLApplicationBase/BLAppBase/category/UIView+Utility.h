//
//  UIView+Utility.h
//  CloudManager
//
//  Created by xiulian.yin on 15/4/11.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import <UIKit/UIKit.h>







@interface UIView (Utility)

//  将View的左边移动到指定位置
@property (nonatomic) CGFloat left;

//  将View的顶端移动到指定位置
@property (nonatomic) CGFloat top;

//  将View的右边移动到指定位置
@property (nonatomic) CGFloat right;

//  将View的底端移动到指定位置
@property (nonatomic) CGFloat bottom;

//  更改View的宽度
@property (nonatomic) CGFloat width;

//  更改View的高度
@property (nonatomic) CGFloat height;

//  更改View的位置
@property (nonatomic) CGPoint origin;

//  更改View的尺寸
@property (nonatomic) CGSize size;

//  更改View中心点的位置x
@property (nonatomic) CGFloat centerX;

//  更改View中心点的位置x
@property (nonatomic) CGFloat centerY;


// 设置UIView的X == setLeft
- (void)setViewX:(CGFloat)newX;

// 设置UIView的Y == setTop
- (void)setViewY:(CGFloat)newY;

// 设置UIView的Origin == setOrigin
- (void)setViewOrigin:(CGPoint)newOrigin;

// 设置UIView的width == setWidth
- (void)setViewWidth:(CGFloat)newWidth;

// 设置UIView的height == setHeight
- (void)setViewHeight:(CGFloat)newHeight;

// 设置UIView的Size == setSize
- (void)setViewSize:(CGSize)newSize;

// 设置视图的圆角度数
- (void)setCornerRadius:(float)radius;

/** 设置距离父视图的右边距*/ 
- (void)setRightToSuperView:(float)rightDis;





@end
