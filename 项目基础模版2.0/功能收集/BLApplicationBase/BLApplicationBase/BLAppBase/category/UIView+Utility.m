//
//  UIView+Utility.m
//  CloudManager
//
//  Created by xiulian.yin on 15/4/11.
//  Copyright (c) 2015年 pengpeng.com. All rights reserved.
//

#import "UIView+Utility.h"


@implementation UIView (Utility)

// 设置UIView的X
- (void)setViewX:(CGFloat)newX
{
    
    CGRect viewFrame = [self frame];
    viewFrame.origin.x = newX;
    [self setFrame:viewFrame];
}

// 设置UIView的Y
- (void)setViewY:(CGFloat)newY
{
    CGRect viewFrame = [self frame];
    viewFrame.origin.y = newY;
    [self setFrame:viewFrame];
}

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)newOrigin
{
    CGRect viewFrame = [self frame];
    viewFrame.origin = newOrigin;
    [self setFrame:viewFrame];
}

// 设置UIView的width
- (void)setViewWidth:(CGFloat)newWidth
{
    CGRect viewFrame = [self frame];
    viewFrame.size.width = newWidth;
    [self setFrame:viewFrame];
}

// 设置UIView的height
- (void)setViewHeight:(CGFloat)newHeight
{
    CGRect viewFrame = [self frame];
    viewFrame.size.height = newHeight;
    [self setFrame:viewFrame];
}

// 设置UIView的Size
- (void)setViewSize:(CGSize)newSize
{
    CGRect viewFrame = [self frame];
    viewFrame.size = newSize;
    [self setFrame:viewFrame];
}

- (CGFloat)left {
    return self.frame.origin.x;
}

//将图片移动到左边
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}


//设置view的top的位置
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)right {
    return self.left + self.width;
}


- (void)setRight:(CGFloat)right {
    if(right == self.right){
        return;
    }
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.top + self.height;
}


//设置view底部的位置
- (void)setBottom:(CGFloat)bottom {
    if(bottom == self.bottom){
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}


- (void)setHeight:(CGFloat)height {
    if(height == self.height){
        return;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

// 设置视图的圆角读书
- (void)setCornerRadius:(float)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

// 设置距离父视图的右边距
- (void)setRightToSuperView:(float)rightDis
{
    
    self.right = self.superview.width - rightDis;
}




@end
