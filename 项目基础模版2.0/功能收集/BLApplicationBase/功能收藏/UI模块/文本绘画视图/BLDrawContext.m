//
//  BLDrawContext.m
//  BaiTang
//
//  Created by camore on 16/4/1.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLDrawContext.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
/** 会话内容*/
@interface BLDrawContext()
{
   
    CTFramesetterRef framesetter ;
   
}
@end

@implementation BLDrawContext

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(void)dealloc
{
    if(framesetter != NULL)
    {
        CFRelease(framesetter);
        framesetter = NULL;
    }
}


-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
//        self.rePlaceViewTextWithBlank = YES;
    }
    return self;

}

#pragma mark- ********************点击事件********************
#pragma mark- ********************调用事件********************

#pragma mark- 设置信息

/** 添加点击事件*/
-(void)addTouchActionForText:(NSString*)text  ActionName:(NSString*)Actionname
{
    tapinfo * onetapinfo        =   [[tapinfo alloc] init];
    onetapinfo.taptext          =   text;
    onetapinfo.tapAction        =   Actionname;
    onetapinfo.isAllContent     =   YES;
    
    [self addTapAction:onetapinfo];
}
/** 添加点击事件*/
-(void)addTouchActionForIndex:(NSRange)range  ActionName:(NSString*)Actionname
{
    tapinfo * onetapinfo        =   [[tapinfo alloc] init];
    onetapinfo.tapAction        =   Actionname;
    onetapinfo.isAllContent     =   NO;
    onetapinfo.touchRange       =   [NSMutableArray arrayWithObject:NSStringFromRange(range)];
    
    
    [self addTapAction:onetapinfo];
}

/** 添加视图*/
-(void)addViewForText:(NSString*)text  ActionName:(NSString*)Actionname
{
    tapinfo * onetapinfo        =   [[tapinfo alloc] init];
    onetapinfo.taptext          =   text;
    onetapinfo.tapAction        =   Actionname;
    onetapinfo.isAllContent     =   YES;
    
    [self addTapView:onetapinfo];
}
/** 添加视图*/
-(void)addViewForIndex:(NSRange)range  ActionName:(NSString*)Actionname
{
    if(range.length > 1)
    {
        range.length = 1;
    }
    tapinfo * onetapinfo        =   [[tapinfo alloc] init];
    onetapinfo.tapAction        =   Actionname;
    onetapinfo.isAllContent     =   NO;
    onetapinfo.touchRange       =   [NSMutableArray arrayWithObject:NSStringFromRange(range)];
    
    
    [self addTapView:onetapinfo];
}

#pragma mark- 获取信息
////获取信息
/** 获取绘画内容*/
-(NSMutableAttributedString * )getContext
{
    NSMutableAttributedString * context = nil;
    
    if(self.conTextstring)
    {
        context = [[NSMutableAttributedString alloc] initWithString:self.conTextstring];
    }
    if(self.attributestring)
    {
        context = self.attributestring;
    }
    if(!context)
    {
        context = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    [context beginEditing];
    [self caculateLocationRangeForString:context];
    [self addAttributeForString:context];
    [context endEditing];
    
    return context;
    
}
/** 获取CTFramesetterRef*/
-(CTFramesetterRef)getFramesetterRef
{
    if(framesetter == NULL)
    {
        framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)[self getContext]);
    }
    
    return framesetter;
}


/** 点击事件*/
-(void)BLtouchText:(BLDrawView*)touchText TapActionactionname:(NSString*)name
{
    if([self.delegate respondsToSelector:@selector(BLDrawContext:BLDrawView:TapActionactionname:)])
    {
        [self.delegate BLDrawContext:self BLDrawView:touchText TapActionactionname:name];
    }

}
/** 获取视图事件*/
-(UIView*)BLtouchText:(BLDrawView*)touchText ViewActionactionname:(NSString*)name
{
    if([self.BLDrawContextDatasource respondsToSelector:@selector(BLDrawContext:BLDrawView:DrawActinName:)])
    {
        return [self.BLDrawContextDatasource BLDrawContext:self BLDrawView:touchText DrawActinName:name];
    }
    return nil;
}

#pragma mark- 绘画视图文本callback

