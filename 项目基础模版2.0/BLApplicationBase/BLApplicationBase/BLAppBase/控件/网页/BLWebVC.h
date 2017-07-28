//
//  BLWebVC.h
//  BaiTang
//
//  Created by camore on 16/3/14.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLVC.h"
#import <WebKit/WebKit.h>
@interface BLWebVC : BLVC

/** 网络地址*/
@property ( nonatomic , strong ) NSString   *   urlString;

/** 网页标题*/
@property ( nonatomic , strong ) NSString   *   pageTitle;

/** 显示前进后退*/
@property ( nonatomic , readwrite ) BOOL       showQianJinHouTui;

/** 返回当做后退*/
@property ( nonatomic , readwrite ) BOOL       backAsHouTui;
/** 加载网页
 @param urlstring 网址，如果不写urlstring 则默认加载促销页面
 @param title 标题
 @param showTab 是否显示tabbar（底部高度减少49）
 */
-(instancetype)initWithUrl:(NSString*)urlstring title:(NSString*)title showTabbar:(BOOL)showTab;


@end
