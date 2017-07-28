//
//  MyControl.m
//  医疗
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyControl.h"
#import "AppDelegate.h"
//#import <Accelerate/Accelerate.h>
//#import <ImageIO/ImageIO.h>

@implementation MyControl


#pragma mark- UIView
+(BLView *)createViewWithFrame:(CGRect)frame
{
    BLView * view = [[BLView alloc] initWithFrame:frame];
    return view;
    
}

/** 在视图的背后添加视图 大小位置不变*/
+(BLView *)embedView:(UIView*)view
{
    BLView * view_back = [MyControl createViewWithFrame:view.frame];

    view.left = 0;
    view.top  = 0;
    
    UIView * view_super = view.superview;
    
    
    [view_back addSubview:view];
    if(view_super)
    {
        [view_super addSubview:view_back];
    }
    
    return view_back;
    
}

#pragma mark- UIImageView

/** 创建UIImageView 带边距
 @param frame 坐标大小
 @param image 图片
 */
+(BLView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image EdgeInsets:(UIEdgeInsets)EdgeInsets
{
    BLView * back = [MyControl createViewWithFrame:frame];
    
    CGRect rect_image = [self frameInFrame:back.bounds edge:EdgeInsets];
    
    BLImageView  * imageView = [MyControl createImageViewWithFrame:rect_image image:image];
    
    imageView.tag = subImageViewTag;
    [back addSubview:imageView];
    
    return back;
    
}

/** 创建UIImageView
 @param image 图片
 @param scale UIImageView的大小与图片大小的比例 图片大小除以scale
 */
+(BLImageView *)createImageViewWithImage:(UIImage*)image scaleFacetor:(CGFloat)scale
{
    NSInteger widht_view = 0;
    NSInteger height_view = 0;
    
    if(scale == 0)
    {
        scale = [UIScreen mainScreen].scale;
    }
    
    if(scale>0)
    {
        widht_view = image.size.width/scale;
        height_view = image.size.height/scale;
    }
    
    
    BLImageView * imageView = [self createImageViewWithFrame:CGRectMake(0, 0, widht_view, height_view) image:image];

    
    
    return imageView;
}

/** 创建UIImageView
 @param frame 坐标大小
 @param imageName 图片名
 */
+(BLImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    BLImageView * imageView = nil;
    UIImage * image = nil;
    if(imageName)
    {
        
        image = [UIImage imageNamed:imageName] ;
        if(!image)
        {
            image = [self imageFileWithName:imageName];
        
        }
        
    }
    
    imageView = [self createImageViewWithFrame:frame image:image];
    
    return imageView;
    
}


/** 创建UIImageView
 @param frame 坐标大小
 @param image 图片
 */
+(BLImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image
{

    BLImageView * imageView = [[BLImageView alloc] initWithFrame:frame];
    if(image)
    {

        imageView.image = image;
        
    }
    
    return imageView;

}




/** 创建动画image view
 @param images [iamge]图像
 @param duration 动画间隔
 @param frame   视图大小
 */
+(BLImageView *)createAnimtateImageViewWithImages:(NSArray*)images duration:(float)duration frame:(CGRect)frame
{
    BLImageView * imageview = [self createImageViewWithFrame:frame image:nil];
    
    if([images count ] > 0)
    {
        UIImage *  animatedImage = [UIImage animatedImageWithImages:images duration:duration];
        imageview.image = animatedImage;
    }
    return imageview;
}

#pragma mark- uitextfield
/** 创建输入框
 @param frame 坐标大小
 @param placeHolder 占位符
 */
+(BLTextField *)createTextfieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    BLTextField * textField = [[BLTextField alloc]initWithFrame:frame];
    textField.placeholder = placeHolder;
    textField.textColor = color_text_main_black;
  
    return textField;
    
}

/** 创建带icon 的输入框
 @param frame 坐标大小
 @param imageView icon
 @param sepSpace 间隔
 */
+(BLView *)createTextfieldWithFrame:(CGRect)frame Icon:(UIImageView*)imageView sep:(CGFloat)sepSpace;
{
    BLView * view = [[BLView alloc] initWithFrame:frame];
    
   
    imageView.tag = subImageViewTag;
    
    
    /** textfield*/
    BLTextField * textfield = [MyControl createTextfieldWithFrame:CGRectMake(imageView.right+sepSpace , 0, frame.size.width-imageView.right - sepSpace , frame.size.height) placeHolder:nil];
    textfield.tag = subTextFieldTag;
    [view addSubview:imageView];
    [view addSubview:textfield];
    return view;
    
}


/** 创建带边距的textfield
 @param edge 边距
 */
+(BLView*)createTextFieldWithFrame:(CGRect)frame bianju:(UIEdgeInsets)edge placeHolder:(NSString *)placeHolder
{
    BLView * view = [[BLView alloc] initWithFrame:frame];
    
    //textfield 大小
    CGRect fiedRect = [self frameInFrame:view.bounds edge:edge];

    
    
    BLTextField * field = [self createTextfieldWithFrame:fiedRect placeHolder:placeHolder];
    field.tag = subTextFieldTag;
    
    [view addSubview:field];
    return view;
    
}

#pragma mark- UIButton

/** 创建button*/
+(BLButton*)createButtonWithFrame:(CGRect)frame target:(id)target method:(SEL)method
{
    BLButton* button        = [[BLButton alloc] initWithFrame:frame];
    
    if(target && method)
    {
        [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    }
    [button setExclusiveTouch:YES];
    return button;
}

/** 创建button 背景*/
+(BLButton*)createButtonWithFrame:(CGRect)frame imageName:(NSString*)imagename  target:(id)target method:(SEL)method
{
    BLButton* button        = [self createButtonWithFrame:frame target:target method:method];
    
    [button setImage:[self imageFileWithName:imagename] forState:UIControlStateNormal];
    
    return button;
}

/** 创建button 背景  选中背景*/
+(BLButton*)createButtonWithFrame:(CGRect)frame image:(UIImage*)image selectedImage:(UIImage*)seledtedImage target:(id)target method:(SEL)method;
{
    BLButton* button = [self createButtonWithFrame:frame target:target method:method];
    
    if(image)
    {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if(seledtedImage)
    {
        [button setImage:seledtedImage forState:UIControlStateSelected];
    }
    
    return button;

}

/** 以视图创建button*/
+(UIButton*)createButtonWihtView:(UIView*)view  target:(id)target method:(SEL)method
{
    BLButton* button = [self createButtonWithFrame:view.frame target:target method:method];

    [self setButtonImageWithButton:button WithImageView:view forState:UIControlStateNormal];
    
    return button;
}

/** 纯色button  带设置字体大小*/
+(BLButton*)createButtonWithFrame:(CGRect)frame bgcolor:(UIColor*)bgcolor  title:(NSString*)title titlecolor:(UIColor*)titlecolor titleFont:(UIFont*)titleFont method:(SEL)method target:(id)target
{
    BLButton* button        = [self createButtonWithFrame:frame target:target method:method];
    BLLabel* bottonLabel    = [[BLLabel alloc] initWithFrame:button.bounds];
    bottonLabel.text        = title;
    bottonLabel.textAlignment = NSTextAlignmentCenter;
    bottonLabel.textColor   = titlecolor;
    bottonLabel.font        = titleFont;
    [self setButtonImageWithButton:button WithImageView:bottonLabel forState:UIControlStateNormal];
    
    return button;

}

/** 创建Button  带背景色 选中时样式*/
+(BLButton*)createButtonWithFrame:(CGRect)frame bgcolor:(UIColor*)bgcolor  title:(NSString*)title titleColor:(UIColor*)titleColor  selectedBgcolor:(UIColor*)selectbgcolor selectedTitleColor:(UIColor*)selectedTitleColor  titleFont:(UIFont*)titleFont method:(SEL)method target:(id)target
{
    BLButton* button        = [self createButtonWithFrame:frame target:target method:method];
    BLLabel* bottonLabel    = [self createLabelWithFrame:button.bounds font:titleFont title:title];
    bottonLabel.textAlignment = NSTextAlignmentCenter;
    bottonLabel.textColor       = titleColor;
    bottonLabel.backgroundColor = bgcolor;
    
    [self setButtonImageWithButton:button WithImageView:bottonLabel forState:UIControlStateNormal];
    
    bottonLabel.textColor       = selectedTitleColor;
    bottonLabel.backgroundColor = selectbgcolor;
    
    [self setButtonImageWithButton:button WithImageView:bottonLabel forState:UIControlStateSelected];
    [self setButtonImageWithButton:button WithImageView:bottonLabel forState:UIControlStateHighlighted];
    
    return button;
}



/** 带Label标签的button
 @param imageview 图片
 @param tagLabel  标签文本
 */
+(BLButton * )createButtonWithImageView:(UIImageView*)imageview tagLabel:(UILabel*)tagLabel 
{
    ///宽高
    NSInteger width = ( (imageview.width > tagLabel.width) ? imageview.width:  tagLabel.width);
    NSInteger height = imageview.top +  imageview.height + tagLabel.top +tagLabel.height ;
    
    UIView * view_image = [self createViewWithFrame:CGRectMake(0, 0, width,height)];
    
    imageview.centerX = view_image.width/2;
    [view_image addSubview:imageview];
    
    tagLabel.top    = imageview.bottom + tagLabel.top;
    tagLabel.centerX = view_image.width/2;
    [view_image addSubview:tagLabel];
    
    UIImage * image_button  = [self imageview:view_image];
    BLButton * button = [self createButtonWithFrame:view_image.bounds target:nil method:nil];
    [button setImage:image_button forState:UIControlStateNormal];

    return button;
    
}


/** 设置按钮的图片（根据图片大小设置edge）*/
+(UIImage*)setButtonImageWithButton:(UIButton*)button WithImageView:(UIView*)imageView forState:(UIControlState)state
{
    CGSize buttonSize = button.bounds.size;
    
    CGSize imageSize = imageView.frame.size;
    
    UIImage * image_button = [self imageview:imageView];
    
    
    button.imageEdgeInsets = UIEdgeInsetsMake((buttonSize.height - imageSize.height)/2, (buttonSize.width - imageSize.width)/2, (buttonSize.height - imageSize.height)/2, (buttonSize.width - imageSize.width)/2);
    
    [button setImage:image_button forState:state];
    
    return image_button;
}

/** 使按钮 保持当前视图的情况下拥有更大的点击区域 保持中心点*/
+(void)setButtonBigger:(UIButton *)button TouchSize:(CGSize)size;
{
    CGSize oldSize = button.bounds.size;
    CGPoint oldCenter = button.center;
    UIControlState oldState = button.state;
    
    UIImage * image_normal = [MyControl imageview:button];
    [button setImage:image_normal forState:oldState];
    button.size = size;
    button.imageEdgeInsets = UIEdgeInsetsMake((size.height - oldSize.height)/2.0, (size.width - oldSize.width)/2.0, (size.height - oldSize.height)/2.0, (size.width - oldSize.width)/2.0);
    button.center = oldCenter;
    
}

#pragma mark- UILabel

+(BLLabel *)createLabelWithFrame:(CGRect)frame font:(UIFont*)font title:(NSString *)title
{
    BLLabel * label= [[BLLabel alloc] initWithFrame:frame];
    label.textColor = color_text_main_black;
    label.font = font;
    
    if(title)
    {
        label.text = title;
    }
    
    return label;
    
}

/** 创建文字宽度，高度的Label*/
+(BLLabel* )creaeteLabelWithString:(NSString *)string Font:(UIFont*)font
{
    /** 文字size*/
    CGRect stringRect = [self stringRectfor:string font:font];
    
    BLLabel * Label = [self createLabelWithFrame:stringRect font:font title:string];
    Label.textColor = color_text_main_black;
    
    return Label;

}

/** 创建文字宽度，高度的Label 设定宽度*/
+(BLLabel* )creaeteLabelWithString:(NSString *)string Font:(UIFont*)font width:(float)width
{
    
    CGRect stringRect = [self stringRectfor:string font:font width:width];
    stringRect.size.width = width;
    BLLabel * Label = [self createLabelWithFrame:stringRect font:font title:string];
    Label.numberOfLines = 0;
    Label.textColor = color_text_main_black;
    return Label;

}




/** 带icon 的label
 @param imageView  icon
 @param string  文字
 @param font   字体
 @param space   icon 文字间隔
 @param isleft 图片是否在左边
 @param width  宽度为0 时为视图宽度
 */
+(BLView*)createLabelWithImageView:(UIImageView*)imageView  string:(NSString*)string font:(UIFont*)font space:(float)space isleft:(BOOL)isleft width:(CGFloat)width
{
    CGFloat width_text = [self stringwidthfor:string font:font];
    
    if(width == 0)
    {
        width = width_text + space + imageView.width + (isleft?imageView.left:0);
    }
    
    CGRect frame_view = CGRectMake(0, 0, width, imageView.height);
    
    
    
    
    
    BLView * backView = [MyControl createViewWithFrame:frame_view];
    backView.clipsToBounds = YES;
   
    BLLabel * Label = [MyControl creaeteLabelWithString:string Font:font];
    Label.tag = subLalbeTag;
    Label.textColor = color_text_main_black;
    
    
    imageView.centerY = backView.height/2;
    imageView.tag = subImageViewTag;
    
    if(isleft)
    {
        Label.left = imageView.right+space;
    }
    else
    {
        Label.left = 0;
        imageView.left = Label.width+space;
    }
    
    [backView addSubview:imageView];
    [backView addSubview:Label];
    
    return backView;
}

#pragma mark- UIImage

/** 当前界面切图*/
+ (UIImage *)copyScreen
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    return [MyControl imageview:window];
}


/** 制作带背景的视图图片*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size addedview:(UIView*)view
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
/**  从view截取图片*/
+ (UIImage *)imageview:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFileWithName:(NSString*)name
{
    if([name isKindOfClass:[NSString class]])
    {
        NSString*resourcePath = [NSBundle mainBundle].resourcePath;
        NSString*filepath = [resourcePath stringByAppendingPathComponent:name];
        
        UIImage* imagewithfile = [UIImage imageWithContentsOfFile:filepath];
        return imagewithfile;
        
    }
    return nil;
}


///**  从view截取图片 并进行模糊处理*/
//+ (UIImage *)imageViewMoHu:(UIView*)view
//{
//    UIImage * viewIMage = [self imageview:view];
//    return [self imageMoHu:viewIMage iterations:2 radius:2];
//}
//
///** 图片 模糊处理 #import <Accelerate/Accelerate.h>*/
//+ (UIImage *)imageMoHu:(UIImage*)image iterations:(NSUInteger)iterations radius:(CGFloat)radius
//{
//    UIColor *   tintColor = [UIColor clearColor];
////    NSUInteger  iterations = 3;
////    CGFloat     radius = 2;
//    
//   
//    
//    UIImage * image_mohu = image;
//    
//    if(image_mohu)
//    {
//        
//        
//        //boxsize must be an odd integer
//        
//        uint32_t boxSize = (uint32_t)(radius * image_mohu.scale);
//        
//        if (boxSize % 2 == 0) boxSize ++;
//        
//        //create image buffers
//        
//        CGImageRef imageRef = image_mohu.CGImage;
//        
//        vImage_Buffer buffer1, buffer2;
//        
//        buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
//        
//        buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
//        
//        buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
//        
//        size_t bytes = buffer1.rowBytes * buffer1.height;
//        
//        buffer1.data = malloc(bytes);
//        
//        buffer2.data = malloc(bytes);
//        
//        //create temp buffer
//        
//        void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
//                                                                     
//                                                                     NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
//        
//        //copy image data
//        
//        CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
//        
//        memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
//        
//        CFRelease(dataSource);
//        
//        for (NSUInteger i = 0; i < iterations; i++)
//            
//        {
//            
//            //perform blur
//            
//            vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
//            
//            //swap buffers
//            
//            void *temp = buffer1.data;
//            
//            buffer1.data = buffer2.data;
//            
//            buffer2.data = temp;
//            
//        }
//        
//        //free buffers
//        
//        free(buffer2.data);
//        
//        free(tempBuffer);
//        
//        //create image context from buffer
//        
//        CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
//                                                 
//                                                 8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
//                                                 
//                                                 CGImageGetBitmapInfo(imageRef));
//        
//        //apply tint
//        
//        if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
//            
//        {
//            
//            CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
//            
//            CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
//            
//            CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
//            
//        }
//        
//        //create image from context
//        
//        imageRef = CGBitmapContextCreateImage(ctx);
//        
//        UIImage *image = [UIImage imageWithCGImage:imageRef scale:image_mohu.scale orientation:image_mohu.imageOrientation];
//        
//        CGImageRelease(imageRef);
//        
//        CGContextRelease(ctx);
//        
//        free(buffer1.data);
//        
//        return image;
//        
//        
//    }
//    
//    
//    //    CIContext *context = [CIContext contextWithOptions:nil];
//    //    CIImage *image = [CIImage imageWithContentsOfURL:imageURL];
//    //    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    //    [filter setValue:image forKey:kCIInputImageKey];
//    //    [filter setValue:@2.0f forKey: @"inputRadius"];
//    //    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    //    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
//    //    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
//    
//    //正确写法纠正
//    //    CIImage *ciImage = [[CIImage alloc]initWithImage:image];
//    //
//    //    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    //    [filter setValue:ciImage forKey:kCIInputImageKey];
//    //    [filter setValue:@5.0f forKey: @"inputRadius"];
//    //    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    //    CIContext *context = [CIContext contextWithOptions:nil];
//    //    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
//    //    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
//    //    CGImageRelease(outImage);
//    //    －－CGImageRef outImage = [context createCGImage: result fromRect:CGRectMake(0, 0, image.size.width, image.size.height)];  可以换这句来达到，图片模糊后与原图尺寸相同
//    
//    
//    //    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
//    //    blurFilter.blurRadiusInPixels = 2.0;
//    //    UIImage * image = [UIImage imageNamed:@"xxx"];
//    //    UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
//    
//    
//    return image_mohu;
//}

/** 图片大小不变， 将里面的内容缩小*/
+ (UIImage *)imageScaleWithImage:(UIImage *)image toPercent:(CGFloat)percent
{
    UIView * back = [MyControl createViewWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    back.backgroundColor = [UIColor clearColor];
    
    
    UIImageView * imageview_hilight = [MyControl createImageViewWithFrame:CGRectMake(0, 0,back.width*percent, back.height*percent) image:image];
    imageview_hilight.centerX = back.width/2;
    imageview_hilight.centerY = back.height/2;
    [back addSubview:imageview_hilight];
    UIImage * image_scaled = [MyControl imageview:back];

    
    return image_scaled;
}


/** 截取带圆圈 文字的图片*/
+ (UIImage *)imageWithSize:(CGSize)size CircleText:(NSString*)string textcolor:(UIColor*)textColor font:(UIFont*)font backgroundColor:(UIColor*)backgroundcolor corcleColor:(UIColor*)cirCleColor circleWidth:(float)circlewidth corneradius:(float)corneradius
{
    BLLabel * imageLabel = [MyControl createLabelWithFrame:CGRectMake(0, 0, size.width, size.height) font:font title:string];
    imageLabel.textColor = textColor;
    imageLabel.layer.cornerRadius = corneradius;
    imageLabel.layer.masksToBounds = YES;
    imageLabel.textAlignment = NSTextAlignmentCenter;
    imageLabel.layer.borderColor = cirCleColor.CGColor;
    imageLabel.layer.borderWidth = circlewidth;
    imageLabel.backgroundColor = backgroundcolor;
    imageLabel.numberOfLines   = 0;
    return [self imageview:imageLabel];
    
}

/** 截取带圆圈 文字的图片*/
+ (UIImage *)imageWithSize:(CGSize)size CircleAttributeText:(NSAttributedString*)string textcolor:(UIColor*)textColor font:(UIFont*)font backgroundColor:(UIColor*)backgroundcolor corcleColor:(UIColor*)cirCleColor circleWidth:(float)circlewidth corneradius:(float)corneradius
{
    BLLabel * imageLabel = [MyControl createLabelWithFrame:CGRectMake(0, 0, size.width, size.height) font:font title:@""];
    imageLabel.attributedText = string;
    imageLabel.textColor = textColor;
    imageLabel.layer.cornerRadius = corneradius;
    imageLabel.layer.masksToBounds = YES;
    imageLabel.textAlignment = NSTextAlignmentCenter;
    imageLabel.layer.borderColor = cirCleColor.CGColor;
    imageLabel.layer.borderWidth = circlewidth;
    imageLabel.backgroundColor = backgroundcolor;
    imageLabel.numberOfLines   = 0;
    return [self imageview:imageLabel];
    
}



/** 动态图片*/
+ (UIImage *)animateImageWithImageNames:(NSArray*)array_names  duration:(float)duration
{
    UIImage *  animatedImage = nil;
    
    NSMutableArray * array_imags = [NSMutableArray array];
    for ( int i = 0 ; i < [array_names count] ; i ++ )
    {
        NSString * string_name = [array_names objectAtIndexSafe:i];
        UIImage * image = [self imageFileWithName:string_name];
        [array_imags addObjectSafe:image];
    }
    if([array_imags count] > 0)
    {
        animatedImage = [UIImage animatedImageWithImages:array_imags duration:duration];
    }
    return animatedImage;
}

/** 动态图片*/
+ (UIImage *)animateImageWithImages:(NSArray*)array_imags duration:(float)duration
{
    UIImage *  animatedImage = nil;
    
   
    if([array_imags count] > 0)
    {
        animatedImage = [UIImage animatedImageWithImages:array_imags duration:duration];
    }
    return animatedImage;
}



/** 图片数组*/
+ (NSMutableArray *)arrayForImageWithFileWithNames:(NSArray*)array_imageNames
{
    NSMutableArray * array_images = [NSMutableArray arrayWithCapacity:[array_imageNames count]];
    
    for( int i = 0 ; i < [array_imageNames count] ; i ++ )
    {
        NSString * string_name = [array_imageNames objectAtIndexSafe:i];
        UIImage * image = [self imageFileWithName:string_name];
        [array_images addObjectSafe:image];
        
    }
    
    return array_images;

}

///** 从动态图片中获取图片*/
//+ (UIImage*)animateImageFromAnimateImageData:(NSData*)data_image_animate
//{
//    NSMutableArray * array_images = [NSMutableArray array];
//    UIImage * image_create = nil;
//    NSData * data = data_image_animate;
//    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
//    
//    size_t count = CGImageSourceGetCount(source);
//    
//    if(count <= 1)
//    {
//        UIImage * image_one = [UIImage imageWithData:data_image_animate];
//        [array_images addObjectSafe:image_one];
//        image_create = image_one;
//    }
//    else
//    {
//        NSTimeInterval duration = 0.0f;
//        for (size_t i = 0; i < count; i++)
//        {
//            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
//            
//            duration += [self sd_frameDurationAtIndex:i source:source];
//            
//            //            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
//            
//            UIImage* oneimage=[UIImage imageWithCGImage:image];
//            if(oneimage.size.width>1)
//            {
//                [array_images addObject:oneimage];
//            }
//            
//            CGImageRelease(image);
//        }
//        if (!duration)
//        {
//            duration = (1.0f / 10.0f) * count;
//        }
//        image_create = [UIImage animatedImageWithImages:array_images duration:duration];
//    }
//    
//    CFRelease(source);
//    
//    return image_create;
//}
//+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source
//{
//    float frameDuration = 0.1f;
//    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
//    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
//    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
//    
//    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
//    if (delayTimeUnclampedProp) {
//        frameDuration = [delayTimeUnclampedProp floatValue];
//    }
//    else {
//        
//        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
//        if (delayTimeProp) {
//            frameDuration = [delayTimeProp floatValue];
//        }
//    }
//    
//    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
//    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
//    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
//    // for more information.
//    
//    if (frameDuration < 0.011f) {
//        frameDuration = 0.100f;
//    }
//    
//    CFRelease(cfFrameProperties);
//    return frameDuration;
//}

/** 降图片缩小压缩到屏幕大小（单倍）用于上传*/
+ (UIImage *)scaleImageToSizeInPhone:(UIImage*)image
{
    //旋转角度
    image = [image fixOrientation];
    
    //    CGRect middleRect =  [MyControl sizeWith:CGSizeMake(100, 100) Scaleinrect:CGRectMake(0, 0, image.size.width, image.size.height) putmiddle:YES];
    //
    //    image = [image getSubImage:middleRect];
    
    
    if(image.size.width > 1080 )
    {//超过1080大小，进行剪切
        
        //      CGRect scaleSize = [MyControl sizeWith:CGSizeMake(1080, ScreenHeight* ScreenWith/1080) Scaleinrect:CGRectMake(0, 0, image.size.width, image.size.height)  putmiddle:YES];
        
        CGSize scaleSize = CGSizeMake(1080, image.size.height* 1080/image.size.width);
        
        image = [image thumbnailWithsize:scaleSize];
    }
    
    return image;
}

+ (UIImage *)gaussianImageFor:(UIImage *)image
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIUnsharpMask"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@1.0 forKey:kCIInputIntensityKey];
    [filter setValue:[NSNumber numberWithFloat:0.0] forKey:@"inputRadius"];
    
    // blur Image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    
    return resultImage;
}

//所有特效的名称
+ (void)logAllFilters
{
    //    NSArray *properties = [CIFilter filterNamesInCategory: kCICategoryBuiltIn];
    //    NSLog(@"%@", properties);
    //    for (NSString *filterName in properties)
    //    {
    //        CIFilter *fltr = [CIFilter filterWithName:filterName];
    //        NSLog(@"%@", [fltr attributes]);
    //    }
}

+ (UIImage *)scaleImage:(UIImage *)originImage size:(CGSize)targetSize
{
    UIGraphicsBeginImageContext(targetSize);
    [originImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

/** 随机颜色*/
+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
#pragma mark- NSString & mutistring

+ (CGFloat)heightForFont:(UIFont *)font
{
    NSString *str =  @"测试文字";
    CGSize sizeStr = [self stringRectfor:str  font:font ].size;
    return sizeStr.height;
}

+(CGFloat)stringwidthfor:(NSString*)string font:(UIFont*)font
{
    
    CGRect textgetRect =  [self stringRectfor:string font:font];
    
    
    return (int)(textgetRect.size.width );
}





+(CGFloat)stringheightfor:(NSString*)string font:(UIFont*)font width:(CGFloat)width
{

    return (int)([self stringRectfor:string font:font width:width].size.height  );
 
}

+(CGRect)stringRectfor:(NSString*)string font:(UIFont*)font
{
    return [self stringRectfor:string font:font width:CGFLOAT_MAX];
}

+(CGRect)stringRectfor:(NSString*)string font:(UIFont*)font width:(CGFloat)width
{

    CGRect textgetRect = CGRectZero;
    
    if(string)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textgetRect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        
        textgetRect.size.width = (int)(textgetRect.size.width +1);
        textgetRect.size.height = (int)(textgetRect.size.height +1);
    }
    
    
    
    return textgetRect;
}

/** 判断string 对应字体 对应宽度 的绘画面积*/
+(CGRect)stringRectfor:(NSString*)string font:(UIFont*)font height:(CGFloat)height
{
    CGRect textgetRect = CGRectZero;
    textgetRect.size.height = height;
    if(string  )
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        NSString * addlengthString = @"占";
        //适合的高度
        NSInteger height_fit;
        do {
            /** 测试的宽度*/
            NSInteger width_test =  [self stringRectfor:addlengthString font:font ].size.width;
            
            height_fit = [string boundingRectWithSize:CGSizeMake(width_test, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
            
            textgetRect.size.width = width_test;
            
            addlengthString = [addlengthString stringByAppendingString:@"占"];
            
        } while (height_fit > height);
        
        textgetRect.size.width = (int)(textgetRect.size.width +1);
        textgetRect.size.height = (int)(textgetRect.size.height +1);
        
    }
    
    return textgetRect;

}

+(NSArray*)stringSub:(NSString*)string byFont:(UIFont*)font  byWidth:(float)width returnUsefull:(BOOL)userful
{
    if(string && [string isKindOfClass:[NSString class]] && string.length >0)
    {
        
        if(userful)
        {
            /** 按换行拆分字符串*/
            NSArray * stringArray = [string componentsSeparatedByString:@"\n"];
            
            NSMutableArray * mutiStirngArraySum = [[NSMutableArray alloc] init];
            
            for(int i = 0 ; i < [stringArray count] ; i++)
            {
                NSArray * getArray = [self stringSub:[stringArray objectAtIndexSafe:i] byFont:font byWidth:width returnUsefull:NO];
                [mutiStirngArraySum addObjectsFromArray:getArray];
            }
            
            return mutiStirngArraySum;
        }
        else
        {
            /** 没有换行的string*/
            NSString * noReturnString = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            if(noReturnString.length > 0)
            {
                /** 当前判断的启示位置*/
                int sub_start = 0;
                /** 当前判断的字符串宽度*/
                int sub_length   = 1;
                /** 适配的宽度(为防止错误，预留5像素)*/
                float piPeiWidth = width - 2;
                /** 安宽度分割的字符串*/
                NSMutableArray * stringSubArray = [[NSMutableArray alloc] init];
                
                
                while (sub_start + sub_length <= [noReturnString length]) {
                    if(sub_start + sub_length <= [noReturnString length])
                    {
                        /** 要检查的字符串*/
                        NSString * checkstring = [noReturnString substringWithRange:NSMakeRange(sub_start, sub_length)];
                        /** 当前字符串的宽度*/
                        float currentWidth = [self stringwidthfor:checkstring font:font];
                        
                        if(currentWidth > piPeiWidth)
                        {
                            
                            if( (sub_length -1 >0))
                            {
                                /** 适合宽度的字符串*/
                                NSString * fitStirng = [noReturnString substringWithRange:NSMakeRange(sub_start, sub_length-1)];
                                [stringSubArray addObjectSafe:fitStirng];
                                
                                sub_start += sub_length -1;
                                sub_length = 1;
                                
                            }
                        }
                        else
                        {
                            sub_length ++;
                        }
                    }
                }
                if(sub_start <= [noReturnString length]-1)
                {
                    //最后一个
                    /** 适合宽度的字符串*/
                    NSString * fitStirng = [noReturnString substringWithRange:NSMakeRange(sub_start, [noReturnString length]-sub_start)];
                    [stringSubArray addObjectSafe:fitStirng];
                }
                
                return stringSubArray;
                
            }
            
        }
        
    }
    
    return @[];
}

/** 限制文本的宽度 tril yes 增加@"..."*/
+(NSString*)limitString:(NSString*)string InWidth:(CGFloat)length font:(UIFont*)font addTril:(BOOL)tril
{
    NSString * string_result = string;
    
    CGFloat width = [MyControl stringwidthfor:string_result font:font];
    
    if(width <= length)
    {
        return string_result;
    }
    else
    {
        if(string_result.length > 0 && length > 0)
        {// 确保不会有无结果的情况
            
            string_result = [string_result substringWithRange:NSMakeRange(0, string_result.length-1)];
            
            if(tril)
            {
                NSString * string_tril =   @"...";
                CGFloat trilLength =  [MyControl stringwidthfor:string_tril font:font];
                length = length - trilLength;
                
                
                NSString * notrilledString = [self limitString:string_result InWidth:length font:font addTril:NO];
                
                string_result = [NSString stringWithFormat:@"%@%@",notrilledString,string_tril];
                
                return string_result;
            }
            else
            {
                return [self limitString:string_result InWidth:length font:font addTril:NO];
            }
            
        }
        
    }
    return string_result;
}


+(CGFloat)mutistringwidthfor:(NSMutableAttributedString*)mutistring
{
    CGRect textgetRect;
    textgetRect = [self mutistringRectfor:mutistring];
    
    return (int)textgetRect.size.width;
}



+(CGRect)mutistringRectfor:(NSMutableAttributedString*)mutistring
{
   

    CGRect textgetRect  = [mutistring boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    textgetRect.size.width = (int)(textgetRect.size.width +1);
    textgetRect.size.height = (int)(textgetRect.size.height +1);
    
    return textgetRect;
}



/** 添加颜色*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddColor:(UIColor*)color forRange:(NSRange)range
{
    /** 添加颜色样式*/
    NSMutableAttributedString * str = mutistring;
    if(range.location + range.length <= str.length)
    {
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    
}

/** 添加font*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddFont:(UIFont*)font forRange:(NSRange)range
{
    /** 添加大小样式*/
    NSMutableAttributedString * str = mutistring;
    if(range.location + range.length <= str.length)
    {
    [str addAttribute:NSFontAttributeName value:font range:range];
    }

}

/** 添加下划线*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddUnderLin:(UIColor*)color forRange:(NSRange)range
{

    NSMutableAttributedString * str = mutistring;
    if(range.location + range.length <= str.length)
    {
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
        [str addAttribute:NSUnderlineColorAttributeName value:color range:range];
//        NSUnderlineByWord
    }

}

/** 添加间隔*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddLineSpace:(CGFloat)lineSapce forRange:(NSRange)range
{

    NSMutableAttributedString * str = mutistring;
    if(range.location + range.length <= str.length)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSapce];//调整行间距
        
         [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }

}

/** 添加段间隔*/
+(void)mutiString:(NSMutableAttributedString*)mutistring AddParaGraphSpace:(CGFloat)ParagraphSpacing forRange:(NSRange)range
{
    
    NSMutableAttributedString * str = mutistring;
    if(range.location + range.length <= str.length)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setParagraphSpacing:ParagraphSpacing];//调整行间距
        
        [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
    
}

/** 获取适合这个宽度的字体 8 - 50*/
+ (UIFont * )fontForString:(NSString*)string width:(CGFloat)width
{
    UIFont * font_fit = nil;
    
    NSInteger fitSize = 8;
    
    for ( int i = 9 ; i <= 40 ; i ++ )
    {
      CGFloat length_string =   [MyControl stringwidthfor:string font:[UIFont systemFontOfSize:i]];
        
        if(length_string > width)
        {
            fitSize = i - 1;
            break;
        }
    }
    
    font_fit = [UIFont systemFontOfSize:fitSize];
    
    return font_fit;
}

#pragma mark- 区域
/** 计算 frame edge*/
+(CGRect)frameInFrame:(CGRect)frame edge:(UIEdgeInsets)EdgeInsets
{

    CGRect rect_image = CGRectMake(0, 0, frame.size.width, frame.size.height);
    rect_image.origin.x = EdgeInsets.left;
    rect_image.origin.y = EdgeInsets.top;
    rect_image.size.width = rect_image.size.width - EdgeInsets.left - EdgeInsets.right;
    rect_image.size.height = rect_image.size.height - EdgeInsets.top - EdgeInsets.bottom;
    
    return rect_image;
}

//求出在比例不变的情况下，放置在区域中的大小位置。middle：是否放于区域中间
+(CGRect)sizeWith:(CGSize)size Scaleinrect:(CGRect)outrect putmiddle:(BOOL)middle
{
    if(outrect.size.height == 0 || size.height == 0)
    {
        return CGRectMake(0, 0, 0, 0);
    }
    
    float outbili = outrect.size.width/outrect.size.height;
    float inbili = size.width/size.height;
    
    if(outbili == inbili)
    {
        return outrect;
    }
    
    if(outbili > inbili)
    {
        int newwidth = inbili*outrect.size.height;
        int x = 0;
        if(middle)
        {
            x =(outrect.size.width - newwidth)/2;
        
        }
        
        CGRect newrect = CGRectMake(outrect.origin.x + x, outrect.origin.y, newwidth, outrect.size.height);
        
        return newrect;
    }
    
    if(outbili < inbili)
    {
        int newheight = outrect.size.width/inbili;
        int y = 0;
        if(middle)
        {
            y =(outrect.size.height - newheight)/2;
            
        }
        
        CGRect newrect = CGRectMake(outrect.origin.x, outrect.origin.y + y, outrect.size.width,newheight );
        
        return newrect;
    }
    
    return outrect;
}

+(UIEdgeInsets)UIedgeInsetsCenterForSize:(CGSize)size_in outBounds:(CGSize)size_out
{
    UIEdgeInsets value =  UIEdgeInsetsMake((size_out.height - size_in.height)/2, (size_out.width - size_in.width)/2, (size_out.height - size_in.height)/2, (size_out.width - size_in.width)/2);

    return value;
}

/** 获取两点间的大小*/
+(CGSize)sizeBetweenPoint:(CGPoint)point1 point:(CGPoint)point2
{
    CGFloat width = fabs(point1.x - point2.x) ;
    
    CGFloat height = fabs(point1.y - point2.y );
    
    return  CGSizeMake(width, height);
}

#pragma mark-  添加样式
/** 添加阴影*/
+(UIView*)addShadowWithView:(UIView*)view
{
    BLImageView * sepView2 = [MyControl createImageViewWithFrame:CGRectMake(0, 0, view.width, SameH(2)) imageName:@"common_sepShadow.png"];
    sepView2.top = view.height;
    sepView2.tag = createViewShadowTag;
    [view addSubview:sepView2];
    return sepView2;
}
/** 添加上部阴影*/
+(UIView*)addTopShadowWithView:(UIView*)view
{
    BLImageView * sepView2 = [MyControl createImageViewWithFrame:CGRectMake(0, 0, view.width, SameH(2)) imageName:@"common_sepShadow.png"];
    sepView2.transform = CGAffineTransformMakeRotation(M_PI);
    sepView2.frame = CGRectMake(0, 0, view.width, SameH(2));
    sepView2.bottom = 0;
    sepView2.tag = createViewTopShadowTag;
    [view addSubview:sepView2];
    return sepView2;
}


/** 像素对应的视图高度*/
+(CGFloat)widthForPx:(NSInteger)px
{
    
    return px /[UIScreen mainScreen].scale;

}

/** 添加分割线
 @param view 添加分割线的视图
 @param location 添加分割线的位置
 @param downOrTop 底部还是顶部yes顶部，top顶部
 */
+(BLView*)addSepViewWithView:(UIView*)view location:(CGFloat)location downOrTop:(BOOL)downOrTop
{
    //分割线
    BLView * view_sep = [MyControl createSepViewWithWidth:view.width];
    view_sep.top = location;
    if(downOrTop)
    {
        view_sep.top = location;
    }
    else
    {
        view_sep.bottom = location;
    }

    [view addSubview:view_sep];
    
    
    return view_sep;
}

/** 制作宽度的视图*/
+(BLView*)createSepViewWithWidth:(NSInteger)width
{
    //分割线
    BLView * view_sep = [MyControl createViewWithFrame:CGRectMake(0, 0, width , [self widthForPx:1] )];
    view_sep.backgroundColor = color_second_sep_gray;
    view_sep.tag = createViewSepTag;
    return view_sep;
}

/** 制作高度的视图*/
+(BLView*)createSepViewWithHeight:(NSInteger)height
{
    //分割线
    BLView * view_sep = [MyControl createViewWithFrame:CGRectMake(0, 0, [self widthForPx:1],height )];
    view_sep.backgroundColor = color_second_sep_gray;
    view_sep.tag = createViewSepTag;
    return view_sep;
}


/** 隐藏数组中所有的视图 （可以连接数组）*/
+(void)hideAllViewInArray:(NSArray*)array
{
    for ( id object in array)
    {
        if([object isKindOfClass:[UIView class]])
        {//视图对象
            UIView * view_object = object;
            view_object.hidden = YES;
        }
        if([object isKindOfClass:[NSArray class]])
        {//数组对象
            NSArray * array_object = object;
            [self hideAllViewInArray:array_object];
        }
    
    }
}

/** 显示数组中所有的视图 （可以连接数组）*/
+(void)showAllViewInArray:(NSArray*)array
{
    {
        for ( id object in array)
        {
            if([object isKindOfClass:[UIView class]])
            {//视图对象
                UIView * view_object = object;
                view_object.hidden = NO;
            }
            if([object isKindOfClass:[NSArray class]])
            {//数组对象
                NSArray * array_object = object;
                [self showAllViewInArray:array_object];
            }
        }
    }
}


@end
