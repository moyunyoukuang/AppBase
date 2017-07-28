//
//  BLFileManager.h
//  deLaiSu
//
//  Created by camore on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <Foundation/Foundation.h>



/** 文件管理器 BLFileManager 是为了方便保存文件，管理文件而存在的*/
@interface BLFileManager : NSObject

+(instancetype)shareManager;

#pragma  mark- 路径操作

/** 文件路径是目录*/
-(BOOL)isFilePathDirectory:(NSString*)path;

/** 文件是否存在*/
-(BOOL)isFileExistAtPath:(NSString*)path;

/** 创建文件路径
 @param paths  "path1""path2""path3"  path/path1/path2/path3
 */
-(NSString*)createPathUnderPath:(NSString*)path  paths:(NSArray*)paths;

/** 创建文件路径
 @param name  "file1","directory/file1"
 */
-(NSString*)createPathUnderPath:(NSString*)path  name:(NSString *)name;

/** catch文件夹下的路径
 @param name  "file1","directory/file1"
 */
-(NSString*)createPathUnderCatch:(NSString *)name;

/** 获取文件夹下文件目录*/
-(NSArray*)getPathListUnderDirectory:(NSString*)path_Directory;

/** 获取catch文件夹路径*/
-(NSString*)getPathForCatch;

/** 转换为当前的路径 (有时候根路径会变，所有绝对路径会不准，这里处理一下,将路径纠正)*/
-(NSString*)correcPath:(NSString*)path;

#pragma  mark- 文件操作

/** 保存文件*/
-(void)saveData:(NSData*)data toPath:(NSString*)path;

/** 读取文件*/
-(NSData*)readDataFromPath:(NSString*)path;

/** 删除文件*/
-(void)deleteFile:(NSString*)path;

/** 删除文件夹*/
-(void)deleteDirectory:(NSString*)path;


@end
