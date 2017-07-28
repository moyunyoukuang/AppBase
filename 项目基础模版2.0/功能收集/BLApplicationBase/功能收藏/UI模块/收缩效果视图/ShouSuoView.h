//
//  ShouSuoView.h
//  ShouSuoTest
//
//  Created by camore on 17/2/6.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>

//每秒帧数
#define ShouSuoViewZhenPreSecond 30

@interface ShouSuoView : UIView

/** 收缩视图到点
 @param shousuo yes收缩 no 放
 */
-(void)shouSuo:(BOOL)shousuo View:(UIView*)view_shousuo toPoint:(CGPoint)point finishBlcok:(void(^)())finishblock;

@end
