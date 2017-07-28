//
//  DrawSelectionView.m
//  DrawSelection
//
//  Created by camore on 17/2/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "DrawSelectionView.h"

#import "SelectionShadeView.h"

#import "PointCounter.h"

#import "DistanceControl.h"


@implementation DrawActionPoint

@end

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性





@interface DrawSelectionView () <UIGestureRecognizerDelegate>
{
    /***************数据控制***************/
    /** 按钮视图列表*/
    NSMutableArray <SelectionShadeButton*> *   array_buttons;
    
    /** 当前选中的 0，1，2   －1为未选择*/
    NSInteger               currentSelection;
    
    /** 距离控制器*/
    DistanceControl     *   disTanceController;
    
    /** 滑动位置记录*/
    DrawActionPoint     *   drawActionPoints;
    
    /** 动画状态开始了*/
    BOOL                    animationStart;
    
    /** 创建时的高度*/
    NSInteger               initHeight;
    
    /***************视图***************/
    
    /** 绘画视图*/
    SelectionShadeView * shadeView;
    
}
@property ( nonatomic , strong ) UIView * centerButton;
@end

@implementation DrawSelectionView


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
    array_buttons = [NSMutableArray array];
    
    currentSelection = -1;
    
    disTanceController = [[DistanceControl alloc] init];
    disTanceController.realLocation_start = 0;
    disTanceController.realLocation_end = self.frame.size.width;

    initHeight = self.top;
}

-(void)setUpViews
{
    
    [self createAllView];
    
}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件

-(void)reportDrawWithPercent:(CGFloat)percent  length:(CGFloat)length
{
    CGFloat selfAlpha = 0;
    
    if(percent > hideBallPercent)
    {
        selfAlpha = 1.0;
    }
    else
    {
        selfAlpha = percent / hideBallPercent;
    }
    self.alpha = selfAlpha;
    
    if([self.DrawSelectionViewDelegate respondsToSelector:@selector(DrawSelectionView:changeAlpha:length:)])
    {
        [self.DrawSelectionViewDelegate DrawSelectionView:self changeAlpha:percent length:length];
    }
}

-(void)reportSelectionAtIndex:(NSInteger)index
{
    if([self.DrawSelectionViewDelegate respondsToSelector:@selector(DrawSelectionView:SelectIndex:)])
    {
        [self.DrawSelectionViewDelegate DrawSelectionView:self SelectIndex:index];
    }
}

-(void)reportFinish
{
    if([self.DrawSelectionViewDelegate respondsToSelector:@selector(DrawSelectionViewFinish:)])
    {
        [self.DrawSelectionViewDelegate DrawSelectionViewFinish:self];
    }
}

/** 设置关联的滑动视图*/
-(void)setAssociateWithScrollView:(UIScrollView*)scrollView
{
    self.associatedScrollView = scrollView;
    
    if(!self.panGesture)
    {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        self.panGesture.delegate = self;
    }
    
    [scrollView addGestureRecognizer:self.panGesture];
    
}






/** 设置滑动的图像*/
-(void)addSelectionButton:(SelectionShadeButton*)button
{
    [shadeView addSubview:button];
    [array_buttons addObject:button];
    
    ///设置动画位置
    disTanceController.realLocation_start = [array_buttons firstObject].frame.origin.x + [array_buttons firstObject].frame.size.width/2;
    disTanceController.realLocation_end = [array_buttons lastObject].frame.origin.x + [array_buttons lastObject].frame.size.width/2;
    
    
    
    
}



/** 设置选中按钮（下拉时会旋转）*/
-(void)setCenterButtonIndex:(NSInteger)index
{
    self.centerButtonIndexDefault = index;
    currentSelection = index;
    [shadeView setCenterSelectionButton:[array_buttons objectAtIndexSafe:index]];
    self.centerButton = [array_buttons objectAtIndexSafe:index];
    
    
    CGPoint letfPoint  = [self getPointForIndex:0];
    CGPoint rightPoint = [self getPointForIndex:1];
    [shadeView setLongestShenSuoLength:( rightPoint.x - letfPoint.x ) ];
}


