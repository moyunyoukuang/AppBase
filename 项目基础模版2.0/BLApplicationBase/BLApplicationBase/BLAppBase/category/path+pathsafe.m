//
//  UIImage+safe.m
//  BLAppBase
//
//  Created by camore on 17/3/3.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "path+pathsafe.h"
#import "objc/runtime.h"
#import "BLFileManager.h"

@implementation UIImage (pathsafe)

//+ (void)load
//{
//    
//
//    
//    // 获取 UIImage 方法 -imageNamed: 的 Method
//    Method original = class_getClassMethod(self, @selector(imageNamed:));
//    
//    // 获取 UIImage+PlaceHolderImage 方法 -replaced_imageNamed: 的 Method
//    Method swizzle = class_getClassMethod(self, @selector(replaced_imageNamed:));
//    
//    // 将两个方法进行交换，现在如果调用 -imageNamed: 则调用的是下方 +replaced_imageNamed: 的实现
//    if( original && swizzle)
//    {
//        method_exchangeImplementations(original, swizzle);
//    }
//
//}
//
//
//
//+ (UIImage *)replaced_imageNamed:(NSString *)imageName
//{
//    // 这里是递归调用吗？不是。因为现在调用 +replaced_imageNamed: 实现则是苹果框架内的  -imageNamed: 的实现。
//    UIImage *image = [UIImage replaced_imageNamed:imageName];
//    if (!image)
//    {
//        image = [UIImage replaced_imageNamed:@"placeholder_image"];
//    }
//    return image;
//}


+(UIImage *)imageWithContentsOfFileSafe:(NSString *)path
{
    UIImage * image_file = [self imageWithContentsOfFile:path];
    
    if(!image_file)
    {//可能是绝对路径的问题
        path = [[BLFileManager shareManager] correcPath:path];
        image_file = [self imageWithContentsOfFile:path];
    }
    return image_file;
}

@end

@implementation NSData (pathsafe)
+(instancetype)dataWithContentsOfFileSafe:(NSString *)path
{
    NSData * data = [self dataWithContentsOfFile:path];
    if(!data)
    {
        path = [[BLFileManager shareManager] correcPath:path];
        data = [self dataWithContentsOfFile:path];

    }
    return data;
}

@end
