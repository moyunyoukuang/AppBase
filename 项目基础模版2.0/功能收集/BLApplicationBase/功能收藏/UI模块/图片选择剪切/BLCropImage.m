//
//  BLCropImage.m
//  BaiTang
//
//  Created by camore on 16/4/3.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLCropImage.h"
#import "KICropImageView.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface BLCropImage()
{
    UIImage * cropImage;
    CGSize    cropSize;
    KICropImageView* kIcrop;
}
@end

@implementation BLCropImage

-(instancetype)initWithFrame:(CGRect)frame CropImage:(UIImage*)OnecropImage ToSize:(CGSize)size
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        cropImage = OnecropImage;
        cropSize  = size;
        
        /** 剪切框大小*/
        CGSize copSize;
        copSize = [MyControl sizeWith:size Scaleinrect:CGRectMake(0, 0, self.width-40, self.height-100) putmiddle:YES].size;
        
        kIcrop= [[KICropImageView alloc] initWithFrame:self.bounds];
        kIcrop.realCropSize = size;
        [kIcrop setCropSize:copSize];
        [kIcrop setImage:OnecropImage];
        
        [self addSubview:kIcrop];
        
        [self chuShiHua];
        [self setUpView];
        
    }
    return self;
}


#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(void)chuShiHua
{
    
    
}

-(void)setUpView
{
    self.backgroundColor = color_second_view_white;
    
    //取消
    BLButton * quXiao_button = [MyControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) target:self method:@selector(quXiaoButtonClick)];
    [quXiao_button setTitle:@"取消" forState:UIControlStateNormal];
    quXiao_button.left = 8;
    quXiao_button.bottom = self.height;
    [quXiao_button setTitleColor:color_text_main_black forState:UIControlStateNormal];
    //确定
    BLButton * queDing_button = [MyControl createButtonWithFrame:CGRectMake(0, 0, 44, 44) target:self method:@selector(queDingButtonClick)];
    [queDing_button setTitle:@"确定" forState:UIControlStateNormal];
    queDing_button.right = self.width - 8;
    queDing_button.bottom = self.height;
    [queDing_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:quXiao_button];
    [self addSubview:queDing_button];
    
}


#pragma mark- ********************点击事件********************
/** 点击取消*/
-(void)quXiaoButtonClick
{
    if([self.delegate respondsToSelector:@selector(BLCropImageCancel:)])
    {
        [self.delegate BLCropImageCancel:self];
    }
    [self dissmissView];
}
/** 点击确定*/
-(void)queDingButtonClick
{
    if([self.delegate respondsToSelector:@selector(BLCropImage:getCutImage:)])
    {
        [self.delegate BLCropImage:self getCutImage:[kIcrop cropImage]];
    }
    [self dissmissView];
}

#pragma mark- ********************调用事件********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
-(void)dissmissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************



@end
