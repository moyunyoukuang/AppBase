//
//  PicLiuLanView.m
//  DaJiShi
//
//  Created by camore on 16/7/26.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "PicLiuLanView.h"
static const CGFloat kMaxImageScale = 2.5f;
static const CGFloat kMinImageScale = 1.0f;

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface PicLiuLanView()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    /***************数据控制***************/
    
    /** 图片被双击打开了(打开后开启pan手势)*/
    BOOL    isOpened;
    
    /** 显示图片(可以作为默认图)*/
    UIImage * image_show;
    /** 图片地址*/
    NSString * url_image;
    
  
    
    /** 旋转功能*/
    UIRotationGestureRecognizer  *   gesture_rotate;
    

    
    /***************视图***************/
    
    /** 背部scrollview*/
    UIScrollView    *   scrollView_back;
    /** 展示图片的视图*/
    UIImageView     *   imageview_show;
    
}




@end


@implementation PicLiuLanView




#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

/** 创建视图，用图片或者链接 */
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image OrUrl:(NSString *)url
{
    self = [super initWithFrame:frame];
    if(self)
    {
        image_show = image;
        
        url_image  = url;
        
        [self chuShiHua];
        [self setUpViews];
    }
    return self;
}


-(void)chuShiHua
{

    
    
}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
/** 双击放大 双击缩小功能 默认开启*/
-(void)enAbleDoubleClcike:(BOOL)enable
{
    self.gesture_doubleClick.enabled = enable;
}


/** 旋转功能 默认关闭*/
-(void)enAbleRotate:(BOOL)enable
{
    gesture_rotate.enabled = enable;
}

/** 设置内容*/
-(void)setimage:(UIImage*)image OrUrl:(NSString *)url
{
    image_show = image;

    url_image = url;
    
    imageview_show.image = nil;
    
    [imageview_show sd_cancelCurrentImageLoad];
     [scrollView_back setZoomScale:1.0f animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(url_image.length > 0 )
        {
            __block UIImageView * _imageViewInTheBlock = imageview_show;
            __weak typeof(self)  weakself = self;
            [imageview_show sd_setImageWithURL:[NSURL URLWithStringSafe:url_image] placeholderImage:image_show completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                __strong typeof(self) strongSelf = weakself;
                
                [scrollView_back setZoomScale:1.0f animated:YES];
                
                [_imageViewInTheBlock setImage:image];
                _imageViewInTheBlock.frame = [strongSelf centerFrameFromImage:_imageViewInTheBlock.image];
            }];
        }
        
        
        if(image_show)
        {
            imageview_show.image = image_show;
            [scrollView_back setZoomScale:1.0f animated:YES];
            [imageview_show setImage:image_show];
            imageview_show.frame = [self centerFrameFromImage:image_show];
        }
        scrollView_back.minimumZoomScale = kMinImageScale;
        scrollView_back.maximumZoomScale = kMaxImageScale;
        scrollView_back.zoomScale = 1;
        [self centerScrollViewContents];
    });
}

#pragma mark- ********************点击事件********************

/** 上下移动 移除视图手势*/
- (void) gestureRecognizerDidPan:(UIPanGestureRecognizer*)panGesture {
//    if(scrollView_back.zoomScale != 1.0f || _isAnimating)return;
//    if(_imageIndex==_initialIndex){
//        if(_senderView.alpha!=0.0f)
//            _senderView.alpha = 0.0f;
//    }else {
//        if(_senderView.alpha!=1.0f)
//            _senderView.alpha = 1.0f;
//    }
//    // Hide the Done Button
//    [self hideDoneButton];
//    scrollView_back.bounces = NO;
//    CGSize windowSize = _blackMask.bounds.size;
//    CGPoint currentPoint = [panGesture translationInView:scrollView_back];
//    CGFloat y = currentPoint.y + _panOrigin.y;
//    CGRect frame = __imageView.frame;
//    frame.origin = CGPointMake(0, y);
//    __imageView.frame = frame;
//    
//    CGFloat yDiff = fabs((y + __imageView.frame.size.height/2) - windowSize.height/2);
//    _blackMask.alpha = MAX(1 - yDiff/(windowSize.height/2),kMinBlackMaskAlpha);
//    
//    if ((panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled) && scrollView_back.zoomScale == 1.0f) {
//        
//        if(_blackMask.alpha < 0.7) {
//            [self dismissViewController];
//        }else {
//            [self rollbackViewController];
//        }
//    }
}

#pragma mark - For Zooming
/** 双指点击缩小*/
- (void)didTwoFingerTap:(UITapGestureRecognizer*)recognizer {
    CGFloat newZoomScale = scrollView_back.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, scrollView_back.minimumZoomScale);
    [scrollView_back setZoomScale:newZoomScale animated:YES];
}

