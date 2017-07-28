//
//  MyControl.h
//  医疗
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



#define createViewSepTag   9090
#define createViewShadowTag   9091
#define createViewTopShadowTag   9092

///自视图tag
#define subTextFieldTag     8000
#define subLalbeTag         8010
#define subImageViewTag     8020
#define subButtonTag        8030

/** 快速创建视图类别
 * 工具类
 * 视图控制
 */
@interface MyControl : NSObject

#pragma mark- UIView

/** 创建frame 大小的UIView*/
+(BLView *)createViewWithFrame:(CGRect)frame;

/** 在视图的背后添加视图 大小位置相同(用于扩展层级)*/
+(BLView *)embedView:(UIView*)view;

#pragma mark- ImageView

/** 创建UIImageView
 @param frame 坐标大小
 @param image 图片
 */
+(BLImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/** 创建UIImageView
 @param image 图片
 @param scale UIImageView的大小与图片大小的比例 图片大小除以scale
 */
+(BLImageView *)createImageViewWithImage:(UIImage*)image scaleFacetor:(CGFloat)scale;


/** 创建UIImageView
 @param frame 坐标大小
 @param imageName 图片名
 */
+(BLImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

/** 创建UIImageView 带边距
 @param frame 坐标大小
 @param image 图片
 */
+(BLView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image EdgeInsets:(UIEdgeInsets)EdgeInsets;


/** 创建动画image view
 @param images [iamge]图像
 @param duration 动画间隔
 @param frame   视图大小
 */
+(BLImageView *)createAnimtateImageViewWithImages:(NSArray*)images duration:(float)duration frame:(CGRect)frame;

#pragma mark- Textfield

/** 创建输入框
 @param frame 坐标大小
 @param placeHolder 占位符
 */
+(BLTextField *)createTextfieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

/** 创建带icon 的输入框
 @param frame 坐标大小
 @param imageView icon
 @param sepSpace 间隔
 */
+(BLView *)createTextfieldWithFrame:(CGRect)frame Icon:(UIImageView*)imageView sep:(CGFloat)sepSpace;

/** 创建带边距的textfield
 @param edge 边距
 */
+(BLView*)createTextFieldWithFrame:(CGRect)frame bianju:(UIEdgeInsets)edge placeHolder:(NSString *)placeHolder;

#pragma mark- UIButton

/** 创建button*/
+(BLButton*)createButtonWithFrame:(CGRect)frame target:(id)target method:(SEL)method;

/** 创建button 背景*/
+(BLButton*)createButtonWithFrame:(CGRect)frame imageName:(NSString*)imagename target:(id)target method:(SEL)method;

/** 创建button 背景  选中背景*/
+(BLButton*)createButtonWithFrame:(CGRect)frame image:(UIImage*)image selectedImage:(UIImage*)seledtedImage target:(id)target method:(SEL)method;

/** 以视图创建button*/
+(UIButton*)createButtonWihtView:(UIView*)view  target:(id)target method:(SEL)method;

/** 纯色button  带设置字体大小*/
+(BLButton*)createButtonWithFrame:(CGRect)frame bgcolor:(UIColor*)bgcolor  title:(NSString*)title titlecolor:(UIColor*)titlecolor titleFont:(UIFont*)titleFont method:(SEL)method target:(id)target;

/** 创建Button  带背景色 选中时样式*/
+(BLButton*)createButtonWithFrame:(CGRect)frame bgcolor:(UIColor*)bgcolor  title:(NSString*)title titleColor:(UIColor*)titleColor  selectedBgcolor:(UIColor*)selectbgcolor selectedTitleColor:(UIColor*)selectedTitleColor  titleFont:(UIFont*)titleFont method:(SEL)method target:(id)target;

/** 带 图片 和 Label标签的button (图片在上 Label 在下居中)
 @param iamgeview 图片
 @param tagLabel  标签文本
 */
+(BLButton * )createButtonWithImageView:(UIImageView*)iamgeview tagLabel:(UILabel*)tagLabel ;


/** 设置按钮的图片（根据图片大小设置edge）*/
+(UIImage*)setButtonImageWithButton:(UIButton*)button WithImageView:(UIView*)imageView forState:(UIControlState)state;

/** 使按钮 保持当前视图的情况下拥有更大的点击区域 保持中心点*/
+(void)setButtonBigger:(UIButton *)button TouchSize:(CGSize)size;

#pragma mark- UILabel

/** 创建UILabel*/
+(BLLabel *)createLabelWithFrame:(CGRect)frame font:(UIFont*)font title:(NSString *)title;

/** 创建文字宽度，高度的Label*/
+(BLLabel* )creaeteLabelWithString:(NSString *)string Font:(UIFont*)font;

/** 创建文字宽度，高度的Label 设定宽度自动换行设置高度*/
+(BLLabel* )creaeteLabelWithString:(NSString *)string Font:(UIFont*)font width:(float)width;


/** 带icon 的label
 @param imageView  icon
 @param string  文字
 @param font   字体
 @param space   icon 文字间隔
 @param isleft 图片是否在左边
 @param width  宽度为0 时为视图宽度
 */
+(BLView*)createLabelWithImageView:(UIImageView*)imageView  string:(NSString*)string font:(UIFont*)font space:(float)space isleft:(BOOL)isleft width:(CGFloat)width;


#pragma mark- UIImage

/** 当前界面切图*/
+ (UIImage *)copyScreen;

/** 制作带背景的视图图片*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size addedview:(UIView*)view;

/**  从view截取图片*/
+ (UIImage *)imageview:(UIView*)view;

/** 从文件加载，减少内存占用 name 需要带.png 等类型后缀*/
+ (UIImage *)imageFileWithName:(NSString*)name;

///**  从view截取图片 并进行模糊处理 iterations:2 radius:2 */
//+ (UIImage *)imageViewMoHu:(UIView*)view ;
//
///** 图片 模糊处理 #import <Accelerate/Accelerate.h>*/
//+ (UIImage *)imageMoHu:(UIImage*)image iterations:(NSUInteger)iterations radius:(CGFloat)radius;

/** 图片大小不变， 将里面的内容缩小*/
+ (UIImage *)imageScaleWithImage:(UIImage *)image toPercent:(CGFloat)percent;

/** 截取带圆圈 文字的图片*/
+ (UIImage *)imageWithSize:(CGSize)size CircleText:(NSString*)string textcolor:(UIColor*)textColor font:(UIFont*)font backgroundColor:(UIColor*)background corcleColor:(UIColor*)cirCleColor circleWidth:(float)circlewidth corneradius:(float)corneradius;

/** 截取带圆圈 文字的图片 attribute*/
+ (UIImage *)imageWithSize:(CGSize)size CircleAttributeText:(NSAttributedString*)string textcolor:(UIColor*)textColor font:(UIFont*)font backgroundColor:(UIColor*)backgroundcolor corcleColor:(UIColor*)cirCleColor circleWidth:(float)circlewidth corneradius:(float)corneradius;

/** 动态图片*/
+ (UIImage *)animateImageWithImageNames:(NSArray*)array_names duration:(float)duration;

/** 动态图片*/
+ (UIImage *)animateImageWithImages:(NSArray*)array_imags duration:(float)duration;

/** 图片数组*/
+ (NSMutableArray *)arrayForImageWithFileWithNames:(NSArray*)array_imageNames;

///** 从动态图片中获取图片 #import <ImageIO/ImageIO.h>*/
//+ (UIImage*)animateImageFromAnimateImageData:(NSData*)data_image_animate;

/** 降图片缩小压缩到屏幕大小（单倍）用于上传*/
+ (UIImage *)scaleImageToSizeInPhone:(UIImage*)image;

/** 获取某张图片的高斯模糊效果*/
+ (UIImage *)gaussianImageFor:(UIImage *)image;

/**  图片压缩*/
+ (UIImage *)scaleImage:(UIImage *)originImage size:(CGSize)targetSize;

/** 随机颜色*/
+ (UIColor *)randomColor;

#pragma mark- NSString & mutistring

/** 获取字体的高度*/
+ (CGFloat)heightForFont:(UIFont *)font;

/** 判断string 对应字体的宽度*/
+(CGFloat)stringwidthfor:(NSString*)string font:(UIFont*)font;

/** 判断string 对应字体 对应宽度 的高度*/
+(CGFloat)stringheightfor:(NSString*)string font:(UIFont*)font width:(CGFloat)width;

/** 判断string 对应字体 的绘画面积*/
+(CGRect)stringRectfor:(NSString*)string font:(UIFont*)font;

/** 判断string 对应字体 对应宽度 的绘画面积*/
+(CGRect)stringRectfor:(NSString*)string font:(UIFont*)font width:(CGFloat)width;

/** 判断string 对应字体 对应宽度 的绘画面积*/
+(CGRect)stringRectfor:(NSString*)string font:(UIFont*)font height:(CGFloat)height;

/** 将string 按宽度拆分成数组
 *  string 拆分的string
 *  width  拆分的宽度
 *  userful 换行符是否还有用  yes有用  no 无用
 */
+(NSArray*)stringSub:(NSString*)string byFont:(UIFont*)font  byWidth:(float)width returnUsefull:(BOOL)userful;

/** 限制文本的宽度 tril yes 增加@"..."*/
+(NSString*)limitString:(NSString*)string InWidth:(CGFloat)length font:(UIFont*)font addTril:(BOOL)tril;

/** 判断NSMutableAttributedString 对应的宽度*/
+(CGFloat)mutistringwidthfor:(NSMutableAttributedString*)mutistring;

/** 判断NSMutableAttributedString 对应字体 对应宽度 的绘画面积*/
+(CGRect)mutistringRectfor:(NSMutableAttributedString*)mutistring;

/** 添加颜色*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddColor:(UIColor*)color forRange:(NSRange)range;

/** 添加font*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddFont:(UIFont*)font forRange:(NSRange)range;

/** 添加下划线*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddUnderLin:(UIColor*)color forRange:(NSRange)range;

/** 添加行间隔*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddLineSpace:(CGFloat)lineSapce forRange:(NSRange)range;

/** 添加段间隔*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddParaGraphSpace:(CGFloat)lineSapce forRange:(NSRange)range;

/** 获取适合这个宽度的字体 8 - 50*/
+ (UIFont * )fontForString:(NSString*)string width:(CGFloat)width;

#pragma mark- 区域大小
/** 计算 frame edge*/
+(CGRect)frameInFrame:(CGRect)frame edge:(UIEdgeInsets)EdgeInsets;

/** 求出在比例不变的情况下，放置在区域中的大小位置。middle：是否放于区域中间*/
+(CGRect)sizeWith:(CGSize)size Scaleinrect:(CGRect)outrect putmiddle:(BOOL)middle;

/** 计算size之间的间隔*/
+(UIEdgeInsets)UIedgeInsetsCenterForSize:(CGSize)size_in outBounds:(CGSize)size_out;

/** 获取两点间的大小*/
+(CGSize)sizeBetweenPoint:(CGPoint)point1 point:(CGPoint)point2;

#pragma mark-  添加样式
/** 添加阴影*/
+(UIView*)addShadowWithView:(UIView*)view;

/** 添加上部阴影*/
+(UIView*)addTopShadowWithView:(UIView*)view;

/** 像素对应的视图高度*/
+(CGFloat)widthForPx:(NSInteger)px;

/** 添加分割线
 @param view 添加分割线的视图
 @param location 添加分割线的位置
 @param downOrTop 底部还是顶部yes顶部，top顶部
 */
+(BLView*)addSepViewWithView:(UIView*)view location:(CGFloat)location downOrTop:(BOOL)downOrTop;

/** 制作宽度的视图*/
+(BLView*)createSepViewWithWidth:(NSInteger)width;

/** 制作高度的视图*/
+(BLView*)createSepViewWithHeight:(NSInteger)height;

/** 隐藏数组中所有的视图 （可以数组添加数组）*/
+(void)hideAllViewInArray:(NSArray*)array;

/** 显示数组中所有的视图 （可以数组添加数组）*/
+(void)showAllViewInArray:(NSArray*)array;


@end