/** 动画显示出来了*/
-(BOOL)animating
{
    return animationStart;
}
#pragma mark- ********************点击事件********************
-(void)panView:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan locationInView:self.window];
    if(self.associatedScrollView)
    {
        CGPoint contentOffSet = [self.associatedScrollView contentOffset];
        if(contentOffSet.y < 0 && !animationStart)
        {//判断动画开始位置
            animationStart = YES;
            point.y = 0;
            [self startAtPoint:point];
        }
        
        if(animationStart)
        {
            point.y = -contentOffSet.y;
            
//            if(self.associatedScrollView.top > drawActionPoints.startLocation)
//            {
//                point.y += self.associatedScrollView.top - drawActionPoints.startLocation;
//            }
            
                
            if(pan.state == UIGestureRecognizerStateChanged )
            {
                [self moveToPoint:point];
            }
            if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed || pan.state == UIGestureRecognizerStateRecognized)
            {
                
                [self endAtPoint:point];
                animationStart = NO;
            }
        }
        
    }
    else
    {
        if(pan.state == UIGestureRecognizerStateBegan)
        {
            
            [self startAtPoint:point];
        }
        if(pan.state == UIGestureRecognizerStateChanged )
        {
            [self moveToPoint:point];
        }
        if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed || pan.state == UIGestureRecognizerStateRecognized)
        {
            [self endAtPoint:point];
        }
    }
    
    
    
    
}


#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark- UIGestureRecognizerDelegate <NSObject>

// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(otherGestureRecognizer == self.associatedScrollView.panGestureRecognizer)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark- DrawSelectionViewControl <NSObject>

///平滑设置操作

/** 开始位置*/
-(void)startAtPoint:(CGPoint)startPoint
{
    drawActionPoints = [[DrawActionPoint alloc] init];
    drawActionPoints.startPoint = startPoint;
    drawActionPoints.currentPoint = startPoint;
    drawActionPoints.startLocation = self.associatedScrollView.top;
    
    //还原位置
    currentSelection = 1;
    CGPoint buttonPoint = [self getPointForIndex:currentSelection];
    [shadeView moveViewToPoint:buttonPoint animate:NO];
    [self setSelectedButtonWithIndex:currentSelection];
}

/** 移动点*/
-(void)moveToPoint:(CGPoint)point
{
    
    drawActionPoints.currentPoint = point;
    
    //下拉
    [self dragToPoint:point];
    
    
    
}



/** 结束移动*/
-(void)endAtPoint:(CGPoint)stopPoint
{
    drawActionPoints.endPoint = stopPoint;
    drawActionPoints.noNeedFixPosition = NO;
    if(shadeView.isViewShowed && currentSelection >= 0 )
    {
        //有选项
        CGPoint point  = [self getPointForIndex:currentSelection];
        [shadeView moveViewToPoint:point animate:NO];
        [shadeView exPloreSelecteion];
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
            
        }];
        UIEdgeInsets edge = self.associatedScrollView.contentInset;
        edge.top += -self.associatedScrollView.contentOffset.y;
        self.associatedScrollView.contentInset = edge;
        [self performSelector:@selector(backToNormal) withObject:nil afterDelay:0.25];
        
        
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
            self.top = initHeight;
        }];
        [self reportFinish];
    }
    
    
    
    
    
}


