//
//  BLWebVC.m
//  BaiTang
//
//  Created by camore on 16/3/14.
//  Copyright © 2016年 BLapple. All rights reserved.
//
#import <JavaScriptCore/JavaScriptCore.h>
#import "BLWebVC.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface BLWebVC ()<NSURLSessionDelegate>
{
    /***************数据控制***************/
    /** 是否要缩进下面tabbar 首页网页需要显示tabbar yes：  隐藏    no： 显示*/
    BOOL                    shouldHideTab;

    /** 网页的context */
    JSContext           *   webviewJavaContext;
    
 

    /***************视图***************/
    /** 网页视图*/
    BLWebView           *   mainWebView;
    
    /** 加载错误视图*/
    BLView              *   netError_page;
    
    /** 返回按钮*/
    UIButton            *   goBackBtn;
    
    /** 前进按钮*/
    UIButton            *   goForwardBtn;
    
    
    
}
@end

@implementation BLWebVC




#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************


/** 加载网页
 @param urlstring 网址，如果不写urlstring 则默认加载促销页面
 @param title 标题
 @param hideTab 是否显示tabbar（底部高度减少49）
 */
-(instancetype)initWithUrl:(NSString*)urlstring title:(NSString*)title showTabbar:(BOOL)hideTab
{
    self = [super init];
    if(self)
    {
        if(urlstring)
        {
            
            
        }
        
        self.urlString = urlstring;
        self.pageTitle = title;
        shouldHideTab  = hideTab;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.viewFirstAppear)
    {
        [self loadWebViewContent];
    }
}


//dealloc 放最上面
- (void)viewDidLoad {
    [super viewDidLoad];

    [self chuShiHua];

    [self setUpViews];
    
}

-(void)chuShiHua
{
    
    
}

-(void)setUpViews
{
    [self setTitle:self.pageTitle];

    [self createWebView];
    
    [self createerrorview];
    
    
}



#pragma mark- ********************点击事件********************

-(void)popBack
{
    if(self.backAsHouTui)
    {
        if ([mainWebView canGoBack])
        {
            [self goBack];
        }
        else
        {
            [super popBack];
        }
    }
    else
    {
        [super popBack];
    }
}

#pragma mark- 网页前进后退
/** 网页返回按钮点击*/
- (void)goBack
{

    [mainWebView goBack];
}
/** 网页前进按钮点击*/
- (void)goForward
{
    [mainWebView goForward];
}
#pragma mark- ********************调用事件********************
/** 加载网页内容*/
-(void)loadWebViewContent
{
  if(self.urlString )
  {
      NSURL* pageurl = [NSURL URLWithStringSafe:self.urlString];
      
      if(pageurl)
      {
          NSURLRequest *request = [NSURLRequest requestWithURL:pageurl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData|NSURLRequestReloadIgnoringLocalCacheData|NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0  ];
          
          

          [mainWebView loadRequest:request];
      }
      
//      if(pageurl)
//      {
//          
//          NSURL *url = pageurl;
//          
//          NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//          [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData|NSURLRequestReloadIgnoringLocalCacheData|NSURLRequestReloadIgnoringCacheData];
//          [request setHTTPShouldHandleCookies:NO];
//          [request setTimeoutInterval:15];
//          [request setHTTPMethod:@"GET"];
//          
//          
//          [[AppManager shareManager] addHttpsRenZhengWithRequest:request];
//          
//          [mainWebView loadRequest:request];
//          
//
//          
//      }
  }
}

/** 重新加载页面按钮点击*/
-(void)reloadButtonClick
{
    [mainWebView reload];
}

#pragma mark- ********************代理方法********************
#pragma mark-    UIWebviewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    netError_page.hidden = YES;
    
    //使用假地址，防止重复请求
