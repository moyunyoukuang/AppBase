//
//  BLDrawView.h
//  BaiTang
//
//  Created by camore on 16/4/1.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDrawContext.h"

/**
 BLDrawView 是为了管理文本绘画，页面布局而存在的
 */


/** 绘画器*/
@interface BLDrawView : UIView
/** 手势 （点击）*/
@property ( nonatomic , strong ) NSMutableArray * array_gestures;

/** 绘画文本范围*/
@property ( nonatomic , readwrite ) NSRange         drawTextRange;

/** 设置时*/
-(void)setDrawContext:(BLDrawContext*)context;

/** 当前适合的大小 设置context 之后获取*/
-(CGSize)fitSize;



@end
