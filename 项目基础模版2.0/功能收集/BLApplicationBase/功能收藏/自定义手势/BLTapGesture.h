//
//  BLTapGesture.h
//  BLReader
//
//  Created by camore on 2017/6/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLTapGesture : UITapGestureRecognizer
/** 响应范围*/
@property ( nonatomic , readwrite ) CGRect avaliableRect;

/** 手势起始*/
@property (assign) CGPoint startPoint;


@end
