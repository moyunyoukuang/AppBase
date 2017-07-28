//
//  NSString+Utility.h
//  CloudManager
//
//  Created by xiulian.yin on 15/4/12.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utility)



/** 对字符串进行md5处理*/
- (NSString *)MD5String;

/** 高宽不做限制，返回字符尺寸*/
- (CGSize)sizeWithFontCompatible:(UIFont *)font;

/** 限制最大宽度，多行的情况下只计算一行的高度*/
- (CGSize)sizeWithFontCompatible:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFontCompatible:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)sizeWithFontCompatible:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;



#pragma mark-  正则表达式

/** 获取两个字符之间的文字
 @param stringA 起始
 @param stringB 结束
 */
-  (NSString *) stringBetween:(NSString*)stringA andB:(NSString*)stringB;
/** 字符之后所有的字符*/
-  (NSString *) stringAfter:(NSString*)stringA;







@end

@interface NSMutableString (safe)

-(void)appendStringSafe:(NSString *)aString;

@end

