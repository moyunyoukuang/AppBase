//
//  UIButton+Extension.h
//  deLaiSu
//
//  Created by sunyuchao on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 大小变化时 自动对齐标志
typedef enum
{
    //无
    BLAutoMoveTagNone               = 0,
    ///自动对齐CenterX
    BLAutoMoveTagCenterX            = 1 << 0,
    ///自动对齐CenterY
    BLAutoMoveTagCenterY            = 1 << 1,
    ///自动对齐Left
    BLAutoMoveTagLeft               = 1 << 2,
    ///自动对齐Right
    BLAutoMoveTagRight              = 1 << 3,
    ///自动对齐TOP
    BLAutoMoveTagTOP                = 1 << 4,
    ///自动对齐Bottom
    BLAutoMoveTagBottom             = 1 << 5,
    
}BLAutoMoveTag;


@interface UIView (Extension)

/** 提示标题 */
@property (nonatomic,strong) NSString *subTitle;

///** 数值*/
@property (nonatomic,strong) NSString *contentValue;

/** 视图序列 (本身的内容视图)*/
@property (nonatomic,strong) NSArray  * array_contentviews;

/** 视图序列 (本身的内容视图)*/
@property (nonatomic,readwrite) BLAutoMoveTag  automoveTag;

/** 根据movtag修改大小*/
-(CGRect)changeWithAutoMoveTagAndFrame:(CGRect)frame;


/** 获取子视图是相关tag的*/
- (__kindof UIView *)subViewWithTag:(NSInteger)tag;

/** 获取同级视图是相关tag的*/
- (__kindof UIView *)sameViewWithTag:(NSInteger)tag;

/** 将所有子视图高度变化*/
- (void)allSubviewAddoffsetY:(CGFloat)offsety;

/** 移除所有子视图*/
- (void)removeAllSubviews;

@end


