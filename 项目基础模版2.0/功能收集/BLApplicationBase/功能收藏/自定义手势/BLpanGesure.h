//
//  BLpanGesure.h
//  DaJiShi
//
//  Created by camore on 16/4/20.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
/** 滑动手势 可设定方向 */
@interface BLpanGesure : UIPanGestureRecognizer

/** 手势起始*/
@property ( nonatomic , readwrite ) CGPoint startPoint;

/** 识别类型 1 左右 2 上下 3 全部*/
@property ( nonatomic , readwrite ) int type;

/** 最左点*/
@property (nonatomic , readwrite )CGPoint point_mostLeft;

/** 最右点*/
@property (nonatomic , readwrite )CGPoint point_mostRight;

/** 最高点*/
@property (nonatomic , readwrite )CGPoint point_mostTop;

/** 最低点*/
@property (nonatomic , readwrite )CGPoint point_mostDown;

/** 当前点击位置*/
@property (nonatomic , readwrite )CGPoint point_current;

/** 当前的位置在视图内部*/
@property (nonatomic , readwrite )BOOL    currentPointInView;

/** 可用区域 点击区域外，都不视为有效*/
@property ( nonatomic , readwrite ) NSRange avaliableRange;

/** 设置手势识别失败*/
-(void)setFail;

///辅助
/** 新的序列*/
@property ( nonatomic , readwrite ) BOOL  newLoop;
/** 辅助字段*/
@property ( nonatomic , readwrite ) BOOL  state_fuzhu1;
/** 辅助字段*/
@property ( nonatomic , readwrite ) NSInteger  state_fuzhu_int1;
@end
