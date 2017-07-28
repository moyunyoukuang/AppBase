//
//  LoadMoreScrollView.m
//  DaJiShi
//
//  Created by camore on 2017/6/21.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "LoadMoreScrollView.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface LoadMoreScrollView()
{
    /***************数据控制***************/
    
    NSMutableArray      *   array_dataList;
    
    /***************视图***************/
    /** 下拉刷新视图*/
    MJRefreshHeaderView * header;
    /** 上拉加载更多视图*/
    MJRefreshFooterView * footer;
}
@end

@implementation LoadMoreScrollView

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面
-(void)dealloc
{
    [header free];
    
    [footer free];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    
    if(self)
    {
        self.pagePreSize = PageSizePre;
        array_dataList = [ NSMutableArray array];
    }
    return self;
}



#pragma mark- ********************点击事件********************
#pragma mark- ********************调用事件********************
/** 停止所有加载动作*/
-(void)stopAllLoad
{
    
    [self endPushLoadmore];
    [self endPullRefreshing];
    self.isloadingAnimate = NO;
}

/** 立即停止所有加载动作*/
-(void)stopImidiately
{
    if([footer isRefreshing])
    {
        [footer endRefreshingImidiately];
    }
    if([header isRefreshing])
    {
        [header endRefreshingImidiately];
    }
    
    self.isloadingAnimate = NO;
}
#pragma mark- 上拉，下拉数据加载方法
/** 上拉，下拉数据加载*/
-(void)loadData:(MJRefreshBaseView *)refresh formore:(BOOL)more forfresh:(BOOL)fresh
{
    
    if(self.loadMoreDelegate && [self.loadMoreDelegate respondsToSelector:@selector(LoadMoreTableView:loadData:formore:forfresh:)])
    {
        
        [self.loadMoreDelegate LoadMoreTableView:self loadData:refresh formore:more forfresh:fresh];
        
    }
    
}


////数据操作
/** 获取到的数据*/
-(NSMutableArray*)dataList
{
    return array_dataList;
}

/** 添加数据到list page为1 时 会清空原列表*/
-(void)addDataToListWithArray:(NSArray*)array forPage:(NSInteger)page
{
    
    if(self.pagePreSize > 0 )
    {
        if([array count] < self.pagePreSize)
        {
            [self setFooterhidden:YES];
        }
        else
        {
            [self setFooterhidden:NO];
        }
    }
    
    
    if(page == 1)
    {
        [array_dataList removeAllObjects];
    }
    if([array isKindOfClass:[NSArray class]])
    {
        [array_dataList addObjectsFromArray:array];
    }
    
    self.currentPage = page;
    
//    [self reloadData];
    
}

/** 清空数据*/
-(void)clearData
{
    self.currentPage = 0 ;
    //    [array_dataList removeAllObjects];
    //    if(!self.showFooterForever)
    //    {
    //        [self setFooterhidden:YES];
    //    }
//    [self reloadData];
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
#pragma mark- 上拉加载下拉刷新样式
- (void)enanblePullRefresh:(BOOL)isEnable
{
    if (self && [self superview])
    {
        if (isEnable == YES)
        {
            __weak LoadMoreScrollView*  vc = self;
            [header endRefreshing];
            self.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            
            [header removeFromSuperview];
            
            header = [MJRefreshHeaderView header];
            header.beginRefreshingBlock = ^(MJRefreshBaseView * refresh){
                __strong LoadMoreScrollView* strongself=vc;
                [strongself loadData:refresh formore:NO forfresh:YES];
            };
            header.scrollView =self;
            header.hidden = NO;
            
        }
        else
        {
            [header removeFromSuperview];
        }
        
    }
    
}

- (void)beginPullRefreshing
{
    self.isloadingAnimate = YES;
    if(![header isRefreshing])
    {
        [header beginRefreshing];
    }
    
}

- (void)endPullRefreshing
{
    if([header isRefreshing])
    {
        [header endRefreshing];
    }
    
}



#pragma mark- loadmore
- (void)enanblePushLoadmore:(BOOL)isEnable
{
    
    if (self && [self superview])
    {
        if (isEnable == YES)
        {
            __weak LoadMoreScrollView*  vc = self;
            [footer endRefreshing];
            self.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            [footer removeFromSuperview];
            
            footer = [MJRefreshFooterView footer];
            footer.beginRefreshingBlock = ^(MJRefreshBaseView * refresh){
                __strong LoadMoreScrollView* strongself=vc;
                [strongself loadData:refresh formore:YES forfresh:NO];
            };
            footer.scrollView =self;
            footer.hidden = YES;
            
        }
        else
        {
            
            [footer removeFromSuperview];
        }
        
    }
}

- (void)beginPushLoadmore
{
    self.isloadingAnimate = YES;
    if(![footer isRefreshing])
    {
        [footer beginRefreshing];
    }
    
}

- (void)endPushLoadmore
{
    if([footer isRefreshing])
    {
        [footer endRefreshing];
    }
    
}

-(void)setFooterhidden:(BOOL)hidden
{
    footer.hidden = hidden;
}

/** 离开页面时必须调用 否则会出错*/
- (void)free
{
    [header free];
    [footer free];
}

#pragma mark-  跳转其他页面

@end