#pragma mark - Showing of Done Button if ever Zoom Scale is equal to 1
- (void)didSingleTap:(UITapGestureRecognizer*)recognizer {
    /*
     if (_tap2Close) {
     [self close:_doneButton];
     return;
     }
     if(_doneButton.superview){
     [self hideDoneButton];
     }else {
     if(scrollView_back.zoomScale == scrollView_back.minimumZoomScale){
     if(!_isDoneAnimating){
     _isDoneAnimating = YES;
     [self.viewController.view addSubview:_doneButton];
     _doneButton.alpha = 0.0f;
     [UIView animateWithDuration:0.2f animations:^{
     _doneButton.alpha = 1.0f;
     } completion:^(BOOL finished) {
     [self.viewController.view bringSubviewToFront:_doneButton];
     _isDoneAnimating = NO;
     }];
     }
     }else if(scrollView_back.zoomScale == scrollView_back.maximumZoomScale) {
     CGPoint pointInView = [recognizer locationInView:__imageView];
     [self zoomInZoomOut:pointInView];
     }
     }
     */
    
//    self.userInteractionEnabled = NO;
//    [self dismissViewController];
}
#pragma mark - Zoom in or Zoom out
- (void)didDobleTap:(UITapGestureRecognizer*)recognizer {
    CGPoint pointInView = [recognizer locationInView:imageview_show];
    [self zoomInZoomOut:pointInView];
}

#pragma mark - rotate
- (void)didrotate:(UIRotationGestureRecognizer*)rotate
{
    CGAffineTransform rot = CGAffineTransformMakeRotation([rotate rotation]);
    [rotate view].transform=rot;
}



#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark - UIScrollViewDelegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageview_show;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
//    _isAnimating = YES;
//    [self hideDoneButton];
    [self centerScrollViewContents];
}

- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    _isAnimating = NO;
}

#pragma mark - Gesture recognizer
//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
//    CGPoint translation = [panGestureRecognizer translationInView:scrollView_back];
//    return fabs(translation.y) > fabs(translation.x) ;
//    
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
////    _panOrigin = __imageView.frame.origin;
////    gestureRecognizer.enabled = YES;
////    return !_isAnimating;
//    
//    return YES;
//}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // Uncomment once iOS7 beta5 bugs for panGestures are worked out
    //    UITableView * tableView = (UITableView*)self.superview;
    //    if ( [tableView respondsToSelector:@selector(panGestureRecognizer)] &&
    //         [otherGestureRecognizer isEqual:(tableView.panGestureRecognizer)] )
    //    {
    //        return NO;
    //    }
    return YES;
}

#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{
   
    
    
    //scroll
    scrollView_back = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView_back.bounces = YES;
  
    
    scrollView_back.clipsToBounds = YES;
    scrollView_back.delegate = self;
//    scrollView_back.minimumZoomScale = kMinImageScale;
//    scrollView_back.maximumZoomScale = kMaxImageScale;
//    scrollView_back.zoomScale = 1;
    [self addSubview:scrollView_back];
    
    [scrollView_back setShowsVerticalScrollIndicator:YES];
    [scrollView_back setShowsHorizontalScrollIndicator:YES];
    
    //image
    imageview_show = [[UIImageView alloc]init];
    imageview_show.contentMode = UIViewContentModeScaleAspectFill;
    [scrollView_back addSubview:imageview_show];
    
    imageview_show.image = image_show;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(url_image.length > 0 )
        {
            __block UIImageView * _imageViewInTheBlock = imageview_show;
            __weak typeof(self)  weakself = self;
            [imageview_show sd_setImageWithURL:[NSURL URLWithStringSafe:url_image] placeholderImage:image_show completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                __strong typeof(self) strongSelf = weakself;
                
                [scrollView_back setZoomScale:1.0f animated:YES];
                
                [_imageViewInTheBlock setImage:image];
                _imageViewInTheBlock.frame = [strongSelf centerFrameFromImage:_imageViewInTheBlock.image];
            }];
        }
        
        
        if(image_show)
        {
            imageview_show.image = image_show;
            [scrollView_back setZoomScale:1.0f animated:YES];
            [imageview_show setImage:image_show];
            imageview_show.frame = [self centerFrameFromImage:image_show];
        }
        scrollView_back.minimumZoomScale = kMinImageScale;
        scrollView_back.maximumZoomScale = kMaxImageScale;
        scrollView_back.zoomScale = 1;
        [self centerScrollViewContents];
    });
    
    
    self.exclusiveTouch = YES;
    
    //手势

    [self addMultipleGesture];

    
}



