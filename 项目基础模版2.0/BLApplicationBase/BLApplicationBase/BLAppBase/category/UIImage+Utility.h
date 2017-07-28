//
//  UIImage+Rotate.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 14-11-14.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;


/** 根据图片拍摄 的方向调整图片*/
- (UIImage *)fixOrientation;

@end


@interface UIImage (Category)
/** 颜色图片*/
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
/** 切割图片*/
- (UIImage*)getSubImage:(CGRect)rect;

/** 缩小图片  到大小asize*/
- (UIImage *)thumbnailWithsize:(CGSize)asize;
@end


