//
//  BLCropImage.h
//  BaiTang
//
//  Created by camore on 16/4/3.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"
@class BLCropImage;
@protocol BLCropImageDelegate <NSObject>

/** 获取剪切图片*/
-(void)BLCropImage:(BLCropImage*)CropImage getCutImage:(UIImage*)image;

/** 取消剪切图片*/
-(void)BLCropImageCancel:(BLCropImage*)CropImage;

@end

/** 图片选择剪切*/
@interface BLCropImage : BLView

@property (nonatomic , weak)id <BLCropImageDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame CropImage:(UIImage*)corpImage ToSize:(CGSize)size;

@end
