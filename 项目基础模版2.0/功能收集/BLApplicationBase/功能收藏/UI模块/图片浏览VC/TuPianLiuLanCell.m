//
//  TuPianLiuLanCell.m
//  DaJiShi
//
//  Created by camore on 16/7/29.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "TuPianLiuLanCell.h"





#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface TuPianLiuLanCell()
{
    /***************数据控制***************/
    id      currentModel;
    /***************视图***************/
    

}
@end

@implementation TuPianLiuLanCell






#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if(self)
    {
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
-(void)configWithModel:(id)Model
{
    currentModel = Model;
}


-(void)setImageWith:(UIImage*)image OrUrl:(NSString*)url_image
{
    [self.pic_view setimage:image OrUrl:url_image];
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************代理方法********************
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{

    self.pic_view = [[PicLiuLanView alloc] initWithFrame:CGRectMake(0, 0,ScreenWith, ScreenHeight ) image:nil OrUrl:nil];
    

    [self.contentView addSubview:self.pic_view];
    
   
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************


@end