void RunDelegateDeallocCallback( void* refCon ){
    
}
CGFloat RunDelegateGetAscentCallback( void *refCon ){
    UIView * view = (__bridge UIView *)(refCon);
    
    if([view isKindOfClass:[UIView class]])
    {
        return view.frame.size.height;
    }
    
    NSString * string =  (__bridge NSString *)(refCon);
    if([string isKindOfClass:[NSString class]])
    {
        
    }
    return 0;
}
CGFloat RunDelegateGetDescentCallback(void *refCon){
    return 0;
}
CGFloat RunDelegateGetWidthCallback(void *refCon){
    UIView * view = (__bridge UIView *)(refCon);
    
    if([view isKindOfClass:[UIView class]])
    {
        return view.frame.size.width;
    }
    NSString * string =  (__bridge NSString *)(refCon);
    if([string isKindOfClass:[NSString class]])
    {
        
    }
    
    return 0;
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
/** 添加点击动作*/
-(void)addTapAction:(tapinfo*)action
{
    self.enAbleTouch        = YES;
    action.tapType          =   tapinfoActionClick;
    if(!self.AddActions )
    {
        self.AddActions =[NSMutableArray array];
    }
    
    BOOL alrealdyExist = NO;
    
    for( tapinfo* info in self.AddActions)
    {
        if([info isEqual:action])
        {
            alrealdyExist = YES;
            break;
        }
    }
    
    if(!alrealdyExist && action)
    {
        [self.AddActions addObject:action];
    }
    
}

/** 添加视图动作*/
-(void)addTapView:(tapinfo*)action
{
    self.enAbleAddView      = YES;
    action.tapType          =   tapinfoActionAddPic;
    if(!self.AddViews )
    {
        self.AddViews =[NSMutableArray array];
    }
    
    BOOL alrealdyExist = NO;
    
    for( tapinfo* info in self.AddViews)
    {
        if([info isEqual:action])
        {
            alrealdyExist = YES;
            break;
        }
    }
    
    if(!alrealdyExist && action)
    {
        [self.AddViews addObject:action];
    }
    
}

#pragma mark- 计算标签位置
/** 计算标签位置*/
-(void)caculateLocationRangeForString:(NSMutableAttributedString*)mutiString
{
    //点击range
    [self caculateTapLocationRange:mutiString forActions:self.AddActions];
    //视图reange
    [self caculateTapLocationRange:mutiString forActions:self.AddViews];
}
/** 添加点击标示
 @param actions [tapinfo]
 */
-(void)caculateTapLocationRange:(NSMutableAttributedString*)mutiString forActions:(NSMutableArray*)actions
{
    for( int i = 0 ; i < [actions count] ; i ++ )
    {
        tapinfo * info = [actions objectAtIndex:i];
        
        if([info isKindOfClass:[tapinfo class]])
        {
            if(info.isAllContent)
            {//全文匹配
                /** 匹配文本*/
                NSString * text = info.taptext;
                /** 匹配器*/
                BLMatchEnumerator * enumer = [[BLMatchEnumerator alloc] initWithString:[mutiString string] MatchText:text];
                /** 找到的range*/
                NSRange findrange;
                /** range添加序列*/
                NSMutableArray * textRanges = [[NSMutableArray alloc] init];
                BOOL Havetaprange = NO;
                do {
                    
                    findrange = [enumer Next];
                    if(findrange.location != NSNotFound)
                    {
                        
                        [textRanges addObject:NSStringFromRange(findrange)];
                        Havetaprange =YES;
                    }
                    
                } while (findrange.location != NSNotFound);
                
                if(Havetaprange)
                {
                    info.touchRange = textRanges;
                }
                else
                {
                    //移除没有匹配的
                    [actions removeObjectAtIndex:i];
                    i -- ;
                    continue;
                }
                
            }
            else
            {
                //非全文配齐已经设置区域
                if(!(info.touchRange.count >0))
                {//移除没有匹配的
                    [actions removeObjectAtIndex:i];
                    i -- ;
                    continue;
                }
                
            }
        }
    }
}


#pragma mark- 添加标签
/** 给muti stirng 添加点击和视图便签*/
-(void)addAttributeForString:(NSMutableAttributedString*)mutiString
{
    [self addTapAttribute:mutiString forActions:self.AddActions];
    
    [self addViewAttribute:mutiString forActions:self.AddViews];
}
/** 添加点击标示 
 @param actions [tapinfo]
 */
-(void)addTapAttribute:(NSMutableAttributedString*)mutiString forActions:(NSMutableArray*)actions
{
    for(tapinfo * info in actions)
    {
        if(info.touchRange != nil)
        {

         
            for(int i =0 ; i<  info.touchRange.count ;i++)
            {
                NSString * rangestring = [info.touchRange objectAtIndex:i];
                
                NSRange range = NSRangeFromString(rangestring);
                
                [self addTapYangshiforStirng:mutiString Range:range];
                
            }
        }
    }
}
/** 添加点击样式*/
-(void)addTapYangshiforStirng:(NSMutableAttributedString*)mutiString Range:(NSRange)range
{
    if( NSMaxRange(range) <= mutiString.length)
    {
        [mutiString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        [mutiString addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:range];
        [mutiString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]  range:range];
    }
}

/** 添加视图标示*/
-(void)addViewAttribute:(NSMutableAttributedString*)mutiString forActions:(NSMutableArray*)actions
{
    [self getAddViewsForActions:actions];
    
//    /** 图片的位置*/
//    NSMutableArray * viewRanges = [NSMutableArray array];
    
    
    for(tapinfo * info in actions)
    {
        if(info.touchRange != nil)
        {
            for(int i =0 ; i< info.touchRange.count ;i++)
            {
                NSString * rangestring = [info.touchRange objectAtIndex:i];
                NSRange range = NSRangeFromString(rangestring);
                UIView * view = [info.addViews objectAtIndex:i];
                CTRunDelegateCallbacks imageCallbacks;
                imageCallbacks.version = kCTRunDelegateVersion1;
                imageCallbacks.dealloc = RunDelegateDeallocCallback;
                imageCallbacks.getAscent = RunDelegateGetAscentCallback;
                imageCallbacks.getDescent = RunDelegateGetDescentCallback;
                imageCallbacks.getWidth = RunDelegateGetWidthCallback;
                
                CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void * _Nullable)(view));

                //添加视图绘画范围
                [mutiString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:range];
                
                 CFRelease(runDelegate);
                //添加视图
                [mutiString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:range];
                
                [mutiString addAttribute:BLDrawViewKey value:view range:range];
                
//                if(self.rePlaceViewTextWithBlank)
//                {
//                    /** 插入成功*/
//                    BOOL insertSuccess = NO;
//                    
//                    //viewRanges从小到大排序
//                    for(NSInteger i =  0; i < [viewRanges count] ; i ++)
//                    {
//                    
//                        NSString * rangeString = [viewRanges objectAtIndex:i];
//                        if(rangeString)
//                        {
//                            NSRange range_before = NSRangeFromString(rangeString) ;
//                            
//                            if(range.location < range_before.location)
//                            {
//                                [viewRanges insertObject:rangestring atIndex:i];
//                                insertSuccess = YES;
//                                break;
//                            }
//                        }
//                        
//                    }
//                    if(!insertSuccess && rangestring)
//                    {
//                        [viewRanges addObject:rangestring];
//                    }
//                }
            }
        }
    }
    
    
    
    
    
    

