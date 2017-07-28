//
//  UIImage+safe.h
//  BLAppBase
//
//  Created by camore on 17/3/3.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (pathsafe)

+(UIImage *)imageWithContentsOfFileSafe:(NSString *)path;

@end

@interface NSData (pathsafe)

+(instancetype)dataWithContentsOfFileSafe:(NSString *)path;

@end

