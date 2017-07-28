//
//  BLDrawImageModel.h
//  DaJiShi
//
//  Created by camore on 16/4/15.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLModel.h"

typedef  UIBezierPath *  (^DrawPathBlock)(void);


@interface BLDrawImageModel : BLModel
///基础绘画属性设置
/** 绘画图像的颜色 背景色 填充颜色*/
@property ( nonatomic , strong ) UIColor    *   drawImageColor;

/** 绘画图像边框的颜色 线色*/
@property ( nonatomic , strong ) UIColor    *   bodarColor;

/** 绘画图像边框的宽度*/
@property ( nonatomic , readwrite ) CGFloat     bodarwidth;

/** 线的类型 1 实线 2 虚线*/
@property ( nonatomic , readwrite ) NSInteger   line_type;




///绘画 路径
/** 自动关闭路径 默认yes*/
@property ( nonatomic , readwrite ) BOOL auto_colosePath;

/** 获取绘画的路径*/
-(UIBezierPath *)getPathToDraw;



/** 添加三角路径
 @param rect         三角位置
 @param drawPosition 1top 2left 3right 4down
 */
-(void)addPathSanJiaoForRect:(CGRect)rect Direction:(NSInteger)direction;

/** 添加圆顶三角路径
 @param rect         三角位置
 @param drawPosition 1top 2left 3right 4down
 */
-(void)addPathYuanDingSanJiaoForRect:(CGRect)rect Direction:(NSInteger)direction;

/** 添加点阵路径
 @param array_dianZhen [NSString:NSStringFromCGPoint/CGPointFromString]
 */
-(void)addPathDianZhenArray:(NSArray*)array_dianZhen;

/** 添加点路径
 */
-(void)addPathPoint:(CGPoint)point;

/** 添加绘画block*/
-(void)addDrawBlock:(DrawPathBlock)block;


@end
