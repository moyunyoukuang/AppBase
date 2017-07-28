//
//  TuPianLiuLanVC.m
//  DaJiShi
//
//  Created by camore on 16/7/25.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "TuPianLiuLanVC.h"

#import "PicLiuLanView.h"


#import "TuPianLiuLanCell.h"
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性
@interface TuPianLiuLanVC()
{
    /***************数据控制***************/
    /** 显示导航栏*/
    BOOL        showNavi;
    
    UITapGestureRecognizer * tapContent;
    
    /***************视图***************/
    /** 内容视图*/
    UITableView     *   table_content;
    
    /** 当前的底部视图*/
    UIView          *   bottomView_current;
}

@end


@implementation TuPianLiuLanVC

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(instancetype)initWithPicUrl:(NSArray*)array_url BottomView:(NSArray *)array_bottom
{
    self = [super init];
    
    if(self)
    {
        self.array_url = array_url;
        self.array_bottom = array_bottom;
    }
    
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self chuShiHua];

    [self setUpViews];

}

-(void)chuShiHua
{
    showNavi = YES;
}

-(void)setUpViews
{
    [self setTitleForIndex:self.currentIndex];
    
    [self createNavi];

    [self createAllView];
    
    
    
    [self setBottomViewForIndex:self.currentIndex];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark- ********************调用事件********************
/** 普通的底部视图*/
+(UIView *)customBottmView
{
    BLView * view = [MyControl createViewWithFrame:CGRectMake(0, ScreenHeight - BiLiH(173), ScreenWith, BiLiH(173))];
    
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    
    return view;
}

#pragma mark- ********************点击事件********************
/** 点击内容*/
-(void)tapContent
{
    [self showNaviView:!showNavi];
}

#pragma mark- ********************继承方法********************


#pragma mark- ********************代理方法********************




#pragma mark- table delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_url count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    

    static NSString * cellIDenty = @"liulanpicCell";
    TuPianLiuLanCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIDenty];
    
    if(!cell)
    {
        
        CGRect mainScreen = [UIScreen mainScreen].bounds;
        cell = [[TuPianLiuLanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDenty];
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        cell.frame     =  mainScreen;
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        [tapContent requireGestureRecognizerToFail: cell.pic_view.gesture_doubleClick];
        
    }

    cell.frame = [UIScreen mainScreen].bounds;
    
    NSString * url_image = [self.array_url objectAtIndexSafe:indexPath.row];
    
    [cell setImageWith:nil OrUrl:url_image];
    

    
 
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenWith;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == table_content)
    {
        CGFloat location = scrollView.contentOffset.y;
        
        int index_page = (location + scrollView.width/2)/ScreenWith;
        
        self.currentIndex = index_page;
        
        [self setTitleForIndex:index_page];
        
        [self setBottomViewForIndex:self.currentIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView == table_content)
    {
        CGFloat location = scrollView.contentOffset.y;
        
        int index_page = (location + scrollView.width/2)/ScreenWith;
        
        self.currentIndex = index_page;
        
        [self setTitleForIndex:index_page];
        
        [self setBottomViewForIndex:self.currentIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == table_content)
    {
        CGFloat location = scrollView.contentOffset.y;
        
        int index_page = (location + scrollView.width/2)/ScreenWith;
        
        self.currentIndex = index_page;
        
        [self setTitleForIndex:index_page];
        
        [self setBottomViewForIndex:self.currentIndex];
    }
}
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建navi*/
-(void)createNavi
{
    self.naviView.backgroundColor = BLACK;
    self.titleLabel.textColor = WHITE;
    
}

/** 创建所有视图*/
-(void)createAllView
{
    
    
    CGRect windowBounds = [[UIScreen mainScreen] bounds];
    
    

    //table
    table_content = [[UITableView alloc]initWithFrame:windowBounds style:UITableViewStylePlain];
     [self.view addSubview:table_content];
    [self.view  sendSubviewToBack: table_content];
    table_content.transform = CGAffineTransformMakeRotation(-M_PI_2);
    table_content.frame = CGRectMake(0,0,windowBounds.size.width,windowBounds.size.height);;
    table_content.pagingEnabled = YES;
    table_content.delegate = self;
    table_content.dataSource = self;
    table_content.backgroundColor = [UIColor clearColor];
    table_content.showsVerticalScrollIndicator = NO;
//    table_content.showsHorizontalScrollIndicator = NO;
    table_content.separatorStyle = UITableViewCellSeparatorStyleNone;
    table_content.contentOffset = CGPointMake(0, ScreenWith * self.currentIndex);
    
    //gesture
    tapContent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent)];
    [self.view addGestureRecognizer:tapContent];
    
    
}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
/** 根据界面显示标题*/
-(void)setTitleForIndex:(NSInteger)index
{
    NSString * string_title = [NSString stringWithFormat:@"%ld/%ld",index+1,(unsigned long)[self.array_url count]];
    
    [self setTitle:string_title];
}

-(void)showNaviView:(BOOL)show
{
    showNavi = show;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.naviView.alpha = show?1:0;
        
        bottomView_current.alpha = show?1:0;
        
    }];
    
}

/** 设置底部视图*/
-(void)setBottomViewForIndex:(NSInteger)index
{
    
    UIView  *   bottomView_before = bottomView_current;
    
    UIView * bottomView = [self.array_bottom objectAtIndexSafe:index];
    
    if(bottomView_current == bottomView )
    {
        return ;
    }
    
   
    
    
    bottomView.alpha = 0;
    
    bottomView_current = bottomView;
    
    [self.view addSubview:bottomView];
    [UIView animateWithDuration:0.25 animations:^{
       
        if(bottomView_before)
        {
            bottomView.alpha = bottomView_before.alpha;
        }
        else
        {
            bottomView.alpha = 1.0;
        }
        
        bottomView_before.alpha = 0.0;
        
    }];
    
}
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************
@end
