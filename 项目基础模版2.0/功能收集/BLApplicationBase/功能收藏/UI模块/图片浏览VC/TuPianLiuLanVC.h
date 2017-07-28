//
//  TuPianLiuLanVC.h
//  DaJiShi
//
//  Created by camore on 16/7/25.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "AppVC.h"

/** 图片浏览视图*/
@interface TuPianLiuLanVC : AppVC

/** 创建视图
 @param array_url       图片的url
 @param array_bottom    图片的底部视图 可以为空
 */
-(instancetype)initWithPicUrl:(NSArray*)array_url BottomView:(NSArray *)array_bottom;

/** 图片*/
@property ( nonatomic , strong )NSArray * array_imageView;
/** 图片对应底部视图 */
@property ( nonatomic , strong )NSArray * array_bottom;
/** 图片对应url*/
@property ( nonatomic , strong )NSArray * array_url;
/** 当前滑动到的位置 0,1,2,*/
@property ( nonatomic , readwrite ) NSInteger currentIndex;


/** 普通的底部视图*/
+(UIView *)customBottmView;

@end