#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{
    shadeView  = [[SelectionShadeView alloc] initWithFrame:self.bounds];
    shadeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:shadeView];
    
    self.alpha = 0;
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
/** 下拉*/
-(void)dragToPoint:(CGPoint)point
{
    float moveLength  = point.y - drawActionPoints.startPoint.y ;
    
    float movePerCent = moveLength/DrawSelectionViewShowViewLength;
    
    if(movePerCent < 0)
    {
        movePerCent = 0;
    }
    if(movePerCent > 1)
    {
        movePerCent = 1;
    }
    
    if(!shadeView.isViewShowed )
    {//未显示视图
        if(movePerCent >= 1)
        {//判断显示
            
            if(currentSelection < 0 )
            {// 还原显示
                currentSelection = self.centerButtonIndexDefault;
                CGPoint buttonPoint = [self getPointForIndex:currentSelection];
                [shadeView moveViewToPoint:buttonPoint animate:NO];
            }
            [self showDragAnimation:1];
            [self reportDrawWithPercent:1 length:moveLength];
            [shadeView setShowView:YES animate:YES];
            [self setSelectedButtonWithIndex:currentSelection];
            [self swipeStartAtPoint:point];
            
        }
        else
        {//渐显动画
            [self reportDrawWithPercent:movePerCent length:moveLength];
            [self showDragAnimation:movePerCent];
            if( moveLength < DrawSelectionViewShowViewLength*chongZhiBallPercent )
            {//推过高位置 重置圆点
                
                if(drawActionPoints.noNeedFixPosition )
                {
                    if(currentSelection >= 0)
                    {
                        CGPoint buttonPoint = [self getPointForIndex:currentSelection];
                        [shadeView moveViewToPoint:buttonPoint animate:NO];
                    }
                    
                    drawActionPoints.noNeedFixPosition = NO;
                }
            }
        }
    }
    else
    {//已显示视图
        if(moveLength < DrawSelectionViewShowViewLength*hideBallPercent)
        {//消失动画
            
            [shadeView setShowView:NO animate:YES];
            [self setSelectedButtonWithIndex:currentSelection];
            [self reportDrawWithPercent:movePerCent length:moveLength];
            [self showDragAnimation:movePerCent];
        }
        else
        {//滑动
            [self swipeToPoint:point];
            [self reportDrawWithPercent:movePerCent length:moveLength];
        }
    }
}

/** 滑动开始点*/
-(void)swipeStartAtPoint:(CGPoint)point
{
    
    
    if(!drawActionPoints.noNeedFixPosition)
    {
        drawActionPoints.noNeedFixPosition = YES;
        
        //设置滑动距离
//        disTanceController.relationStart =  point.x - DrawSelectionViewFingerControlLength/2;
//        disTanceController.relationEnd   =  point.x + DrawSelectionViewFingerControlLength/2;
        
  
        
        CGPoint centerPoint = [self getPointForIndex:currentSelection];
        
        float   real_length = disTanceController.realLocation_end  - disTanceController.realLocation_start;
        float   realPercent = (centerPoint.x + - disTanceController.realLocation_start)/real_length;
        
        float   relateLength = DrawSelectionViewFingerControlLength;
        float   relateLength_seg1 = relateLength*realPercent;
        float   relateLength_seg2 = relateLength*(1-realPercent);
        
        disTanceController.relationStart = point.x - relateLength_seg1;
        disTanceController.relationEnd = point.x + relateLength_seg2;
    }

}

/** 滑动*/
-(void)swipeToPoint:(CGPoint)point
{
    
    CGPoint toPoint;
    NSInteger selection ;
    
    if( currentSelection >= 0 )
    {
        
        //设置移动边
        [disTanceController moveMinLeft:point.x];
        [disTanceController moveMaxRight:point.x];
        point.x = [disTanceController getRealLocationForRange:point.x];
        
        
        if([self checkMoveWithPoint:point toPoint:&toPoint selection:&selection])
        {//需要去移动点
            
            [shadeView moveViewToPoint:toPoint animate:YES];
            currentSelection = selection;
            [self setSelectedButtonWithIndex:currentSelection];
            //修改对应realation
            
        }
        else
        {
            [shadeView drageToPoint:point];
        }
    }
    
}

/** 显示下拉动画
 @param percent 0-1
 */
