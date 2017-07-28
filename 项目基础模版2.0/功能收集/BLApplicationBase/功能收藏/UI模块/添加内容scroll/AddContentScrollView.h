//
//  AddContentScrollView.h
//  DaJiShi
//
//  Created by camore on 16/6/14.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"
/** 可以添加内容的scrollview*/
@interface AddContentScrollView : BLScrollView

/** 所有视图列表*/
@property ( nonatomic , strong ) NSMutableArray * array_views;

/** 添加视图*/
-(void)addContentView:(UIView*)view;

///** 添加阴影*/
//-(UIView *)addShadow;

/** 添加间隔（空白视图）*/
-(UIView *)addSepForHeight:(NSInteger)height;

/** 插入视图*/
-(void)insertView:(UIView*)view atIndex:(NSInteger)index;

/** 插入视图*/
-(void)insertView:(UIView*)view afterView:(UIView*)view_before;

/** 移除所有视图*/
-(void)removeAllContent;

/** 获取视图的index*/
-(NSInteger)indexForView:(UIView*)view;

/** 重新设置视图位置 在添加修改视图队列后调用*/
-(void)resetViewLocation;

/** 根据内容大小来设置视图大小*/
-(void)resetContentSizeWithSubView;
@end
