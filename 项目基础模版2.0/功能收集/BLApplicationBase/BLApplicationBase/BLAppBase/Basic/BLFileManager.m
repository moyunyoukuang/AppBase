//
//  BLFileManager.m
//  deLaiSu
//
//  Created by camore on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BLFileManager.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface BLFileManager()


@end

@implementation BLFileManager
#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
+(instancetype)shareManager
{
    static  BLFileManager * shareshopmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareshopmanager = [[BLFileManager alloc]init];
    });
    
    
    return shareshopmanager;
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************调用事件********************

#pragma  mark- 路径操作

/** 文件路径是目录*/
-(BOOL)isFilePathDirectory:(NSString*)path
{
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    
    return isDirectory;
}

/** 文件是否存在*/
-(BOOL)isFileExistAtPath:(NSString*)path
{
    BOOL isExist = NO;
    
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil];
    
    return isExist;

}

/** 创建文件路径
 @param paths  "path1""path2""path3"  path/path1/path2/path3
 */
-(NSString*)createPathUnderPath:(NSString*)path  paths:(NSArray*)paths
{
    /** catch 目录下的文件路径*/
    NSString *cachesDir = path;
    if(path && [paths count] > 0)
    {
        for ( int i = 0 ; i < [paths count] ; i ++ )
        {
            NSString * path_one = [paths objectAtIndex:i];
            
            if(path_one.length > 0 )
            {
                cachesDir = [cachesDir stringByAppendingPathComponent:path_one];
                
                ///创建文件路径
                BOOL isDirectory = NO;
                BOOL exist =  [[NSFileManager defaultManager] fileExistsAtPath:cachesDir isDirectory:&isDirectory];
                if(!isDirectory || !exist)
                {
                    NSError * error;
                    
                    
                    NSDictionary * attribute =  @{
                                                  NSFileAppendOnly:@NO,//NSNumber对象，表示创建的目录是否是只读的
                                                  //                      NSFileCreationDate:[NSDate date],//NSDate对象，表示目录的创建时间
                                                  //                      NSFileOwnerAccountName:@NO,//NSString对象，表示这个目录的所有者的名字
                                                  //                      NSFileGroupOwnerAccountName:@“”,//NSString对象，表示这个目录的用户组的名字
                                                  //                      NSFileGroupOwnerAccountID:[NSNumber numberWithUnsignedInteger:0],//unsigned int的NSNumber对象，表示目录的组ID
                                                  //                      NSFileModificationDate:[NSDate date],//NSDate对象，表示目录的修改时间
                                                  //                      NSFileOwnerAccountID:[NSNumber numberWithUnsignedInteger:0],//unsigned int的NSNumber对象，表示目录的所有者ID
                                                  //                      NSFilePosixPermissions:[NSNumber numberWithShort:0],//short int的NSNumber对象，表示目录的访问权限
                                                  //                      NSFileReferenceCount:[NSNumber numberWithUnsignedLong:0],//unsigned long的NSNumber对象，表示目录的引用计数，即这个目录的硬链接数。
                                                  
                                                  };
                    
                    
                    
                    [[NSFileManager defaultManager] createDirectoryAtPath:cachesDir withIntermediateDirectories:YES attributes:attribute error:&error];
                    
                }
            }
        }
    }
    return cachesDir;
}

/** catch文件夹下的路径
 @param name  "file1","directory/file1"
 */
-(NSString*)createPathUnderPath:(NSString*)path  name:(NSString *)name
{
    NSString * path_create = path;
    
    if(name)
    {
        NSArray * array_path = [name componentsSeparatedByString:@"/"];
        
        path_create = [self createPathUnderPath:path_create paths:array_path];
    }
    return path_create;
}

/** catch文件夹下的路径
 @param name  "file1","directory/file1"
 */
-(NSString*)createPathUnderCatch:(NSString *)name
{
    NSString * path_catch = [self getPathForCatch];
    
    return [self createPathUnderPath:path_catch name:name];
}

/** 获取文件夹下文件目录*/
-(NSArray*)getPathListUnderDirectory:(NSString*)path_Directory
{
    NSArray * paths = nil;
    
    if(path_Directory)
    {
        paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path_Directory error:nil];
    }
    
    return paths;
}

/** 获取catch文件夹路径*/
-(NSString*)getPathForCatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    /** catch 目录下的文件路径*/
    NSString *cachesDir = nil;
    if([paths count] > 0)
    {
       cachesDir = [paths objectAtIndex:0];
    }
    
    
    return cachesDir;
}

/** 转换为当前的路径 (有时候根路径会变，所有绝对路径会不准，这里处理一下,将路径纠正)*/
-(NSString*)correcPath:(NSString*)path
{
    //获取LibraryDirectory
    NSString* catchstring = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray* conpo =  [path componentsSeparatedByString:@"/"];
    int cathlocation=0;
    for(int i=0;i < [conpo count];i++)
    {
        NSString* pathi=[conpo objectAtIndex:i];
        if([[pathi lowercaseString]isEqualToString:@"library"])
        {
            cathlocation = i;
        }
    }
    
    for(int i = cathlocation + 1 ; i < [conpo count] ; i ++ )
    {
        catchstring = [catchstring stringByAppendingPathComponent:[conpo objectAtIndex:i]];
        
    }
    
    path = catchstring;
    
    return path;
}

#pragma  mark- 文件操作

/** 保存文件*/
-(void)saveData:(NSData*)data toPath:(NSString*)path
{
    [data writeToFile:path atomically:YES];
}

/** 读取文件*/
-(NSData*)readDataFromPath:(NSString*)path
{
    NSData * data = nil;
    
    if(path)
    {
        data = [NSData dataWithContentsOfFile:path];
    }
    
    return data;
}

/** 删除文件*/
-(void)deleteFile:(NSString*)path
{
    if(![self isFilePathDirectory:path])
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
}

/** 删除文件夹*/
-(void)deleteDirectory:(NSString*)path
{
    if([self isFilePathDirectory:path])
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}


#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面

@end
