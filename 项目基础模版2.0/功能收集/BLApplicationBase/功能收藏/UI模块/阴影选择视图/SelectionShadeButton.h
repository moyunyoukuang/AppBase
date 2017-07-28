//
//  SelectionShadeButton.h
//  DrawSelection
//
//  Created by camore on 17/2/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 选择拉伸视图按钮*/
@interface SelectionShadeButton : UIView

@property ( nonatomic , readwrite ) BOOL isSelected;

@property ( nonatomic , strong )UIImage * onimage;

@property ( nonatomic , strong )UIImage * offimage;

/** 创建位置*/
@property ( nonatomic , readwrite ) CGRect initFrame;


/** 创建视图 
 @param onimage 选中时的图像
 @param offimage 非选中时的图像
 */
-(instancetype)initWithFrame:(CGRect)frame onImage:(UIImage*)onimage offImage:(UIImage*)offimage;

/** 改变视图的状态*/
-(void)changeStateTo:(BOOL)selected;



@end
