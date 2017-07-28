//
//  AddContentScrollView.m
//  DaJiShi
//
//  Created by camore on 16/6/14.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "AddContentScrollView.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface AddContentScrollView()
{
    /***************数据控制***************/
    
    /***************视图***************/
}
@end

@implementation AddContentScrollView




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
    self.array_views = [NSMutableArray array];
}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
/** 添加视图*/
-(void)addContentView:(UIView*)view
{
    [self.array_views addObjectSafe:view];
    
    [self resetViewLocation];
}

///** 添加阴影*/
//-(UIView *)addShadow
//{
//    UIView * shadow = [MyControl addShadowWithView:self];
//    [self addContentView:shadow];
//    return shadow;
//}

/** 添加间隔（空白视图）*/
-(UIView *)addSepForHeight:(NSInteger)height
{
    UIView * view = [MyControl createViewWithFrame:CGRectMake(0, 0, self.width, height)];
    [self addContentView:view];
    return view;
}

/** 插入视图*/
-(void)insertView:(UIView*)view atIndex:(NSInteger)index
{
    [self.array_views insertObject:view atIndex:index];
    
    [self resetViewLocation];
}

/** 插入视图*/
-(void)insertView:(UIView*)view afterView:(UIView*)view_before
{
    NSInteger index = [self indexForView:view_before];
    
    if(index == NSNotFound)
    {
        index = 0;
    }
    
    [self insertView:view atIndex:index];
    
}

/** 移除所有视图*/
-(void)removeAllContent
{
    for (UIView * view in self.array_views)
    {
        [view removeFromSuperview];
    }
    [self.array_views removeAllObjects];
    [self resetViewLocation];
}

/** 获取视图的index*/
-(NSInteger)indexForView:(UIView*)view
{
    return [self.array_views indexOfObject:view];
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

#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
/** 重新设置视图位置*/
-(void)resetViewLocation
{
    CGPoint preoffset = self.contentOffset;
    
    /** 视图的总高度*/
    int  totalHeight = 0;
    
    for( int i = 0 ; i < [self.array_views count] ; i ++)
    {
        UIView * view = [self.array_views  objectAtIndexSafe:i];
        
        view.top = totalHeight;
        
        [self addSubview:view];
        
        totalHeight += view.height;
    }
    
    int contentHeight = ((totalHeight >  self.height )? totalHeight : self.height + 1);
    
    self.contentSize = CGSizeMake(self.width, contentHeight);
    
    self.contentOffset = preoffset;
}
/** 根据内容大小来设置视图大小*/
-(void)resetContentSizeWithSubView
{
    /** 最低位置*/
    NSInteger lowestlocation = 0;

    for (UIView * view in self.subviews)
    {
        if(lowestlocation < view.bottom)
        {
            lowestlocation = view.bottom;
        }
    }
    
    if(lowestlocation< self.height)
    {//保证可以滑动
        lowestlocation = self.height+1;
    }
    
    self.contentSize = CGSizeMake(self.width, lowestlocation);
}

#pragma mark- ********************跳转其他页面********************

@end
