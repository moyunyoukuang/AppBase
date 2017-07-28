//
//  SelectionShadeButton.m
//  DrawSelection
//
//  Created by camore on 17/2/8.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "SelectionShadeButton.h"




#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface SelectionShadeButton  ()
{
    /***************数据控制***************/
    
    /***************视图***************/
    UIImageView * imageView_image;
}
@end

@implementation SelectionShadeButton

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

/** 创建视图
 @param onimage 选中时的图像
 @param offimage 非选中时的图像
 */
-(instancetype)initWithFrame:(CGRect)frame onImage:(UIImage*)onimage offImage:(UIImage*)offimage
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.onimage = onimage;
        self.offimage = offimage;
        
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
//外界调用 或者调用外界的事件


/** 改变视图的状态*/
-(void)changeStateTo:(BOOL)selected
{
    self.isSelected = selected;
    if(selected)
    {
        imageView_image.image = self.onimage;
    }
    else
    {
        imageView_image.image = self.offimage;
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
    imageView_image = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView_image.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView_image];
    imageView_image.image = self.offimage;
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************

@end
