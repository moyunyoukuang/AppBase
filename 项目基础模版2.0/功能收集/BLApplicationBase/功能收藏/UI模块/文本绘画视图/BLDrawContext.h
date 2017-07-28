//
//  BLDrawContext.h
//  BaiTang
//
//  Created by camore on 16/4/1.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

/**
 BLDrawContext 是为了表示绘画页面布局内容而存在的
 */


///绘画视图关键字
#define BLDrawViewKey  @"BLDrawViewKey"

@class BLDrawView;
@class BLDrawContext;
@class tapinfo;

@protocol BLDrawContextDatasource <NSObject>
@optional

/** 绘画视图事件 添加视图
 @param DrawContext 内容
 @param DrawView    视图//  由于获取较早没有传递
 */
-(UIView*)BLDrawContext:(BLDrawContext*)DrawContext BLDrawView:(BLDrawView*)DrawView DrawActinName:(NSString*)name;

@end

@protocol BLDrawContextDelegate <NSObject>
@optional
/** 点击事件 
 @param DrawContext 内容
 @param DrawView    视图
 */
-(void)BLDrawContext:(BLDrawContext*)DrawContext BLDrawView:(BLDrawView*)DrawView TapActionactionname:(NSString*)name;



@end


/** 会话内容*/
@interface BLDrawContext : NSObject

///设置信息
/** 会话最基础文本 attributestring或者conTextstring 只用设置一个*/
@property ( nonatomic , strong ) NSMutableAttributedString * attributestring;
/** 会话最基础文本 attributestring或者conTextstring 只用设置一个*/
@property ( nonatomic , strong ) NSString * conTextstring;
@property ( nonatomic , weak ) id<BLDrawContextDatasource> BLDrawContextDatasource;
@property ( nonatomic , weak ) id<BLDrawContextDelegate> delegate;

///** 绘画文本替换为空 可以去掉某些影响 默认为yes*/
//@property ( nonatomic , readwrite ) BOOL       rePlaceViewTextWithBlank;


/** 添加点击事件*/
-(void)addTouchActionForText:(NSString*)text  ActionName:(NSString*)Actionname;
/** 添加点击事件*/
-(void)addTouchActionForIndex:(NSRange)range  ActionName:(NSString*)Actionname;

/** 添加视图 添加视图只添加一个字符*/
-(void)addViewForText:(NSString*)text  ActionName:(NSString*)Actionname;
/** 添加视图 添加视图只添加一个字符*/
-(void)addViewForIndex:(NSRange)range  ActionName:(NSString*)Actionname;


///获取信息
/** 获取绘画内容*/
-(NSMutableAttributedString * )getContext;
/** 获取CTFramesetterRef*/
-(CTFramesetterRef)getFramesetterRef;


/** 是否需要开启点击事件 有点击事件添加时自动设为yes*/
@property ( nonatomic , readwrite ) BOOL            enAbleTouch;
/** 是否需要开启添加视图  有点击事件添加时自动设为yes*/
@property ( nonatomic , readwrite ) BOOL            enAbleAddView;


/** 获取tap事件*/
@property ( nonatomic , strong ) NSMutableArray <tapinfo*>* AddActions;
/** 获取视图*/
@property ( nonatomic , strong ) NSMutableArray <tapinfo*>* AddViews;

/** 点击事件*/
-(void)BLtouchText:(BLDrawView*)touchText TapActionactionname:(NSString*)name;
/** 获取视图事件*/
-(UIView*)BLtouchText:(BLDrawView*)touchText ViewActionactionname:(NSString*)name;


@end

/** 文本匹配器*/
@interface BLMatchEnumerator : NSObject

-(instancetype)initWithString:(NSString *)string  MatchText:(NSString*)matchstring;

-(NSRange)Next;

@end


typedef enum
{
    ///点击
    tapinfoActionClick           = 1,
    ///添加视图
    tapinfoActionAddPic          = 2,
    
}tapinfoAction;

/** 点击信息/添加视图信息 自动生成*/
@interface tapinfo : NSObject

/** 类型
 1 点击
 2 添加视图
 */
@property ( nonatomic , readwrite ) tapinfoAction    tapType;



/** 设置的点击文字 需要设置isAllContent yes 不需要设置 touchRange*/
@property ( nonatomic , strong ) NSString * taptext;
/** 返回的事件*/
@property ( nonatomic , strong ) NSString * tapAction;
/** 是否是匹配全文*/
@property ( nonatomic , readwrite)BOOL      isAllContent;
/** 响应点击的字段,@"index,length"格式的字符串*/
@property ( nonatomic , readwrite) NSMutableArray * touchRange;
/** 响应添加的视图*/
@property ( nonatomic , strong) NSMutableArray  * addViews;

@end