- (void)addMultipleGesture {
    
    ///双指点击缩小
//    UITapGestureRecognizer *twoFingerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTwoFingerTap:)];
//    twoFingerTapGesture.numberOfTapsRequired = 1;
//    twoFingerTapGesture.numberOfTouchesRequired = 2;
//    [scrollView_back addGestureRecognizer:twoFingerTapGesture];
    
    //点击取消浏览手势
//    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSingleTap:)];
//    singleTapRecognizer.numberOfTapsRequired = 1;
//    singleTapRecognizer.numberOfTouchesRequired = 1;
//    [scrollView_back addGestureRecognizer:singleTapRecognizer];
    
    //上下滑动取消手势
//    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
//                                                                                 action:@selector(gestureRecognizerDidPan:)];
//    panGesture.cancelsTouchesInView = YES;
//    panGesture.delegate = self;
//    [scrollView_back addGestureRecognizer:panGesture];
//    panGesture = nil;
    
    //旋转
    UIRotationGestureRecognizer* rotaion=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(didrotate:)];
    [scrollView_back addGestureRecognizer:rotaion];
    rotaion.delegate = self;
    gesture_rotate = rotaion;
    gesture_rotate.enabled = NO;
    
    //双击放大缩小
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDobleTap:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    doubleTapRecognizer.delegate = self;
    [scrollView_back addGestureRecognizer:doubleTapRecognizer];
    self.gesture_doubleClick = doubleTapRecognizer;
    
 
    [self centerScrollViewContents];
}

#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面



/** 获取图片对应的中心位置 （变形后）*/
- (CGRect) centerFrameFromImage:(UIImage*) image {
    if(!image) return CGRectZero;
    
    CGRect windowBounds = self.bounds;
    CGSize newImageSize = [self imageResizeBaseOnWidth:windowBounds
                           .size.width oldWidth:image
                           .size.width oldHeight:image.size.height];
    // Just fit it on the size of the screen
    newImageSize.height = MIN(windowBounds.size.height,newImageSize.height);
    return CGRectMake(0.0f, windowBounds.size.height/2 - newImageSize.height/2, newImageSize.width, newImageSize.height);
}

/** 大小比例*/
- (CGSize)imageResizeBaseOnWidth:(CGFloat) newWidth oldWidth:(CGFloat) oldWidth oldHeight:(CGFloat)oldHeight {
    CGFloat scaleFactor = newWidth / oldWidth;
    CGFloat newHeight = oldHeight * scaleFactor;
    return CGSizeMake(newWidth, newHeight);
    
}

/** 重置imageview 位置*/
- (void)centerScrollViewContents {
    
    CGSize boundsSize = self.bounds.size;
    CGRect contentsFrame = imageview_show.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    imageview_show.frame = contentsFrame;
}




/** 对某个点放大 缩小*/
- (void) zoomInZoomOut:(CGPoint)point {
    // Check if current Zoom Scale is greater than half of max scale then reduce zoom and vice versa
    CGFloat newZoomScale = scrollView_back.zoomScale > (scrollView_back.maximumZoomScale/2)?scrollView_back.minimumZoomScale:scrollView_back.maximumZoomScale;
    
    CGSize scrollViewSize = scrollView_back.bounds.size;
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = point.x - (w / 2.0f);
    CGFloat y = point.y - (h / 2.0f);
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    [scrollView_back zoomToRect:rectToZoomTo animated:YES];
    
    
}



/** 取消移除 回归*/
- (void)rollbackViewController
{
    //    _isAnimating = YES;
    //    [UIView animateWithDuration:0.2f delay:0.0f options:0 animations:^{
    //        __imageView.frame = [self centerFrameFromImage:__imageView.image];
    //        _blackMask.alpha = 1;
    //    }   completion:^(BOOL finished) {
    //        if (finished) {
    //            _isAnimating = NO;
    //        }
    //    }];
}

/** 移除*/
- (void)dismissViewController
{
    //    _isAnimating = YES;
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [self hideDoneButton];
    //        __imageView.clipsToBounds = YES;
    //        CGFloat screenHeight =  [[UIScreen mainScreen] bounds].size.height;
    //        CGFloat imageYCenterPosition = __imageView.frame.origin.y + __imageView.frame.size.height/2 ;
    //        BOOL isGoingUp =  imageYCenterPosition < screenHeight/2;
    //        [UIView animateWithDuration:0.2f delay:0.0f options:0 animations:^{
    //            if(_imageIndex==_initialIndex){
    //                __imageView.frame = _originalFrameRelativeToScreen;
    //            }else {
    //                __imageView.frame = CGRectMake(__imageView.frame.origin.x, isGoingUp?-screenHeight:screenHeight, __imageView.frame.size.width, __imageView.frame.size.height);
    //            }
    //            CGAffineTransform transf = CGAffineTransformIdentity;
    //            _rootViewController.view.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
    //            _blackMask.alpha = 0.0f;
    //        } completion:^(BOOL finished) {
    //            if (finished) {
    //                [_viewController.view removeFromSuperview];
    //                [_viewController removeFromParentViewController];
    //                _senderView.alpha = 1.0f;
    //                [UIApplication sharedApplication].statusBarHidden = NO;
    //                [UIApplication sharedApplication].statusBarStyle = _statusBarStyle;
    //                _isAnimating = NO;
    //                if(_closingBlock)
    //                    _closingBlock();
    //            }
    //        }];
    //    });
}
#pragma mark- ********************跳转其他页面********************
@end
