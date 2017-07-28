//
//  AutoMoveIconView.h
//  BaiTang
//
//  Created by BLapple on 16/3/7.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"
/** 自动移动带icon的lable 自动设置宽度*/
@interface AutoMoveIconView : UIView


/** icon 视图*/
@property (nonatomic ,strong) UIImageView * imageview;

/** icon 视图*/
@property (nonatomic ,strong) UILabel * lable_content;

/** 允许多行*/
@property (nonatomic , readwrite ) BOOL allowMutableLine;

/** 首行与图片中线对气默认yes*/
@property (nonatomic , readwrite ) BOOL firstLineCompareWithImage;


-(void)setTextAlignment:(NSTextAlignment)textAlignment;


-(NSString *)text;

-(void)setText:(NSString *)text;

-(UIFont*)font;
-(void)setFont:(UIFont*)font;


-(UIColor*)textColor;
-(void)setTextColor:(UIColor*)textColor;

/** limitWidth 限制宽度，（包括图片）*/
-(void)setLimitViewWidth:(CGFloat)width;

-(UIImageView *)imageview;
-(void)setImageview:(UIImageView *)imageview;


/** 带icon 的label
 @param image  icon
 @param string  文字
 @param font   字体
 @param space   icon 文字间隔
 @param left     icon 在左边
 */
+(instancetype)AutoMoveIconViewWithIcon:(BLImageView*)imageview string:(NSString*)string font:(UIFont*)font space:(float)space iconIsLeft:(BOOL)left;

/** 带icon 的label 并设定高度
 @param image  icon
 @param string  文字
 @param font   字体
 @param space   icon 文字间隔
 @param left     icon 在左边
 @param height   高度
 */
+(instancetype)AutoMoveIconViewWithIcon:(BLImageView*)imageview string:(NSString*)string font:(UIFont*)font space:(float)space iconIsLeft:(BOOL)left height:(CGFloat)height;

@end
