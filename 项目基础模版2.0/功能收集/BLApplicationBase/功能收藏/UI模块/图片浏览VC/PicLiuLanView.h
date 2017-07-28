//
//  PicLiuLanView.h
//  DaJiShi
//
//  Created by camore on 16/7/26.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"

/** 图片浏览视图 默认切边*/
@interface PicLiuLanView : BLView


/** 创建视图，用图片或者链接 */
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image OrUrl:(NSString *)url;
/** 双击放大缩小*/
@property ( nonatomic , strong )UITapGestureRecognizer  *   gesture_doubleClick;

/** 双击放大 双击缩小功能 默认开启*/
-(void)enAbleDoubleClcike:(BOOL)enable;


/** 旋转功能 默认关闭*/
-(void)enAbleRotate:(BOOL)enable;

/** 设置内容*/
-(void)setimage:(UIImage*)image OrUrl:(NSString *)url;


@end
