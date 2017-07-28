//
//  BLSwitchView.h
//  BLApplicationBase
//
//  Created by camore on 2017/7/17.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLViews.h"

@class BLSwitchView;
@protocol BLSwitchViewDelegate <NSObject>

-(void)BLSwitchViewStateChanged:(BLSwitchView*)view toState:(NSInteger)state;

@end


/** 开关状态视图 (用于定义此类视图的基本行为)*/
@interface BLSwitchView : BLView
{
    /** 当前状态 0 关 1开*/
    NSInteger currentState;
}

@property (nonatomic ,weak) id<BLSwitchViewDelegate> BLSwitchViewDelegate;

/** 当前的状态*/
- (NSInteger)currentState;

/** 设置当前的状态
 @param animat  是否是动画
 */
- (void)setcurrentState:(NSInteger)state animat:(BOOL)animat;

///接口调用
/** 反馈状态变化*/
-(void)reportStateChange;

@end
