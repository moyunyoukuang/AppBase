//
//  BLDrawView.m
//  BaiTang
//
//  Created by camore on 16/4/1.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLDrawView.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface BLDrawView ()
{
    /** 点击手势*/
    UITapGestureRecognizer * tapGesture;
    /** 绘画frame */
    CTFrameRef Myctframe;
    /** 当前绘画的frame 如果和当前视图的大小不同，说明视图大小有变化，需要重新生成视图*/
    CGRect     currentRect;
    /** 会话适合的大小*/
    CGSize      fitSize;
    /** 添加过的视图*/
    NSMutableArray  * addedViews_array;
}
/** 内容 事件*/
@property (nonatomic , strong ) BLDrawContext* context;
@end

@implementation BLDrawView
@synthesize context = _context;


#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(void)dealloc
{
    if(Myctframe != NULL)
    {
        CFRelease(Myctframe);
        Myctframe = NULL;
    }
}
/** 设置内容*/
-(void)setDrawContext:(BLDrawContext*)context
{

    self.context = context;
    [self createCTFrameRef];
    [self judgeAddGesure];
    
    [self setNeedsDisplay];
    
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self chuShiHua];
        [self setUpViews];
    }
    return self;

}

-(void)chuShiHua
{
    self.array_gestures = [NSMutableArray array];
}

-(void)setUpViews
{
    
    
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************调用事件********************
/** 判断添加手势*/
-(void)judgeAddGesure
{
    if(self.context.enAbleTouch)
    {
        [self addTapGesture];
    }
    else
    {
        if(tapGesture)
        {
            [self removeGestureRecognizer:tapGesture];
            [self.array_gestures removeObject:tapGesture];
            tapGesture = nil;
        }
    }
}
/** 判断添加视图 */
-(void)judgeAddView
{

    
    for(UIView * view in addedViews_array)
    {
        if([view isKindOfClass:[UIView class]])
        {
            [view removeFromSuperview];
        }
    }
    if(self.context.enAbleAddView)
    {
        addedViews_array = [NSMutableArray array];
        CFArrayRef lines = CTFrameGetLines(Myctframe);
        CGPoint lineOrigins[CFArrayGetCount(lines)];
        CTFrameGetLineOrigins(Myctframe, CFRangeMake(0, 0), lineOrigins);
        
        
        for (int i = 0; i < CFArrayGetCount(lines); i++)
        {//获取每一行的坐标
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            
            
            CGFloat lineAscent;
            CGFloat lineDescent;
            CGFloat lineLeading;
            CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
            CGPoint lineOrigin = lineOrigins[i];
            
            
            CFArrayRef runs = CTLineGetGlyphRuns(line);
            for (int j = 0; j < CFArrayGetCount(runs); j++)
            {//获取每一run的坐标
                CTRunRef run = CFArrayGetValueAtIndex(runs, j);
                CGFloat runAscent;
                CGFloat runDescent;
                
                CGRect runRect;
                //调整CTRun的rect
                runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
                runRect = CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);

                NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
                UIView * drawView = [attributes objectForKey:BLDrawViewKey];
                if([drawView isKindOfClass:[UIView class]])
                {
                    
                    drawView.frame = CGRectMake(runRect.origin.x, self.frame.size.height - runRect.origin.y-drawView.frame.size.height+lineDescent/2, drawView.frame.size.width, drawView.frame.size.height);
                    
//                    drawView.frame = CGRectMake(runRect.origin.x + lineOrigin.x, self.frame.size.height - runRect.origin.y-drawView.frame.size.height+lineDescent/2, drawView.frame.size.width, drawView.frame.size.height);
               
//                    drawView.centerY = self.height - runRect.origin.y-drawView.height+lineDescent/2;
                    
                    [self addSubview:drawView];
                    [addedViews_array addObject:drawView];
                }
                
            }
        
        }

    }
}

/** 当前适合的大小 设置context 之后获取*/
-(CGSize)fitSize
{
    [self checkDrawFrameChange];
    return fitSize;
}

#pragma mark- ********************代理方法********************
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
#pragma mark- ********************跳转其他页面********************

