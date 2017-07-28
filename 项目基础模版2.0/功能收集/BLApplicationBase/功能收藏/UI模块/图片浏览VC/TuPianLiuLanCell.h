//
//  TuPianLiuLanCell.h
//  DaJiShi
//
//  Created by camore on 16/7/29.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"
#import "PicLiuLanView.h"

@interface TuPianLiuLanCell : BLTableViewCell

@property ( nonatomic , strong )PicLiuLanView * pic_view;

-(void)setImageWith:(UIImage*)image OrUrl:(NSString*)url_image;

@end
