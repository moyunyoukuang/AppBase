//
//  ShouSuoView.m
//  ShouSuoTest
//
//  Created by camore on 17/2/6.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "ShouSuoView.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface ShouSuoView ()
{
    /***************数据控制***************/
    
    /** 动画中*/
    BOOL           isAnimating;
    
    /** yes收缩 no 放*/
    BOOL           isShouSuo;
    
    /** 最小图片切割大小*/
    float sliceHeight ;
    
    /** 完成block*/
    void (^block_finish)(void);
    
    /** 定时器*/
    NSTimer     *  timer_animate;
    
    /** 图像剪切图*/
    NSMutableArray  *   array_imageSlice;
    
    /** 缩放路径*/
    UIBezierPath * path_move ;
    
    /** 路径竖切线*/
    NSInteger  BottomY[2000], TopY[2000];
    
    /** 动画起始点*/
    NSInteger       startX;
    
    /** 动画结束点*/
    NSInteger       endX;
    
    /** 动画总帧数*/
    NSInteger       zhenCount;
    
    /** 动画总时长*/
    CGFloat         time_animate;
    
    /** 当前动画桢*/
    NSInteger       currentZhen;
    
    /** 结束点*/
    CGPoint         point_end;
    
    /** 动画视图的初始坐标*/
    CGRect          rect_view_move;
    
    /** 执行动画的视图*/
    UIView          *   view_animate;
    
    /** 动画起始时间*/
    NSTimeInterval  animate_start;
    
 
    /***************视图***************/
    /** 动画视图*/
    UIImageView * imageView_animate;
    
    
}
@end

@implementation ShouSuoView



#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self chuShiHua];
        [self setUpViews];
    }
    return self;
}
-(void)chuShiHua
{
    sliceHeight = 1;
}

-(void)setUpViews
{
    
    [self createAllView];
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
//    CGContextSaveGState(context);
//    
//    
//    CGContextSetLineWidth(context, 1);
//    
//    
//    [path_move stroke];
//    
//    
//    //还原现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
//    CGContextRestoreGState(context);
//    
//}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
/** 收缩视图到点*/
-(void)shouSuo:(BOOL)shousuo View:(UIView*)view_shousuo toPoint:(CGPoint)point finishBlcok:(void(^)())finishblock
{
    [self shouSuo:shousuo View:view_shousuo toPoint:point direction:2 duration:0.35 finishBlcok:finishblock];
}

/** 收缩视图到点
 @param direction 0,左，1，上，2右，3下
 :*/
-(void)shouSuo:(BOOL)shousuo View:(UIView*)view_shousuo toPoint:(CGPoint)point direction:(NSInteger)direction duration:(CGFloat)duration finishBlcok:(void(^)())finishblock
{
    
    block_finish = [finishblock copy];
    
    isShouSuo = shousuo;
    
    time_animate = duration;
    
    self.frame = view_shousuo.superview.bounds;
    
    zhenCount = [self getPathCountFromView:view_shousuo point:point Direction:direction];
    
    if(view_shousuo == view_animate && isAnimating)
    {//之前的视图的动画，如果是同一个，做反方向动画
        currentZhen = zhenCount - currentZhen;
    }
    else
    {
        currentZhen = 0;
    }
    
    
    
    [self startAnimate];
    
    view_animate = view_shousuo;
}

/** 开始动画*/
-(void)startAnimate
{
    animate_start = [NSDate timeIntervalSinceReferenceDate];
    isAnimating = YES;
    imageView_animate.image = [self getImageForZhen:currentZhen];
    [timer_animate invalidate];
    timer_animate = [NSTimer scheduledTimerWithTimeInterval:1.0/ShouSuoViewZhenPreSecond target:self selector:@selector(animateChange:) userInfo:nil repeats:YES];
    
}

/** 动画切换*/
-(void)animateChange:(NSTimer*)timer
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    currentZhen = (int)((currentTime - animate_start)*zhenCount/time_animate);
    
    
    NSInteger index_image = currentZhen +1;
    
    if(index_image < zhenCount)
    {//下个图片
        currentZhen = index_image;
        imageView_animate.image = [self getImageForZhen:index_image];
    }
    else
    {//结束
        [timer invalidate];
        timer = nil;
        imageView_animate.image = nil;
        isAnimating = NO;
        block_finish();
        block_finish = nil;
    }
    
    
}
#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{
    imageView_animate = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView_animate.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView_animate];
    
    
    
    
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面