#pragma mark- Tap gessure
/** 判断是否需要添加手势*/
-(void)addTapGesture
{
    if(self.context.enAbleTouch)
    {
        if(!tapGesture)
        {
            tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
            [self addGestureRecognizer:tapGesture];
            [self.array_gestures addObject:tapGesture];
        }
    }
    
}
-(void)tapView:(UITapGestureRecognizer*)tap
{
    if(tap.state == UIGestureRecognizerStateRecognized && tap.numberOfTouches == 1)
    {
        CGPoint tappoint=[tap locationInView:self];
        [self judegeTappoint:tappoint];
    }
}
-(void)judegeTappoint:(CGPoint)point
{
    //每一行
    CFArrayRef lines = CTFrameGetLines(Myctframe);
    //获取每行的原点坐标
    CGPoint origins[CFArrayGetCount(lines)];
    
    CTFrameGetLineOrigins(Myctframe, CFRangeMake(0, 0), origins);
    CTLineRef line = NULL;
    CGPoint lineOrigin = CGPointZero;
    
    for (int i= 0; i < CFArrayGetCount(lines); i++)
    {
        //判断点击在哪一行
        CGPoint origin = origins[i];
        CGPathRef path = CTFrameGetPath(Myctframe);
        
        //获取整个CTFrame的大小
        CGRect rect = CGPathGetBoundingBox(path);
    
        //坐标转换，把每行的原点坐标转换为uiview的坐标体系
        CGFloat y = rect.origin.y + rect.size.height - origin.y;
      
        //判断点击的位置处于那一行范围内
        if ((point.y <= y+5) && (point.x >= origin.x-5))//扩大5的点击范围
        {
            line = CFArrayGetValueAtIndex(lines, i);
            lineOrigin = origin;
            
            
            point.x -= lineOrigin.x;
            CGPoint checkpoint ;
            checkpoint.x =( point.x - lineOrigin.x);
            checkpoint.y = point.y;
            if(line != NULL)
            {
                //获取点击位置所处的字符位置，就是相当于点击了第几个字符
                CFIndex index = CTLineGetStringIndexForPosition(line, checkpoint);
                
                //判断点击的字符是否在需要处理点击事件的字符串范围内，这里是hard code了需要触发事件的字符串范围
                if([self judgeTapindex:(int)index])
                {//如果找到点击事件，就不再找了
                    return;
                }
            }
        }
    }
    
    
}

-(BOOL)judgeTapindex:(int)index
{
    for(tapinfo * info in self.context.AddActions)
    {
        for(NSString * rangestring in info.touchRange)
        {
            NSRange onerange = NSRangeFromString(rangestring);
            
            if(index >= onerange.location && index<= (onerange.location+onerange.length))
            {
                [self.context BLtouchText:self TapActionactionname:info.tapAction];
                return YES;
            }
            
        }
    }
    return NO;
}

#pragma mark- 创建CTFrameRef
/** 判断检查当前视图绘画大小有没有变化*/
-(void)checkDrawFrameChange
{
    if(currentRect.size.width != self.frame.size.width || currentRect.size.height != self.frame.size.height)
    {
        [self createCTFrameRef];
    }
}

-(void)createCTFrameRef
{
    currentRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CTFramesetterRef framesetter = [self.context getFramesetterRef];
    
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 ,currentRect.size.width , currentRect.size.height));
    
    
    if(Myctframe != NULL)
    {
        CFRelease(Myctframe);
        Myctframe = NULL;
    }
    
    
    //绘画文本范围

    CFRange range_text = CFRangeMake(self.drawTextRange.location, self.drawTextRange.length);
   
    Myctframe = CTFramesetterCreateFrame(framesetter, range_text, Path, NULL);
    
    //获取适合的高度 略微增加扩展
    CGSize drewRect =  CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(self.frame.size.width, CGFLOAT_MAX), NULL);
    
    if(Path != NULL)
    {
        CGPathRelease(Path);
    }
   
    //添加视图
    [self judgeAddView];
    //反馈大小
    fitSize = drewRect;


}


#pragma mark-  draw




-(void)drawRect:(CGRect)rect
{
   
    [super drawRect:rect];

    
    [self checkDrawFrameChange];
    
    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
    CGContextRef context = UIGraphicsGetCurrentContext();
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(Myctframe,context);
    
    CGContextRestoreGState(context);

}



@end
