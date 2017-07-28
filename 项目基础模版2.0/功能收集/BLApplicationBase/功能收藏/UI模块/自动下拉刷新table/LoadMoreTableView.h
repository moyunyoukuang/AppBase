//
//  LoadMoreTableView.h
//  BaiTang
//
//  Created by camore on 16/3/24.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"
#import "MJRefreshBaseView.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"



@class LoadMoreTableView;
@protocol LoadMoreTableViewDelegate <NSObject>

/** 上拉，下拉数据加载*/
-(void)LoadMoreTableView:(LoadMoreTableView*)tableView loadData:(MJRefreshBaseView *)refresh formore:(BOOL)more forfresh:(BOOL)fresh;

@end


@interface LoadMoreTableView : BLTableView

@property (nonatomic , weak ) id <LoadMoreTableViewDelegate> loadMoreDelegate;
/** 当前页码*/
@property (nonatomic , readwrite)__block NSInteger currentPage;

/** 设置小于每页数量时自动关闭加载更多 默认 PageSizePre*/
@property ( nonatomic , readwrite ) NSInteger pagePreSize;

/** 永远显示加载更多 (默认no 清空数据时隐藏)*/
@property ( nonatomic , readwrite ) BOOL showFooterForever;

/** 在加载中*/
@property ( nonatomic , readwrite ) BOOL isloadingAnimate;

/** 离开页面时必须调用 否则会出错*/
- (void)free;

////数据操作
/** 获取到的数据*/
-(NSMutableArray*)dataList;

/** 添加数据到list 
 @param array 数量少于 pageSizePre 时会隐藏底部视图
 @param page为1 时 会清空原列表
 */
-(void)addDataToListWithArray:(NSArray*)array forPage:(NSInteger)page;

/** 清空数据*/
-(void)clearData;

/** 停止所有加载动作*/
-(void)stopAllLoad;
/** 立即停止所有加载动作*/
-(void)stopImidiately;


////动画效果
/** 添加下拉刷新功能 作用于 maintableview*/
- (void)enanblePullRefresh:(BOOL)isEnable;
/** 触发下啦刷新动画，并自动触发数据刷新方法*/
- (void)beginPullRefreshing;
/** 结束下啦刷新动画*/
- (void)endPullRefreshing;


/** 添加上拉加载更多功能 footer 默认隐藏，需要设置显示*/
- (void)enanblePushLoadmore:(BOOL)isEnable;
/** 设置footer 显示隐藏*/
-(void)setFooterhidden:(BOOL)hidden;
/** 触发上拉加载更多动画，并自动触发数据刷新方法*/
- (void)beginPushLoadmore;
/** 结束上拉加载更多动画*/
- (void)endPushLoadmore;


@end
