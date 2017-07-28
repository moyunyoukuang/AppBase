//
//  BLDrawImageModel.m
//  DaJiShi
//
//  Created by camore on 16/4/15.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLDrawImageModel.h"


#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface BLDrawImageModel()
{
    /***************数据控制***************/
    /** 路径已经添加过*/
    BOOL                pathStarted;
    
    /** 路径已经关闭过*/
    BOOL                isPathClosed;
    
    /***************视图***************/
}

/** 绘画的路径*/
@property ( nonatomic , strong ) UIBezierPath *   path_toDraw;

/** 线的类型 1 实线 2 虚线*/
@property ( nonatomic , copy ) DrawPathBlock   drawPathBLock;

@end


@implementation BLDrawImageModel
#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(instancetype)init
{
    self = [super init];
    
    if(self )
    {
        [self chuShiHua];
    }
    return self;
}

-(void)chuShiHua
{
    self.path_toDraw = [UIBezierPath bezierPath];
    
    ///绘画线条
//    self.path_toDraw.lineCapStyle = kCGLineCapButt; //线条拐角
//    self.path_toDraw.lineJoinStyle = kCGLineCapSquare; //终点处理
    
    self.auto_colosePath = YES;
}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************

/** 获取绘画的路径*/
-(UIBezierPath *)getPathToDraw
{
    if(self.drawPathBLock)
    {
        self.path_toDraw =  self.drawPathBLock();
        isPathClosed = NO;
    }
    
    
    if(self.auto_colosePath)
    {
        
        if(!isPathClosed)
        {
            isPathClosed = YES;
            [self.path_toDraw closePath];
            
        }
        
        
    }
    
    self.path_toDraw.lineWidth = self.bodarwidth;
    
    return self.path_toDraw;

}

/** 添加三角路径
 @param rect         三角位置
 @param drawPosition 1top 2left 3right 4down
 */
-(void)addPathSanJiaoForRect:(CGRect)rect_toDraw Direction:(NSInteger)drawPosition
{
    
    ///绘画三角
    /** 绘画位置*/
    CGRect rect = rect_toDraw;
    ///顺时针方向
    /** 起始位置*/
    CGPoint startA = CGPointZero ;
    /** 结束位置*/
    CGPoint endA   = CGPointZero;
    /** 控制点*/
    CGPoint contorl1 = CGPointZero ;
    
    switch (drawPosition) {
        case 1:
        {//top
            startA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y);
        }
            break;
        case 2:
        {//left
            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
            contorl1 = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2);
        }
            break;
        case 3:
        {//right
            startA = CGPointMake(rect.origin.x, rect.origin.y);
            endA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
            contorl1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2);
        }
            break;
        case 4:
        {//bottom
            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
            endA = CGPointMake(rect.origin.x, rect.origin.y);
            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
        }
            break;
            
        default:
            break;
    }
    
    
    
    UIBezierPath * aPath =  self.path_toDraw;

    if(pathStarted)
    {
        [aPath addLineToPoint:startA];
    }
    else
    {
        [aPath moveToPoint:startA];
        pathStarted = YES;
    }
    
    
    [aPath addLineToPoint:endA];
    [aPath addLineToPoint:contorl1];
}

/** 添加圆顶三角路径
 @param rect         三角位置
 @param drawPosition 1top 2left 3right 4down
 */
-(void)addPathYuanDingSanJiaoForRect:(CGRect)rect_toDraw Direction:(NSInteger)drawPosition
{
    ///绘画圆顶三角 上3分之一位抛物线，下部分为直线 如角出角为45 －45
    /** 绘画位置*/
    CGRect rect = rect_toDraw;
    ///顺时针方向
    /** 起始位置*/
    CGPoint startA  = CGPointZero;
    /** 圆弧起始点*/
    CGPoint curveStartB = CGPointZero;
    /** 圆弧结束点*/
    CGPoint curveEndB = CGPointZero;
    /** 结束位置*/
    CGPoint endA  = CGPointZero;
    /** 控制点*/
    CGPoint contorl1  = CGPointZero;
    

    
    switch (drawPosition) {
        case 1:
        {//top
            startA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            
            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height*1/3);
            
            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,rect.origin.y+  rect.size.height*1/3);
            
            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y);
        }
            break;
        case 2:
        {//left
            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
            endA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
            
            curveStartB = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
            
            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3, rect.origin.y+ rect.size.height/2/3*2);
            
            contorl1 = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height/2);
        }
            break;
        case 3:
        {//right
            startA = CGPointMake(rect.origin.x, rect.origin.y);
            endA = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
            
            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height/2/3*2);
            
            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width*2/3,  rect.origin.y+ rect.size.height/2+(rect.size.height/2-rect.size.height/2/3*2));
            
            
            contorl1 = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2);
        }
            break;
        case 4:
        {//bottom
            startA = CGPointMake(rect.origin.x+rect.size.width, rect.origin.y);
            endA = CGPointMake(rect.origin.x, rect.origin.y);
            
            curveStartB = CGPointMake(rect.origin.x+ rect.size.width*2/3, rect.origin.y+ rect.size.height*2/3);
            
            curveEndB   = CGPointMake(rect.origin.x+ rect.size.width/3,rect.origin.y+  rect.size.height*2/3);
            
            contorl1 = CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height);
        }
            break;
            
        default:
            break;
    }
    
    
    
    UIBezierPath * aPath =  self.path_toDraw;
    
    if(pathStarted)
    {
        [aPath addLineToPoint:startA];
    }
    else
    {
        [aPath moveToPoint:startA];
        pathStarted = YES;
    }
    
    [aPath addLineToPoint:curveStartB];
    
    [aPath addQuadCurveToPoint:curveEndB controlPoint:contorl1];
    
    [aPath addLineToPoint:endA];

}



/** 添加点阵路径
 @param array_dianZhen [NSString:NSStringFromCGPoint/CGPointFromString]
 */
-(void)addPathDianZhenArray:(NSArray*)array_dianZhen
{
        UIBezierPath * aPath =  self.path_toDraw;
    
        for(int i = 0 ; i < [array_dianZhen count] ; i ++)
        {
            NSString * string_point = [array_dianZhen objectAtIndexSafe:i];
    
            CGPoint pint = CGPointFromString(string_point);
    
            if(i == 0 )
            {
                if(pathStarted)
                {
                    [aPath addLineToPoint:pint];
                }
                else
                {
                    [aPath moveToPoint:pint];
                    pathStarted = YES;
                }
                
            }
            else
            {
                [aPath addLineToPoint:pint];
            }
        }
}

/** 添加点路径
 */
-(void)addPathPoint:(CGPoint)point
{
    UIBezierPath * aPath =  self.path_toDraw;
    
    if(pathStarted)
    {
        [aPath addLineToPoint:point];
    }
    else
    {
        [aPath moveToPoint:point];
        pathStarted = YES;
    }
    
}


/** 添加绘画block*/
-(void)addDrawBlock:(DrawPathBlock)block
{
    self.drawPathBLock = block;
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{

}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************

@end
