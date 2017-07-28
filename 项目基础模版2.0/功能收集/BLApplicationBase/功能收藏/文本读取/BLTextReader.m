//
//  BLTextReader.m
//  BLAppBase
//
//  Created by camore on 2017/6/5.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLTextReader.h"
#import "UniversalDetector.h"


@implementation BLTextReader

-(NSString*)ReadFileWithPath:(NSString*)path
{
    return [BLTextReader ReadFileWithPath:path];
}
/** 从路径读取文件*/
+(NSString*)ReadFileWithPath:(NSString*)path
{
    if(!path)
    {
        return nil;
    }
    
    NSString * string_result = nil;
    
    string_result = [self ReadFileWithReadEncodingPath:path];
    if(!string_result)
    {
        string_result = [self ReadFileWithNoEncodingPath:path];
    }
    
    if(!string_result)
    {
       
        string_result = [[NSAttributedString alloc] initWithFileURL:[NSURL fileURLWithPath:path] options:[[NSDictionary alloc] init] documentAttributes:nil error:nil].string;
    }
    return string_result;
    
}


/** 从路径读取文件 (无编码)*/
+(NSString*)ReadFileWithReadEncodingPath:(NSString*)path
{
    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
    NSStringEncoding enc;
    @try {
        CFStringEncodings encode= [UniversalDetector detectEncoding:data];
        enc=    CFStringConvertEncodingToNSStringEncoding(encode);
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    NSError *error = nil;
    NSString *aString = [NSString stringWithContentsOfFile:path encoding:enc  error:&error];
    
    if(aString.length > 0 && !error)
    {
        return aString;
    }
    
    
    return nil;
    
}

/** 从路径读取文件 (无编码,从编码列表中挨个试文本)*/
+(NSString*)ReadFileWithNoEncodingPath:(NSString*)path
{
    
        
        NSArray *arrEncoding = @[@(NSASCIIStringEncoding),
                                 @(NSNEXTSTEPStringEncoding),
                                 @(NSJapaneseEUCStringEncoding),
                                 @(NSUTF8StringEncoding),
                                 @(NSISOLatin1StringEncoding),
                                 @(NSSymbolStringEncoding),
                                 @(NSNonLossyASCIIStringEncoding),
                                 @(NSShiftJISStringEncoding),
                                 @(NSISOLatin2StringEncoding),
                                 @(NSUnicodeStringEncoding),
                                 @(NSWindowsCP1251StringEncoding),
                                 @(NSWindowsCP1252StringEncoding),
                                 @(NSWindowsCP1253StringEncoding),
                                 @(NSWindowsCP1254StringEncoding),
                                 @(NSWindowsCP1250StringEncoding),
                                 @(NSISO2022JPStringEncoding),
                                 @(NSMacOSRomanStringEncoding),
                                 @(NSUTF16StringEncoding),
                                 @(NSUTF16BigEndianStringEncoding),
                                 @(NSUTF16LittleEndianStringEncoding),
                                 @(NSUTF32StringEncoding),
                                 @(NSUTF32BigEndianStringEncoding),
                                 @(NSUTF32LittleEndianStringEncoding)
                                 ];
        
        NSArray *arrEncodingName = @[@"NSASCIIStringEncoding",
                                     @"NSNEXTSTEPStringEncoding",
                                     @"NSJapaneseEUCStringEncoding",
                                     @"NSUTF8StringEncoding",
                                     @"NSISOLatin1StringEncoding",
                                     @"NSSymbolStringEncoding",
                                     @"NSNonLossyASCIIStringEncoding",
                                     @"NSShiftJISStringEncoding",
                                     @"NSISOLatin2StringEncoding",
                                     @"NSUnicodeStringEncoding",
                                     @"NSWindowsCP1251StringEncoding",
                                     @"NSWindowsCP1252StringEncoding",
                                     @"NSWindowsCP1253StringEncoding",
                                     @"NSWindowsCP1254StringEncoding",
                                     @"NSWindowsCP1250StringEncoding",
                                     @"NSISO2022JPStringEncoding",
                                     @"NSMacOSRomanStringEncoding",
                                     @"NSUTF16StringEncoding",
                                     @"NSUTF16BigEndianStringEncoding",
                                     @"NSUTF16LittleEndianStringEncoding",
                                     @"NSUTF32StringEncoding",
                                     @"NSUTF32BigEndianStringEncoding",
                                     @"NSUTF32LittleEndianStringEncoding"
                                     ];
        
        for (int i = 0 ; i < [arrEncoding count]; i++) {
            
            @autoreleasepool {
            
            unsigned long encodingCode = [arrEncoding[i] unsignedLongValue];
            
            NSError *error = nil;
            NSString *filePath = path; // <---这里是要查看的文件路径
            NSString *aString = [NSString stringWithContentsOfFile:filePath encoding:encodingCode  error:&error];
                
                if(aString.length > 0 && !error)
                {
                    return aString;
                }
//            NSLog(@"Error:%@", [error localizedDescription]);
//            NSData *data = [aString dataUsingEncoding:encodingCode];
//            NSString *string = [[NSString alloc] initWithData:data encoding:encodingCode];
//            NSLog(@"%@", string);
            
            /*
             // 如果有必要，还可以把文件创建出来再测试
             [string writeToFile:[NSString stringWithFormat:@"/Users/dlios1/Desktop/%@.xml", arrEncodingName[i]]
             atomically:YES
             encoding:encodingCode
             error:&error];
             */
                
            }
                
        }
    
    return nil;
}

@end
