//
//  BLDrawImageView.m
//  DaJiShi
//
//  Created by camore on 16/4/15.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLDrawImageView.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};


@interface BLDrawImageView()
{
    /** 绘画其他效果列表*/
    NSMutableArray      *       drawUtils_array;

}
@end

@implementation BLDrawImageView


#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************调用事件********************
-(void)addDrawInfoModel:(BLDrawImageModel*)model
{
    if(!drawUtils_array)
    {
        drawUtils_array = [NSMutableArray array];
    }
    [drawUtils_array addObjectSafe:model];
}

/** 绘画其他效果*/
-(void)drawOtherUtil
{
    for(int i = 0 ; i < [drawUtils_array count] ; i ++)
    {
        BLDrawImageModel * model = [drawUtils_array objectAtIndexSafe:i];
        if([model isKindOfClass:[BLDrawImageModel class]])
        {
            [self drawWithModel:model];
        }
    }
}

- (void)drawWithModel:(BLDrawImageModel*)model
{
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    
    [model.drawImageColor setFill];
    [model.bodarColor setStroke];
    
    if(model.bodarwidth >0)
    {
        CGContextSetLineWidth(context, model.bodarwidth);
    }
    
    if(model.line_type == 2)
    {
        CGFloat lengths[2] = {10,5};
        CGContextSetLineDash(context, 0, lengths, 2);//画虚线
    }
    
    if(model.drawImageColor)
    {
        [[model getPathToDraw] fill];
    }
    
    if(model.bodarColor)
    {
        [[model getPathToDraw] stroke];
    }
   
    
    //还原现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextRestoreGState(context);
}



#pragma mark- ********************代理方法********************


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawOtherUtil];
}

#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图



#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面

