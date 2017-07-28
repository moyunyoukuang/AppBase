//
//  NSObject+Extension.h
//  BLAppBase
//
//  Created by camore on 17/2/28.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/** 当前类的属性列表*/
-(NSArray*)currentPropertyNameList;


/** model*/
@property (nonatomic,strong) id         modelValue;

/** stringvalue1*/
@property (nonatomic,strong) id         stringValue1;

/** stringvalue2*/
@property (nonatomic,strong) id         stringValue2;


@end

///** 交换方法功能 避免问题 */ //放弃使用，不安全，不通用(类族问题)
//void methodSwizzling(Class class,SEL originSel,SEL overrideSel);

