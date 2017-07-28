//
//  BLSwipeGesture.h
//  DaJiShi
//
//  Created by camore on 16/11/8.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSwipeGesture : UISwipeGestureRecognizer

/** 可用区域 点击区域外，都不视为有效*/
@property ( nonatomic , readwrite ) NSRange avaliableRange;

@end