/** 计算路径桢 初始化数据*/
-(NSInteger)getPathCountFromView:(UIView*)view point:(CGPoint)point Direction:(NSInteger)direction
{
    point_end = point;
    rect_view_move = view.frame;
    startX = view.frame.origin.x;
    endX    =   point.x;
    
    /** 图片*/
    UIImage * image_view = [self imageview:view];
    /** 图片切割数组*/
    array_imageSlice = [NSMutableArray array];
    for (int i= 0; i < image_view.size.width/sliceHeight; i++)
    {
        
        UIImage * image = [self getSubImage:image_view rect:CGRectMake(i*sliceHeight, 0, sliceHeight, image_view.size.height)];
        
        [array_imageSlice addObject:image];
    }
    
    ///获取绘画路径
    UIBezierPath * Drawpath = [self getPathFromView:view point:point Direction:direction];
    
    path_move = Drawpath;
    
    
    ///获取路径竖切线
    for(NSInteger i = 0 ; i < 2000 ; i ++ )
    {//设置初始值
        BottomY[i] = point.y ;
        TopY[i] = point.y ;
    }
    
    
    for(NSInteger i = startX; i <= endX;  i += sliceHeight)
    {
        CGFloat x = i;
        CGFloat y = 0;
    
        
        for (  y = 0; y <= self.bounds.size.height; y++)
        {
            if([Drawpath containsPoint:CGPointMake(x, y)])
            {
                TopY[i] = y;
                break;
            }
        }
        //        if (y == self.bounds.size.height) {
        //            TopY[i] = 0;
        //        }
        for (y = self.bounds.size.height; y > TopY[i] ; y--)
        {
            if([Drawpath containsPoint:CGPointMake(x, y)])
            {
                BottomY[i] = y;
                break;
            }
        }
        if (y <= TopY[i]) {
            BottomY[i] = TopY[i];
        }
    }
    
    ///获取图片
    /** 所有动画数量*/
    NSInteger animationCount = time_animate * ShouSuoViewZhenPreSecond;
    
    return animationCount;
}

/** 获取路径图片*/
-(UIImage*)getImageForZhen:(NSInteger)zhen
{
    if(!isShouSuo)
    {//放大动画与缩小动画是反着来的
        zhen = zhenCount - zhen;
    }
    
    UIImage * image_result = nil;
    
    ///移动动画速率
    NSInteger moveSpeed = (endX-startX)/(zhenCount/2);
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if(zhen <= zhenCount/2 )
    {//缩小动画
        CGContextClearRect(context, self.bounds);
        
        CGContextSaveGState(context);
        
        for ( NSInteger i = 0 ; i < [array_imageSlice count] ; i++)
        {
            //绘画图像
            CGPoint topPoint1 = CGPointMake(i + startX, TopY[i]);
            //缩小
            topPoint1.y = rect_view_move.origin.y + (topPoint1.y - rect_view_move.origin.y)*zhen/(zhenCount/2);
            
            //绘画图像
            CGPoint BottomPoint1 = CGPointMake(i + startX , BottomY[i] );
            //缩小
            BottomPoint1.y = rect_view_move.origin.y + rect_view_move.size.height - (rect_view_move.size.height + rect_view_move.origin.y - BottomPoint1.y)*zhen/(zhenCount/2);
            
            CGRect rect_draw = CGRectMake(topPoint1.x, topPoint1.y, sliceHeight, BottomPoint1.y - topPoint1.y);
            
            UIImage * image_slice = [array_imageSlice objectAtIndex:i];
            
            if(rect_draw.size.height > 0 && rect_draw.size.width > 0)
            {
                [image_slice drawInRect:rect_draw];
            }
        }
        
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        
        
        image_result = image;
        
        CGContextRestoreGState(context);
    }
    else
    {//平移动画
        zhen = zhen - zhenCount/2 +1;
        
        CGContextClearRect(context, self.bounds);
        
        CGContextSaveGState(context);
        
        for ( NSInteger i = 0 ; i < [array_imageSlice count] ; i++)
        {
            //绘画图像
            CGPoint topPoint1 = CGPointMake(i + startX + zhen*moveSpeed, TopY[i + zhen*moveSpeed]);
            
            //绘画图像
            CGPoint BottomPoint1 = CGPointMake(i + startX + zhen*moveSpeed, BottomY[i + zhen*moveSpeed] );
            
            CGRect rect_draw = CGRectMake(topPoint1.x, topPoint1.y, sliceHeight, BottomPoint1.y - topPoint1.y);
            
            UIImage * image_slice = [array_imageSlice objectAtIndex:i];
            if(rect_draw.size.height > 0 && rect_draw.size.width > 0)
            {
                [image_slice drawInRect:rect_draw];
            }
            
        }
        
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        
        image_result = image;
        
        CGContextRestoreGState(context);
        
    }
    
    UIGraphicsEndImageContext();
    
    return image_result;
}

