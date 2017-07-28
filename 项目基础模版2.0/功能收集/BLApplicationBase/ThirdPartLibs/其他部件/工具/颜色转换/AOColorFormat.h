//
//  AOColorFormat.h
//  ZbarDemo20141009
//
//  Created by Apple on 14-10-16.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AOColorFormat : NSObject
+(UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;
@end