//    for(NSInteger i =  [viewRanges count]-1; i >=0 ; i --)
//    {///从大到下，替换文本
//        NSString * rangeString = [viewRanges objectAtIndex:i];
//        if(rangeString)
//        {
//            NSRange range = NSRangeFromString(rangeString) ;
//            
//            [mutiString replaceCharactersInRange:range withString:@"图"];
//            
//        }
//    }

}
/** 获取要添加的视图*/
-(void)getAddViewsForActions:(NSMutableArray*)actions
{
    for(tapinfo * info in actions)
    {
        NSMutableArray * mutiArray = [NSMutableArray array];
        
        NSUInteger count = info.touchRange.count;
        for(int i =0 ; i< count ;i++)
        {
            
            if([self.BLDrawContextDatasource respondsToSelector:@selector(BLDrawContext:BLDrawView:DrawActinName:)])
            {
                //获取添加的视图
                UIView * addView = [self.BLDrawContextDatasource BLDrawContext:self BLDrawView:nil DrawActinName:info.tapAction];
                if(addView && [addView isKindOfClass:[UIView class]])
                {
                    [mutiArray addObject:addView];
                    
                }
                else
                {
                    [mutiArray addObject:[NSNull null]]  ;
                }
                
            }
        }
        info.addViews = mutiArray;
    }
    
}



@end


//匹配文字中有相关的文字
@implementation BLMatchEnumerator
{
    NSString   * Dostring;
    NSString   * match;
    NSUInteger   location;
    
}


-(instancetype)initWithString:(NSString *)string  MatchText:(NSString*)matchstring
{
    self = [super init];
    if(self)
    {
        Dostring = string;
        match = matchstring;
    }
    
    return self;
}


-(NSRange)Next
{
    if((location != NSNotFound) && match.length>0)
    {
        NSRange searchRange  = NSMakeRange(location, [Dostring    length] - location);
        NSRange matchedRange = [Dostring rangeOfString:match options:NSCaseInsensitiveSearch range:searchRange];
        
        location = NSMaxRange(matchedRange) ;
        
        if(matchedRange.location != NSNotFound && matchedRange.length !=0 ) {
            return matchedRange;
        }
        else
        {
            location = NSNotFound;
        }
    }
    return NSMakeRange(NSNotFound, 0);
}
@end




@implementation tapinfo

-(BOOL)isEqual:(id)object
{
    tapinfo * other = object;
    if(!other || ![other isKindOfClass:[tapinfo class]])
    {
        return NO;
    }
    if(self == other)
    {
        return YES;
    }
    
 
    
    if(self.isAllContent != other.isAllContent)
    {//种类不相同
        return NO;
    }
    
    if(self.isAllContent)
    {//全文点击
        if([self.taptext isEqualToString:other.taptext] && [self.tapAction isEqualToString:other.tapAction])
        {
            return YES;
        }
    }
    
    if(!self.isAllContent)
    {//单个点击
        if([self.touchRange isEqualToArray:other.touchRange] && [self.tapAction isEqualToString:other.tapAction])
        {
            return YES;
        }
    }
    
    return NO;
}

@end