/** 获取动画路径
 @param direction 0,左，1，上，2右，3下
 */
-(UIBezierPath * )getPathFromView:(UIView*)view point:(CGPoint)point Direction:(NSInteger)direction
{
    UIBezierPath * pathRef = [UIBezierPath bezierPath];
    
    NSString* nofinish ;// 这里只处理了direction为2 的情况，节省时间，其他情况自己加
    
    
    //两个无关联点 顺时针
    CGPoint point1 = CGPointMake(view.frame.origin.x, view.frame.origin.y + view.frame.size.height );
    CGPoint point2 = CGPointMake(view.frame.origin.x, view.frame.origin.y  );
    
    //    //两个关联点
    //    CGPoint point3 = CGPointMake(view.frame.origin.x + view.frame.size.width, view.frame.origin.y  );
    //    CGPoint point4 = CGPointMake(view.frame.origin.x + view.frame.size.width, view.frame.origin.y + view.frame.size.height );
    //    //关联高度
    //    NSInteger relationgHeihgt = view.frame.size.width;
    //    NSInteger relationgWidth = view.frame.size.height;
    //    [pathRef moveToPoint:point1];
    //    [pathRef addLineToPoint:point4];
    //
    //    [pathRef addCurveToPoint:point controlPoint1:CGPointMake(point4.x+(point.x-point4.x)*0.3, point4.y - (point4.y - point.y)*0.1) controlPoint2:CGPointMake(point4.x+(point.x-point4.x)*0.6, point4.y - (point4.y - point.y)*0.9)];
    //    [pathRef addCurveToPoint:point3 controlPoint1:CGPointMake(point3.x+(point.x-point3.x)*0.6, point3.y - (point3.y - point.y)*0.9) controlPoint2:CGPointMake(point3.x+(point.x-point3.x)*0.3, point3.y - (point3.y - point.y)*0.1)];
    //    [pathRef addLineToPoint:point2];
    
    [pathRef moveToPoint:point1];
    [pathRef addCurveToPoint:point controlPoint1:CGPointMake(point1.x+(point.x-point1.x)*0.3, point1.y - (point1.y - point.y)*0.1) controlPoint2:CGPointMake(point1.x+(point.x-point1.x)*0.6, point1.y - (point1.y - point.y)*0.9)];
    [pathRef addCurveToPoint:point2 controlPoint1:CGPointMake(point2.x+(point.x-point2.x)*0.6, point2.y - (point2.y - point.y)*0.9) controlPoint2:CGPointMake(point2.x+(point.x-point2.x)*0.3, point2.y - (point2.y - point.y)*0.1)];
    
    
    
    return pathRef;
}

/**  从view截取图片*/
- (UIImage *)imageview:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)getSubImage:(UIImage*)image rect:(CGRect)rect
{
    //    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    //
    ////    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    //    [image drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    //
    //    UIImage *image_get = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    //
    //    return image_get;
    
    //    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(rect.origin.x*image.scale, rect.origin.y*image.scale, rect.size.width*image.scale, rect.size.height*image.scale));
    //    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    //    UIGraphicsBeginImageContext(smallBounds.size);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextDrawImage(context, smallBounds, subImageRef);
    //    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    //    UIGraphicsEndImageContext();
    //    CGImageRelease(subImageRef);
    //    return smallImage;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(rect.origin.x*image.scale, rect.origin.y*image.scale, rect.size.width*image.scale, rect.size.height*image.scale)) ;
    UIImage * image_get = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:UIImageOrientationUp];
    //CATransform3D
    
    return image_get;
}
#pragma mark- ********************跳转其他页面********************


@end