-(void)showDragAnimation:(CGFloat)percent
{
    /** 按钮透明度*/
    CGFloat buttonAlpha = percent*(percent*1.5 - 0.5 );
    if(buttonAlpha < 0)
    {
        buttonAlpha = 0;
    }
    if(buttonAlpha > 1)
    {
        buttonAlpha = 1;
    }
    for ( SelectionShadeButton * button in  array_buttons )
    {
        button.alpha = buttonAlpha;
        
        button.centerX = self.centerButton.centerX + (button.initFrame.origin.x + button.initFrame.size.width/2 - self.centerButton.centerX) * (percent/4 + 0.75);
    }
    
    //旋转，展开button
    self.centerButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI*2*percent);
    self.centerButton.alpha = percent;
    
}

/** */
-(void)backToNormal
{
    [self reportSelectionAtIndex:currentSelection];
    
    [UIView animateWithDuration:0 animations:^{
        self.top = initHeight;
        
    }];
    
    
    
    UIEdgeInsets edge = self.associatedScrollView.contentInset;
    edge.top = 0;
    self.associatedScrollView.contentInset = edge;
    [self.associatedScrollView setContentOffset:CGPointZero animated:YES];
    [self reportFinish];
}

#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
/** 检查是否需要去移动*/
-(BOOL)checkMoveWithPoint:(CGPoint)dragpoint toPoint:(CGPoint*)ToPoint selection:(NSInteger*)selection
{
    BOOL needMove = NO;
    
    if( currentSelection >= 0 && shadeView.isViewShowed )
    {//当前有选项 视图显示出来时
        UIView * view_selected = [array_buttons objectAtIndexSafe:currentSelection];
        
        /** 拖拽距离最近的点*/
        NSInteger nearPoint = -1;
        for( int i = 0 ; i < [array_buttons count] ; i ++ )
        {
            if(i == currentSelection)
            {
                continue;
            }
            SelectionShadeButton  * view_button = [array_buttons objectAtIndexSafe:i];
            SelectionShadeButton  * view_current = [array_buttons objectAtIndexSafe:currentSelection];
            CGPoint centerPoint = [self getPointForIndex:i];
            CGPoint centerPoint_current = [self getPointForIndex:currentSelection];
            
            /** 滑动的距离*/
            CGFloat Dragdistance =  [PointCounter howrizonDistanceBetweenPoints:dragpoint Point2:centerPoint_current];
            /** 视图间的距离*/
            CGFloat distance = [PointCounter howrizonDistanceBetweenPoints:centerPoint Point2:centerPoint_current];
            /** 方向相同*/
            BOOL sameDirection = (dragpoint.x < view_current.frame.origin.x ) == (view_button.frame.origin.x < view_current.frame.origin.x) ;
            
            if(Dragdistance >= distance && sameDirection)
            {//滑动到点
                nearPoint = i;
                if(view_selected != view_button)
                {//需要移动
                    needMove = YES;
                    *ToPoint  = centerPoint;
                    *selection = i;
                }
            }
        }

    }
    return  needMove ;
}

/** 设置选择按钮样式*/
-(void)setSelectedButtonWithIndex:(NSInteger)index
{
    //阴影没有显示的时候 选项为空
    
    if(!shadeView.isViewShowed)
    {
        index = -1;
    }
    for ( int i = 0 ; i < [array_buttons count] ; i ++)
    {
        SelectionShadeButton  * view_button = [array_buttons objectAtIndexSafe:i];
        if(i == index)
        {
            [view_button changeStateTo:YES];
        }
        else
        {
            [view_button changeStateTo:NO];
        }
    }
}

/** 获取按钮的中心点*/
-(CGPoint)getPointForIndex:(NSInteger)index
{
    SelectionShadeButton  * view_button = [array_buttons objectAtIndexSafe:index];
    
    CGRect rect_button = view_button.initFrame;
    
    
    CGPoint centerPoint =  CGPointMake(rect_button.origin.x + rect_button.size.width/2, rect_button.origin.y + rect_button.size.height/2);
    
    return centerPoint;
}
#pragma mark- ********************跳转其他页面********************


@end
