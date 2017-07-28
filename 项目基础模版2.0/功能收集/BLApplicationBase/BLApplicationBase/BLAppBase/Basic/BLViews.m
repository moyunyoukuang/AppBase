//
//  BLViews.m
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"

@implementation BLView

-(BOOL)canBecomeFirstResponder
{
    if( [self.BLViewFirstResponderDelegate respondsToSelector:@selector(BLViewcanBecomeFirstResponder:)])
    {
        return [self.BLViewFirstResponderDelegate BLViewcanBecomeFirstResponder:self];
    }
    return YES;
}

-(BOOL)becomeFirstResponder
{
   
    if( [self.BLViewFirstResponderDelegate respondsToSelector:@selector(BLViewbecomeFirstResponder:)])
    {
        [self.BLViewFirstResponderDelegate BLViewbecomeFirstResponder:self];
    }
    
    return [super becomeFirstResponder];
    
}

-(BOOL)canResignFirstResponder
{
    if( [self.BLViewFirstResponderDelegate respondsToSelector:@selector(BLViewcanResignFirstResponder:)])
    {
        return [self.BLViewFirstResponderDelegate BLViewcanResignFirstResponder:self];
    }
    return YES;
}


-(BOOL)resignFirstResponder
{
    if( [self.BLViewFirstResponderDelegate respondsToSelector:@selector(BLViewresignFirstResponder:)])
    {
        [self.BLViewFirstResponderDelegate BLViewresignFirstResponder:self];
    }
    return [super resignFirstResponder];
}


@end



@implementation BLLabel

@end


@interface BLTextField()<UITextFieldDelegate>

@end

@implementation BLTextField

-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        self.clipsToBounds = YES;//防止创建视图时意外的动画
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.clipsToBounds = YES;//防止创建视图时意外的动画
    }
    return self;
}

/** 设置清除按钮*/
-(void)setCleaerButton:(UIButton*)button
{
    self.clearButton = button;
    button.centerY = self.centerY;
    
    self.width -= button.width;
    button.left = self.right;
    [self.superview addSubview:button];
    self.clearButtonMode = UITextFieldViewModeNever;
    
}

-(void)clearTextButtonClick:(UIButton*)button
{
    self.text = @"";
}



@end


@implementation BLTextView

@end

@implementation BLButton

@end

@implementation BLImageView

@end

@implementation BLSwitch

@end

@implementation BLPageControl

@end

@implementation BLSearchBar

@end

@implementation BLScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@implementation BLTableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.tableFooterView = [[BLView alloc] init];
        self.separatorColor  = [UIColor clearColor];
        self.separatorStyle  = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        

        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if(self)
    {
        self.tableFooterView = [[BLView alloc] init];
        self.separatorColor  = [UIColor clearColor];
        self.separatorStyle  = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        

    }
    return self;
}



@end

@implementation BLTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        self.width = ScreenWith;
        self.contentView.width = self.width;
        
        
        
    }
    return self;
    
}

/** 反馈事件快捷方法*/
-(void)reportCellAction:(NSInteger)action withModel:(id)model
{
    if([self.BLCelldelegate respondsToSelector:@selector(BLTableViewCell:clickAction:withModel:)])
    {
        [self.BLCelldelegate BLTableViewCell:self clickAction:action withModel:model];
    }
}


@end

@implementation BLCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if(self)
    {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end

@implementation BLCollectionCell


@end


@implementation BLWebView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.dataDetectorTypes = UIDataDetectorTypeAll;
        
        self.backgroundColor = [UIColor clearColor];
        self.scrollView.backgroundColor = [UIColor clearColor];
        
        //消除黑色背景
        for (UIScrollView *view in self.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                [view setShowsHorizontalScrollIndicator:NO];
                view.bounces = NO;
            }
        }
    }
    return self;
}

@end


@implementation BLTabBarVC
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