///** 绘画三角*/
//-(void)drawSanJiaoWithModel:(BLDrawImageModel*)model Context:(CGContextRef)context
//{
//    ///绘画三角
//    /** 绘画位置*/
//    CGRect rect = model.drawRect;
//    ///顺时针方向
//    /** 起始位置*/
//    CGPoint startA  ;
//    /** 结束位置*/
//    CGPoint endA  ;
//    /** 控制点*/
//    CGPoint contorl1  ;
//    
//    [model.drawImageColor setFill];
//    [model.bodarColor setStroke];
//    
//    if(model.bodarwidth >0)
//    {
//        CGContextSetLineWidth(context, model.bodarwidth);
//    }
//    
//    
//    switch (model.drawPosition) {
//        case 1:
//        {//top
//            startA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y);
//        }
//            break;
//        case 2:
//        {//left
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            contorl1 = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2);
//        }
//            break;
//        case 3:
//        {//right
//            startA = CGPointMake(rect.origin.x, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2);
//        }
//            break;
//        case 4:
//        {//bottom
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y);
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    
//    UIBezierPath * aPath =  [UIBezierPath bezierPath];
//    
//    ///绘画线条
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    // Set the starting point of the shape.
//    [aPath moveToPoint:startA];
//    
//    [aPath addLineToPoint:endA];
//    [aPath addLineToPoint:contorl1];
//    
//    [aPath closePath];
//    
//    if(model.drawImageColor)
//    {
//        [aPath fill];
//    }
//    
//    if(model.bodarColor)
//    {
//        [aPath stroke];
//    }
//}
//
///** 绘画圆顶三角*/
//-(void)drawYuanDingSanJiaoWithModel:(BLDrawImageModel*)model Context:(CGContextRef)context
//{
//    ///绘画圆顶三角 上3分之一位抛物线，下部分为直线 如角出角为45 －45
//    /** 绘画位置*/
//    CGRect rect = model.drawRect;
//    ///顺时针方向
//    /** 起始位置*/
//    CGPoint startA  ;
//    /** 圆弧起始点*/
//    CGPoint curveStartB;
//    /** 圆弧结束点*/
//    CGPoint curveEndB;
//    /** 结束位置*/
//    CGPoint endA  ;
//    /** 控制点*/
//    CGPoint contorl1  ;
//    
//    [model.drawImageColor setFill];
//    [model.bodarColor setStroke];
//    
//    if(model.bodarwidth >0)
//    {
//        CGContextSetLineWidth(context, model.bodarwidth);
//    }
//    
//    switch (model.drawPosition) {
//        case 1:
//        {//top
//            startA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height*1/3);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,rect.origin.y+  rect.size.height*1/3);
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y);
//        }
//            break;
//        case 2:
//        {//left
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2/3*2);
//            
//            contorl1 = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2);
//        }
//            break;
//        case 3:
//        {//right
//            startA = CGPointMake(rect.origin.x, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height/2/3*2);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,  rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
//            
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2);
//        }
//            break;
//        case 4:
//        {//bottom
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height*2/3);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3,rect.origin.y+  rect.size.height*2/3);
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    
//    UIBezierPath * aPath =  [UIBezierPath bezierPath];
//    
//    ///绘画线条
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    // Set the starting point of the shape.
//    [aPath moveToPoint:startA];
//    
//    [aPath addLineToPoint:curveStartB];
//    
//    [aPath addQuadCurveToPoint:curveEndB controlPoint:contorl1];
//
//    [aPath addLineToPoint:endA];
//    
//    [aPath closePath];
//    
//    if(model.drawImageColor)
//    {
//        [aPath fill];
//    }
//    
//    
//    if(model.bodarColor)
//    {
//        [aPath stroke];
//    }
//    
//    
//}
//
///** 绘画组合绘画 */
//-(void)drawZuHeWihtModel:(BLDrawImageModel*)model Context:(CGContextRef)context
//{
////    1 矩形加圆顶三角 2 点阵加圆顶三角 3点阵虚线
//    switch (model.drawType_zuHe) {
//        case 1:
//            [self drawZuHeRectSanJiaoWihtModel:model Context:context];
//            break;
//        case 2:
//            [self drawZuHeDianZhenSanJiaoWihtModel:model Context:context];
//            break;
//        case 3:
//            [self drawZuHeDianZhenXuXianWihtModel:model Context:context];
//            break;
//        default:
//            break;
//    }
//    
//  
//
//}
//
///** 绘画Rect 三角*/
//-(void)drawZuHeRectSanJiaoWihtModel:(BLDrawImageModel*)model Context:(CGContextRef)context
//{
//    
//    /** 矩形大小*/
//    CGRect rect_rect = CGRectFromString([model.array_zhHe_rect objectAtIndexSafe:0]);
//    
//    /** 三角大小*/
//    CGRect rect_sanJiao = CGRectFromString([model.array_zhHe_rect objectAtIndexSafe:1]);
//    
//    
//    ///绘画圆顶三角 上3分之一位抛物线，下部分为直线 如角出角为45 －45
//    /** 绘画位置*/
//    CGRect rect = rect_sanJiao;
//    ///顺时针方向
//    /** 起始位置*/
//    CGPoint startA  ;
//    /** 圆弧起始点*/
//    CGPoint curveStartB;
//    /** 圆弧结束点*/
//    CGPoint curveEndB;
//    /** 结束位置*/
//    CGPoint endA;
//    /** 控制点*/
//    CGPoint contorl1  ;
//    
//    [model.drawImageColor setFill];
//    [model.bodarColor setStroke];
//    
//    if(model.bodarwidth >0)
//    {
//        CGContextSetLineWidth(context, model.bodarwidth);
//    }
//    
//    
//    /** 围绕三角的矩形点*/
//    CGPoint point_rect1 ;
//    CGPoint point_rect2 ;
//    CGPoint point_rect3 ;
//    CGPoint point_rect4 ;
//    
//    switch (model.drawPosition) {
//        case 1:
//        {//top
//            startA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height*1/3);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,rect.origin.y+  rect.size.height*1/3);
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y);
//            
//            point_rect1 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y);
//            point_rect2 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y+rect_rect.size.height);
//            point_rect3 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y+rect_rect.size.height);
//            point_rect4 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y);
//            
//        }
//            break;
//        case 2:
//        {//left
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2/3*2);
//            
//            contorl1 = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2);
//            
//            point_rect1 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y);
//            point_rect2 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y);
//            point_rect3 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y+rect_rect.size.height);
//            point_rect4 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y+rect_rect.size.height);
//            
//            
//        }
//            break;
//        case 3:
//        {//right
//            startA = CGPointMake(rect.origin.x, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height/2/3*2);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,  rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
//            
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2);
//            
//            
//            point_rect1 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y+rect_rect.size.height);
//            point_rect2 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y+rect_rect.size.height);
//            point_rect3 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y);
//            point_rect4 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y);
//            
//            
//        }
//            break;
//        case 4:
//        {//bottom
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height*2/3);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3,rect.origin.y+  rect.size.height*2/3);
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
//            
//            point_rect1 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y+rect_rect.size.height);
//            point_rect2 = CGPointMake(rect_rect.origin.x, rect_rect.origin.y);
//            point_rect3 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y);
//            point_rect4 = CGPointMake(rect_rect.origin.x+rect_rect.size.width, rect_rect.origin.y+rect_rect.size.height);
//            
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    
//    UIBezierPath * aPath =  [UIBezierPath bezierPath];
//    
//    ///绘画线条
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    [aPath moveToPoint:startA];
//    
//    [aPath addLineToPoint:curveStartB];
//    
//    [aPath addQuadCurveToPoint:curveEndB controlPoint:contorl1];
//    
//    [aPath addLineToPoint:endA];
//    
//    
//    [aPath addLineToPoint:point_rect1];
//    [aPath addLineToPoint:point_rect2];
//    [aPath addLineToPoint:point_rect3];
//    [aPath addLineToPoint:point_rect4];
//    
//    
//    
//    [aPath closePath];
//    
//    if(model.drawImageColor)
//    {
//        [aPath fill];
//    }
//    
//    
//    if(model.bodarColor)
//    {
//        [aPath stroke];
//    }
//}
//
///** 绘画点阵三角*/
//-(void)drawZuHeDianZhenSanJiaoWihtModel:(BLDrawImageModel*)model Context:(CGContextRef)context
//{
//    
// 
//    
//    
//    
//    
//    /** 三角大小*/
//    CGRect rect_sanJiao = CGRectFromString([model.array_zhHe_rect lastObject]);
//    
//    
//    ///绘画圆顶三角 上3分之一位抛物线，下部分为直线 如角出角为45 －45
//    /** 绘画位置*/
//    CGRect rect = rect_sanJiao;
//    ///顺时针方向
//    /** 起始位置*/
//    CGPoint startA  ;
//    /** 圆弧起始点*/
//    CGPoint curveStartB;
//    /** 圆弧结束点*/
//    CGPoint curveEndB;
//    /** 结束位置*/
//    CGPoint endA;
//    /** 控制点*/
//    CGPoint contorl1  ;
//    
//    [model.drawImageColor setFill];
//    [model.bodarColor setStroke];
//    
//    if(model.bodarwidth >0)
//    {
//        CGContextSetLineWidth(context, model.bodarwidth);
//    }
//    
//
//    
//    switch (model.drawPosition) {
//        case 1:
//        {//top
//            startA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height*1/3);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,rect.origin.y+  rect.size.height*1/3);
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y);
//            
//    
//            
//        }
//            break;
//        case 2:
//        {//left
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
//            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2/3*2);
//            
//            contorl1 = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2);
//            
//      
//            
//            
//        }
//            break;
//        case 3:
//        {//right
//            startA = CGPointMake(rect.origin.x, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height/2/3*2);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,  rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
//            
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2);
//            
//            
//      
//            
//            
//        }
//            break;
//        case 4:
//        {//bottom
//            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
//            endA = CGPointMake(rect.origin.x, rect.origin.y);
//            
//            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height*2/3);
//            
//            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3,rect.origin.y+  rect.size.height*2/3);
//            
//            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
//            
// 
//            
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    
//    UIBezierPath * aPath =  [UIBezierPath bezierPath];
//    
//    ///绘画线条
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    [aPath moveToPoint:startA];
//    
//    [aPath addLineToPoint:curveStartB];
//    
//    [aPath addQuadCurveToPoint:curveEndB controlPoint:contorl1];
//    
//    [aPath addLineToPoint:endA];
//    
//    //添加点阵
//    for(int i = 0 ; i < [model.array_zhHe_rect count] ; i ++)
//    {
//        NSString * string_point = [model.array_zhHe_rect objectAtIndexSafe:i];
//        
//        if(i != [model.array_zhHe_rect count]-1)
//        {
//           CGPoint pint = CGPointFromString(string_point);
//            [aPath addLineToPoint:pint];
//        }
//    }
//    
//    [aPath closePath];
//    
//    if(model.drawImageColor)
//    {
//        [aPath fill];
//    }
//    
//    
//    
//    if(model.bodarColor)
//    {
//        [aPath stroke];
//    }
//}
//
///** 绘画点阵虚线*/
//-(void)drawZuHeDianZhenXuXianWihtModel:(BLDrawImageModel*)model Context:(CGContextRef)context
//{
//    
//    [model.bodarColor setStroke];
//    
//    if(model.bodarwidth >0)
//    {
//        CGContextSetLineWidth(context, model.bodarwidth);
//    }
//
//    UIBezierPath * aPath =  [UIBezierPath bezierPath];
//    
//    ///绘画线条
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    //添加点阵
//    /** 起始点*/
//    CGPoint StartPoint = CGPointZero;
//    /** 总长度*/
//    int    totalLength = 0 ;
//    
//    for(int i = 0 ; i < [model.array_zhHe_rect count] ; i ++)
//    {
//        NSString * string_point = [model.array_zhHe_rect objectAtIndexSafe:i];
//        
//        CGPoint pint = CGPointFromString(string_point);
//        
//        if(i == 0 )
//        {
//            [aPath moveToPoint:pint];
//            StartPoint = pint;
//        }
//        else
//        {
//            [aPath addLineToPoint:pint];
//            
//            totalLength += distanceBetweenPoints(StartPoint, pint);
//            
//            StartPoint = pint;
//        }
//        
//        
//    }
//    
//    CGFloat lengths[2] = {10,5};
//    CGContextSetLineDash(context, 0, lengths, 2);//画虚线
//   
//    
//    if(model.bodarColor)
//    {
//        [aPath stroke];
//    }
//}
#pragma mark- ********************跳转其他页面********************
@end
