//
//  NSString+Utility.m
//  CloudManager
//
//  Created by xiulian.yin on 15/4/12.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import "NSString+Utility.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import "objc/runtime.h"

@implementation NSString (Utility)




- (NSString *)MD5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (uint32_t)strlen(cStr), result );
    NSString *md5string= [NSString stringWithFormat:
                          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                          ];
    
    return md5string;
    
//    // 分配MD5结果空间
//    uint8_t *md5Bytes = malloc(CC_MD5_DIGEST_LENGTH * sizeof(uint8_t));
//    if(md5Bytes)
//    {
//        memset(md5Bytes, 0x0, CC_MD5_DIGEST_LENGTH);
//        
//        // 计算hash值
//        NSData *srcData = [self dataUsingEncoding:NSUTF8StringEncoding];
//        CC_MD5((void *)[srcData bytes], (CC_LONG)[srcData length], md5Bytes);
//        
//        // 组建String
//        NSMutableString* destString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        {
//            [destString appendFormat:@"%02X", md5Bytes[i]];
//        }
//        
//        // 释放空间
//        free(md5Bytes);
//        
//        return destString;
//    }
//    
//    return nil;
}


- (CGSize)sizeWithFontCompatible:(UIFont *)font
{
    if([self respondsToSelector:@selector(sizeWithAttributes:)] == YES)
    {
        NSDictionary *dictionaryAttributes = @{NSFontAttributeName:font};
        CGSize stringSize = [self sizeWithAttributes:dictionaryAttributes];
        return CGSizeMake(ceil(stringSize.width), ceil(stringSize.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

- (CGSize)sizeWithFontCompatible:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)] == YES)
    {
        NSDictionary *dictionaryAttributes = @{NSFontAttributeName:font,};
        
        CGRect stringRect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine
                                            attributes:dictionaryAttributes
                                               context:nil];
        
        CGFloat widthResult = stringRect.size.width;
        if(widthResult - width >= 0.0000001)
        {
            widthResult = width;
        }
        
        return CGSizeMake(widthResult, ceil(stringRect.size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font forWidth:width lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
}

- (CGSize)sizeWithFontCompatible:(UIFont *)font constrainedToSize:(CGSize)size
{
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)] == YES)
    {
        NSDictionary *dictionaryAttributes = @{NSFontAttributeName:font};
        CGRect stringRect = [self boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:dictionaryAttributes
                                               context:nil];
        
        return CGSizeMake(ceil(stringRect.size.width), ceil(stringRect.size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
}




- (CGSize)sizeWithFontCompatible:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)] == YES)
    {
        NSDictionary *dictionaryAttributes = @{NSFontAttributeName:font,};
        CGRect stringRect = [self boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:dictionaryAttributes
                                               context:nil];
        
        return CGSizeMake(ceil(stringRect.size.width), ceil(stringRect.size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
}




#pragma mark-  正则表达式

/** 获取两个字符之间的文字
 @param stringA 起始
 @param stringB 结束
 */
-  (NSString *) stringBetween:(NSString*)stringA andB:(NSString*)stringB
{
    NSString * matchStirng = @"";
    
    NSString * pattern = [NSString stringWithFormat:@"%@(.*)%@",stringA,stringB];
//    pattern=[pattern stringByReplacingOccurrencesOfString:@"[" withString:@"\\["];
//    pattern=[pattern stringByReplacingOccurrencesOfString:@"]" withString:@"\\]"];

    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0]; //等同于 firstMatch.range --- 相匹配的范围
            //从urlString当中截取数据
            matchStirng = [self substringWithRange:resultRange];
            
        }
    }
    return matchStirng;
}

/** 字符之后所有的字符*/
-  (NSString *) stringAfter:(NSString*)stringA
{
    NSString * matchStirng = @"";
    
    NSString * pattern = [NSString stringWithFormat:@"%@(.*)",stringA];
//    pattern=[pattern stringByReplacingOccurrencesOfString:@"[" withString:@"\\["];
//    pattern=[pattern stringByReplacingOccurrencesOfString:@"]" withString:@"\\]"];
    
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0]; //等同于 firstMatch.range --- 相匹配的范围
            //从urlString当中截取数据
            matchStirng = [self substringWithRange:resultRange];
            
        }
    }
    return matchStirng;

}




@end

@implementation NSMutableString (safe)

-(void)appendStringSafe:(NSString *)aString
{
    if(aString)
    {
        [self appendString:aString];
    }
}

@end

