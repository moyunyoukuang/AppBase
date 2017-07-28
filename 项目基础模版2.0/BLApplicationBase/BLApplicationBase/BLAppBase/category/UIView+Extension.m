//
//  UIButton+Extension.m
//  deLaiSu
//
//  Created by sunyuchao on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIView+Extension.h"
#import "objc/runtime.h"


@implementation UIView (Extension)
/** 返回subTitle */
-(NSString *)subTitle
{
    return objc_getAssociatedObject(self, @"subTitle");
}

/** 设置subTitle */
-(void)setSubTitle:(NSString *)subTitle
{
    if(!subTitle)
    {
        subTitle = @"";
    }
    objc_setAssociatedObject(self, @"subTitle", subTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/** 返回xiZheTitle */
-(NSString *)contentValue{
    return objc_getAssociatedObject(self, @"contentValue");
}

/** 设置xiZheTitle */
-(void)setContentValue:(NSString *)xiZheTitle{
    if(!xiZheTitle)
    {
        xiZheTitle = @"";
    }
    objc_setAssociatedObject(self, @"contentValue", xiZheTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(NSArray*)array_contentviews
{
    return objc_getAssociatedObject(self, @"array_contentviews");
}

/** 设置xiZheTitle */
-(void)setArray_contentviews:(NSArray*)value{
    if(value)
    {
        objc_setAssociatedObject(self, @"array_contentviews", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}


/** 自变化移动标志*/
-(BLAutoMoveTag)automoveTag
{
    return (BLAutoMoveTag)[objc_getAssociatedObject(self, @"automoveTag") integerValue];
}
/** 自变化移动标志*/
-(void)setAutomoveTag:(BLAutoMoveTag)value
{
    objc_setAssociatedObject(self, @"automoveTag", [NSString stringWithFormat:@"%d",value], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (void)load {
    
    
    
    ///交换方法，使可以调用覆盖前的方法
    Method original, swizzle;
    
    original = class_getInstanceMethod(self, @selector(setFrame:));
    swizzle = class_getInstanceMethod(self, @selector(swizzle_setFrame:));
    if( original && swizzle)
    {
        method_exchangeImplementations(original, swizzle);
    }
}

-(void)swizzle_setFrame:(CGRect)frame
{
    CGRect newFrame =  [self changeWithAutoMoveTagAndFrame:frame];

    [self swizzle_setFrame:newFrame];
}

/** 根据movtag修改大小*/
-(CGRect)changeWithAutoMoveTagAndFrame:(CGRect)frame
{
    BLAutoMoveTag moveTag = [self automoveTag];
    
    ///处理
    if(moveTag & BLAutoMoveTagCenterX)
    {
        CGFloat preValue =  self.centerX ;
        
        CGFloat newValue =  preValue - frame.size.width/2;
        
        frame.origin.x = newValue;
    }
    
    if(moveTag & BLAutoMoveTagCenterY)
    {
        CGFloat preValue =  self.centerY ;
        
        CGFloat newValue =  preValue - frame.size.height/2;
        
        frame.origin.y = newValue;
    }
    
    if(moveTag & BLAutoMoveTagLeft)
    {
        CGFloat preValue =  self.left ;
        
        CGFloat newValue =  preValue ;
        
        frame.origin.x = newValue;
    }
    
    if(moveTag & BLAutoMoveTagRight)
    {
        CGFloat preValue =  self.right ;
        
        CGFloat newValue =  preValue - frame.size.width;
        
        frame.origin.x = newValue;
    }
    
    if(moveTag & BLAutoMoveTagTOP)
    {
        CGFloat preValue =  self.top ;
        
        CGFloat newValue =  preValue ;
        
        frame.origin.y = newValue;
    }
    
    if(moveTag & BLAutoMoveTagBottom)
    {
        CGFloat preValue =  self.bottom ;
        
        CGFloat newValue =  preValue - frame.size.height ;
        
        frame.origin.y = newValue;
    }
    
    return frame;
}

- (nullable __kindof UIView *)subViewWithTag:(NSInteger)tag
{
    for (UIView *temView in [self subviews])
    {
        if(temView.tag == tag)
        {
            return temView;
        }
        
    }
    return nil;
}

/** 获取同级视图是相关tag的*/
- (nullable __kindof UIView *)sameViewWithTag:(NSInteger)tag
{
    for (UIView *temView in [[self superview] subviews])
    {
        if(temView.tag == tag)
        {
            return temView;
        }
        
    }
    return nil;
}

/** 将所有子视图高度变化*/
- (void)allSubviewAddoffsetY:(CGFloat)offsety
{
    if ([[self subviews] count] > 0)
    {
        for (UIView *temView in [self subviews])
        {
            temView.top += offsety;
        }
    }
    
}


- (void)removeAllSubviews
{
    if ([[self subviews] count] > 0)
    {
        for (UIView *temView in [self subviews])
        {
            [temView removeFromSuperview];
        }
    }
}

@end