//    NSMutableURLRequest *request_fake = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithStringSafe:@"https://www.baidu.com"]];
//    [request_fake setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData|NSURLRequestReloadIgnoringLocalCacheData|NSURLRequestReloadIgnoringCacheData];
//    [request_fake setHTTPShouldHandleCookies:NO];
//    [request_fake setTimeoutInterval:15];
//    [request_fake setHTTPMethod:@"GET"];
//    [indicatoreview catchrequest:request_fake];
    
    
    
    

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    netError_page.hidden=YES;
    [self webviewaddBackBlock:webView];
    
    
    [self showLoadingView:YES];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //设置返回前进按钮
    netError_page.hidden=YES;

    
    if(self.showQianJinHouTui)
    {
        // 当当前页面是唯一VC时，显示前进后退按钮，否则不展示
        if ([mainWebView canGoBack])
        {
            
            if(!goBackBtn)
            {
                // 显示返回按钮
                goBackBtn = [MyControl createButtonWithFrame:CGRectMake(0, 0, 30, 30) target:self method:@selector(goBack)];
                goBackBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
                [goBackBtn setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];
                [self.naviView addSubview:goBackBtn];
                goBackBtn.centerY = self.leftButton.centerY;
                goBackBtn.left = self.leftButton.right ;
                
//                [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//                [goBackBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:BACKX];
//                [goBackBtn autoSetDimensionsToSize:CGSizeMake(30, 30)];
//                [goBackBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
                
            }
            goBackBtn.hidden = NO;
        }
        else
        {
            goBackBtn.hidden = YES;
        }
        
        if([mainWebView canGoForward])
        {
            if(!goForwardBtn)
            {
                // 显示前进按钮
                goForwardBtn = [MyControl createButtonWithFrame:CGRectMake(0, 0, 30, 30) target:self method:@selector(goForward)];
                goForwardBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
                [goForwardBtn setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];

                [self.naviView addSubview:goForwardBtn];
                goForwardBtn.centerY = self.leftButton.centerY;
                goForwardBtn.left = goBackBtn.right + SameH(10);
                
//                [goForwardBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:7*kCommonMargin];
//                [goForwardBtn autoSetDimensionsToSize:CGSizeMake(30, 30)];
//                [goForwardBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
                [goForwardBtn setTransform:CGAffineTransformMakeRotation(M_PI)];
                
            }
            goForwardBtn.hidden = NO;
        }
        else
        {
            goForwardBtn.hidden = YES;
        }

    }
    
    
    
    
    [self webviewaddBackBlock:webView];
    
    
    [self showLoadingView:NO];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    
  
    
    [self.view bringSubviewToFront:netError_page];
    netError_page.hidden = NO;
    
    
    [self showLoadingView:NO];

}






#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
/** 创建网页*/
-(void)createWebView
{
    [mainWebView removeFromSuperview];
    
    mainWebView = [[BLWebView alloc] initWithFrame:CGRectMake(0, self.naviView.bottom, self.view.width, self.view.height-self.naviView.bottom-shouldHideTab*TabBarHeight)];
    [self.view addSubview:mainWebView];

    mainWebView.delegate = (id)self;
    mainWebView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    mainWebView.backgroundColor = [UIColor clearColor];
    mainWebView.scrollView.backgroundColor = [UIColor clearColor];
    
    
//    mainWebView.backgroundColor = self.view.backgroundColor;
//    mainWebView.scrollView.backgroundColor = self.view.backgroundColor;
    
    //消除黑色背景
    for (UIScrollView *view in mainWebView.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [view setShowsHorizontalScrollIndicator:NO];
            view.bounces = NO;
        }
    }
//    [mainWebView setScalesPageToFit:YES];
//    
//    [mainWebView setOpaque:NO];
    
}


/** 创建网页加载进度条*/
-(void)createWebIndicator
{
//    indicatoreview = [[Downloadindicater alloc] initWithFrame:CGRectMake(0, self.naviView.height-1, ScreenWith, 2)];
//    indicatoreview.backgroundColor = [UIColor yellowColor];
//    [self.naviView addSubview:indicatoreview];
    
}

/** 创建网页加载错误界面*/
-(void)createerrorview
{
    /** 加载失败页*/
    netError_page = [MyControl createViewWithFrame:CGRectMake(0, self.naviView.bottom, ScreenWith, ScreenHeight-self.naviView.bottom-shouldHideTab*TabBarHeight)];
    netError_page.hidden=YES;
    netError_page.backgroundColor = color_second_view_white;
    /** 点击重试按钮*/
    BLButton * reloadButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, 170, 44) target:self method:@selector(reloadButtonClick)];
    [reloadButton setCornerRadius:4];
    [reloadButton setTitle:@"加载失败，点击重试" forState:UIControlStateNormal];
    [reloadButton setTitleColor:color_text_main_black forState:UIControlStateNormal];
    reloadButton.layer.borderWidth =    1.0;
    reloadButton.layer.borderColor = [UIColor grayColor].CGColor;
    reloadButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    reloadButton.centerX = netError_page.width/2;
    reloadButton.centerY = self.view.height/2-netError_page.top;
    [netError_page addSubview:reloadButton];
    
    [self.view addSubview:netError_page];
    

}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面

/** 给网页添加响应事件*/
- (void)webviewaddBackBlock:(UIWebView*)webView
{
    webviewJavaContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    webviewJavaContext.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    
    
//    __weak  __block typeof(self) weakSelf = self;
//    webviewJavaContext[@"showDrugList"] = ^(NSString *category_id,NSString *category_name)
//    {
//        
//        
//    };
}
@end
