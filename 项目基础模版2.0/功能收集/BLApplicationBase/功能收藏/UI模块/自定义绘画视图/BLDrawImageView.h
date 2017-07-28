//
//  BLDrawImageView.h
//  DaJiShi
//
//  Created by camore on 16/4/15.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"


#import "BLDrawImageModel.h"





/** 绘画图像视图*/
@interface BLDrawImageView : BLView

/** 添加绘画信息*/
-(void)addDrawInfoModel:(BLDrawImageModel*)model;

@end
