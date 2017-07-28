//
//  AutoMoveIconView.m
//  BaiTang
//
//  Created by BLapple on 16/3/7.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "AutoMoveIconView.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性


@interface AutoMoveIconView()
{
    
    /***************数据控制***************/
    
    /***************视图***************/
    /** 图标*/
    UIImageView *   iconView;
    /** 文本*/
    UILabel     *   lable_text;
    
}
/** icon 与文字的间距*/
@property (nonatomic ,readwrite)float space;
/** icon在左在右*/
@property (nonatomic ,readwrite)BOOL  iconIsLeft;
/** 限制宽度*/
@property (nonatomic , readwrite)CGFloat    limitWidth;
/** 限制高度*/
@property (nonatomic , readwrite)CGFloat limitHeight;

@end

@implementation AutoMoveIconView
@synthesize allowMutableLine = _allowMutableLine;


//- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
//{
//    CGRect textRect = self.bounds;
//    
//    if(self.limitWidth > 0)
//    {
//        textRect.size.width = self.limitWidth;
//    }
//    if(self.iconIsLeft)
//    {
//        textRect.size.width -= (self.imageview.width + self.space);
//        textRect.origin.x    += (self.imageview.width + self.space);
//    }
//    else
//    {
//        textRect.size.width -= (self.imageview.width + self.space);
//       
//    }
//    
//    
//
//    return textRect;
//}

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
/** 带icon 的label
 @param image  icon
 @param string  文字
 @param font   字体
 @param space   icon 文字间隔
 @param left     icon 在左边
 @param height   高度
 */
+(instancetype)AutoMoveIconViewWithIcon:(BLImageView*)imageview string:(NSString*)string font:(UIFont*)font space:(float)space iconIsLeft:(BOOL)left height:(CGFloat)height
{
    imageview.top = 0;
    AutoMoveIconView * lable = [[AutoMoveIconView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    lable.space         = space;
    lable.iconIsLeft    = left;
    lable.contentMode   = UIViewContentModeRedraw;
    lable.font = font;
    lable.imageview = imageview;
    [lable setViewLimitHeight:height];
    lable.text = string;
  
    
    return lable;
}

+(instancetype)AutoMoveIconViewWithIcon:(BLImageView*)imageview string:(NSString*)string font:(UIFont*)font space:(float)space iconIsLeft:(BOOL)left
{
    imageview.top = 0;
    AutoMoveIconView * lable = [[AutoMoveIconView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    lable.space         = space;
    lable.iconIsLeft    = left;
    lable.contentMode   = UIViewContentModeRedraw;
    lable.font = font;
    lable.imageview = imageview;
    lable.text = string;

    return lable;
}


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
    self.backgroundColor = [UIColor clearColor];
    self.firstLineCompareWithImage = YES;
}

-(void)setUpViews
{

    [self createAllView];

}


#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
-(BOOL)isAllowMutableLine
{
    return _allowMutableLine;
}

-(void)setAllowMutableLine:(BOOL)allowMutableLine
{
    _allowMutableLine = allowMutableLine;
    if(allowMutableLine)
    {
        lable_text.numberOfLines = 0;
    }
    else
    {
        lable_text.numberOfLines = 1;
    }
    [self adjustView];
}

-(NSString *)text
{
    return lable_text.text;
}

-(void)setText:(NSString *)text
{
    lable_text.text = text;
    
    [self adjustView];
}

-(UIFont*)font
{
    return lable_text.font;
}
-(void)setFont:(UIFont*)font
{
    lable_text.font = font;
     [self adjustView];
}

-(UIColor*)textColor
{
    return  lable_text.textColor;
}
-(void)setTextColor:(UIColor*)textColor
{
    lable_text.textColor = textColor;
}


-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    lable_text.textAlignment = textAlignment;
}

/** limitWidth 限制宽度，（包括图片）*/
-(void)setLimitViewWidth:(CGFloat)width
{
    self.limitWidth = width;
    
    [self adjustView];
}

-(UIImageView *)imageview
{
    return iconView;
}
-(void)setImageview:(UIImageView *)imageview
{
    [iconView removeFromSuperview];
    iconView = imageview;
    [self addSubview:iconView];
    [self adjustView];
}

-(void)setViewLimitHeight:(CGFloat)limitHeight
{
    self.limitHeight = limitHeight;
    [self adjustView];
}

-(BOOL)allowMutableLine
{
    return _allowMutableLine;
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
    /** 图标*/
    iconView = [MyControl createImageViewWithFrame:CGRectMake(0, 0, 0, 0) image:nil]  ;
    [self addSubview:iconView];
    /** 文本*/
    lable_text = [MyControl createLabelWithFrame:CGRectMake(0, 0, 0, 0) font:[UIFont systemFontOfSize:text_size_content] title:@""];
    [self addSubview:lable_text];
    
    
    self.lable_content = lable_text;
    self.imageview = iconView;
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
/** 调整当前的视图，适配配置*/
-(void)adjustView
{
    self.imageview.top = 0;
    
    NSString * text = self.text;
    
    
    /** 单行的高度*/
    int singleLineHeight = 0;
    CGRect singleRect = [MyControl stringRectfor:@"占位" font:self.font];
    singleLineHeight = singleRect.size.height;
    
    
    /** 文本大小*/
    CGRect stringRect = [MyControl stringRectfor:text font:self.font];

    if(self.limitWidth > 0 && stringRect.size.width + self.imageview.width + self.space > self.limitWidth)
    {//长度越界
        
        stringRect.size.width = self.limitWidth - (self.imageview.width + self.space );
        
    }
    
    
    if(self.limitWidth > 0 && self.allowMutableLine)
    {//限制长度可以多行
        
        stringRect = [MyControl stringRectfor:text font:self.font width:self.limitWidth- (self.imageview.width + self.space )];
        
    }
    
    ///设定宽度
    self.width = self.imageview.width+self.space +stringRect.size.width;
    
    lable_text.width  = stringRect.size.width;
    lable_text.height = stringRect.size.height;
    
    
    
    
    
    lable_text.top  = 0;
    
    
    if(self.limitHeight > 0)
    {
        self.height = self.limitHeight;
        self.imageview.centerY = self.height/2;
        if(self.firstLineCompareWithImage)
        {
            lable_text.top  = self.imageview.centerY-singleLineHeight/2;
        }
    }
    else
    {
        ///设定高度
        self.height = self.imageview.bottom;
        
        if(self.firstLineCompareWithImage)
        {
            lable_text.top  = self.imageview.centerY-singleLineHeight/2;
        }
        
        if(self.height < lable_text.bottom)
        {
            self.height = lable_text.bottom;
        }
    }
    
    
    
    
    
    
    ///设定内容视图关系
    if(self.iconIsLeft)
    {
        self.imageview.left = 0;
        self.textAlignment = NSTextAlignmentLeft;
        lable_text.left = self.imageview.right + self.space;
    }
    else
    {
        self.imageview.right = self.width;
        self.textAlignment = NSTextAlignmentRight;
        lable_text.left = 0;
    }
 
}
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************


@end
