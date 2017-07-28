//
//  BLViews.h
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//
#import <UIKit/UIKit.h>

//行为block
typedef void (^ActionBlock)(void);

/** 存放各种基础类型*/

@class BLView;
///第一响应  按钮，输入框,手势 第一响应
@protocol BLViewFirstResponderDelegate <NSObject>

-(BOOL)BLViewcanBecomeFirstResponder:(BLView*)view;
-(void)BLViewbecomeFirstResponder:(BLView*)view;
-(BOOL)BLViewcanResignFirstResponder:(BLView*)view;
-(void)BLViewresignFirstResponder:(BLView*)view;

@end

@interface BLView  : UIView

@property ( nonatomic , weak ) id <BLViewFirstResponderDelegate> BLViewFirstResponderDelegate;

@end



@interface BLLabel  : UILabel



@end

@interface BLTextField  : UITextField
@property ( nonatomic , strong ) UIButton * clearButton;

/** 设置清除按钮*/
-(void)setCleaerButton:(UIButton*)button;

/** 清除文字方法*/
-(void)clearTextButtonClick:(UIButton*)button;
@end

@interface BLTextView  : UITextView

@end

@interface BLButton  : UIButton

@end

@interface BLImageView : UIImageView

@end

@interface BLSwitch : UISwitch

@end

@interface BLPageControl : UIPageControl

@end

@interface BLSearchBar : UISearchBar

@end

@interface BLScrollView : UIScrollView

@end

@interface BLTableView : UITableView

@end



@interface BLCollectionView : UICollectionView

@end

@interface BLCollectionCell : UICollectionViewCell

@end

@interface BLWebView : UIWebView

@end



@interface BLTabBarVC : UITabBarController

@end


@class BLTableViewCell;
@protocol BLTableViewCellDelegate <NSObject>

/** 点击事件
 */
-(void)BLTableViewCell:(BLTableViewCell*)cell clickAction:(NSInteger)action withModel:(id)model;

@end

@interface BLTableViewCell : UITableViewCell

@property ( nonatomic , weak ) id<BLTableViewCellDelegate> BLCelldelegate;

/** 反馈事件快捷方法*/
-(void)reportCellAction:(NSInteger)action withModel:(id)model;


@end


