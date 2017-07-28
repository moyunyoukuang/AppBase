//
//  BLTextReader.h
//  BLAppBase
//
//  Created by camore on 2017/6/5.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** 文本读取 从文件读取文本*/
@interface BLTextReader : NSObject

/** 从路径读取文件*/
+(NSString*)ReadFileWithPath:(NSString*)path;

-(NSString*)ReadFileWithPath:(NSString*)path;

@end
