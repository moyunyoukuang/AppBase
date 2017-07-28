//
//  UIFont+safe.m
//  DaJiShi
//
//  Created by camore on 16/12/30.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "UIFont+safe.h"
#import "objc/runtime.h"

@implementation UIFont (safe)

+ (void)load {
    

    
    ///交换方法，使可以调用覆盖前的方法
    Method original, swizzle;
    
    original = class_getClassMethod(self, @selector(systemFontOfSize:));
    swizzle  = class_getClassMethod(self, @selector(swizzle_systemFontOfSize:));
    if( original && swizzle)
    {
        method_exchangeImplementations(original, swizzle);
    }
    
}



+(UIFont *)swizzle_systemFontOfSize:(CGFloat)fontSize
{
    
    //设置项目字体
    UIFont* font =  [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
    
    
    if(font == nil)
    {
        font = [self swizzle_systemFontOfSize:fontSize];
    }
    
    return font;
}


//+(void)getfontName
//{
//    
////    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
////    NSArray* fontFiles = [infoDict objectForKey:@"UIAppFonts"];
////    
////    for (NSString *fontFile in fontFiles) {
////        NSLog(@"file name: %@", fontFile);
////        NSURL *url = [[NSBundle mainBundle] URLForResource:fontFile withExtension:NULL];
////        NSData *fontData = [NSData dataWithContentsOfURL:url];
////        CGDataProviderRef fontDataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
////        CGFontRef loadedFont = CGFontCreateWithDataProvider(fontDataProvider);
////        NSString *fullName = CFBridgingRelease(CGFontCopyFullName(loadedFont));
////        CGFontRelease(loadedFont);
////        CGDataProviderRelease(fontDataProvider);
////        NSLog(@"font name: %@", fullName);
////    }
//    
////    PingFang ExtraLight
////    PingFang Light
//    NSArray *familyNames =[[NSArray alloc]initWithArraySafe:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//   
//    for(indFamily=0;indFamily<[familyNames count];++indFamily)
//        
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndexSafe:indFamily]);
//        fontNames =[[NSArray alloc]initWithArraySafe:[UIFont fontNamesForFamilyName:[familyNames objectAtIndexSafe:indFamily]]];
//        
//        for(indFont=0; indFont<[fontNames count]; ++indFont)
//            
//        {
//            NSLog(@"Font name: %@",[fontNames objectAtIndexSafe:indFont]);
//        }
//
//    }
//
////    Family name: PingFang TC
////     PingFangTC-Medium
////     PingFangTC-Regular
////     PingFangTC-Light
////     PingFangTC-Ultralight
////     PingFangTC-Semibold
////     PingFangTC-Thin
//    
//    //    PingFangTC-Light
////    Family name: PingFang HK
////    PingFangHK-Ultralight
////    PingFangHK-Semibold
////    PingFangHK-Thin
////    PingFangHK-Light
////    PingFangHK-Regular
////    PingFangHK-Medium
//    
////    Family name: PingFang SC
////    .PingFang-SC-UltraLight
////     .PingFang-SC-Thin
////     PingFangSC-Ultralight
////     PingFangSC-Regular
////     PingFangSC-Semibold
////     PingFangSC-Thin
////     PingFangSC-Light
////     PingFangSC-Medium
//    
////    Font name: PingFangSC-Ultralight
////    2016-12-30 18:23:45.675 DaJiShi[6415:2738196] Font name: PingFangSC-Regular
////    2016-12-30 18:23:45.675 DaJiShi[6415:2738196] Font name: PingFangSC-Semibold
////    2016-12-30 18:23:45.676 DaJiShi[6415:2738196] Font name: PingFangSC-Thin
////    2016-12-30 18:23:45.676 DaJiShi[6415:2738196] Font name: PingFangSC-Light
////    2016-12-30 18:23:45.676 DaJiShi[6415:2738196] Font name: PingFangSC-Medium
//    
//    //导入字体带.
//    
//    
//    UIFont* font =  [UIFont fontWithName:@"PingFangSC-Light" size:10];
//    
//    
//    if(font == nil)
//    {
//       font = [UIFont systemFontOfSize:10];
//    }
//}

@end
