//
//  BLVC.m
//  BaiTang
//
//  Created by camore on 16/3/2.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLVC.h"
#import "BLManager.h"
#import "BLMessagepop.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface BLVC ()
{
    
    
    
    /********************视图***************/
    
    

    /** 加载中视图*/
    BLMessagepop            *   pop_loading;
    
}
@end

@implementation BLVC
#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(void)dealloc
{
    [pop_loading dissMissAlert];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewFirstAppear = YES;
    [self BLSetupData];
    [self BLSetupViews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.pageLoadAlready)
    {
        self.viewFirstAppear = NO;
    }
    self.pageLoadAlready = YES;
    
    
    self.navigationController.navigationBar.hidden=YES;
    
    if(self.navigationController)
    {
        [BLManager shareManager].currentNavi = self.navigationController;
    }
    [BLManager shareManager].mainVC = self;
    
    //设置显示吐丝对应视图号
    [[BLManager shareManager] setCurrentShowControllerTag:self.controllerTag];
}

-(void)BLSetupData
{
 
    self.controllerTag = random()%INT_MAX;
    self.autoHideKeyboard = YES;
}

-(void)BLSetupViews
{
    //基础设置
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.view.frame = CGRectMake(0, 0, ScreenWith, ScreenHeight);
    self.view.opaque = YES;
    self.view.backgroundColor = color_second_bg_gray;
    
    //navi
    self.naviView = [[BLView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith, NaviHeight)];
    [self.naviView setBackgroundColor:NaviColor];
    [MyControl addSepViewWithView:self.naviView location:self.naviView.height  downOrTop:NO];
    [self.view addSubview:self.naviView];
    
    //返回按钮
    self.backButton = [MyControl createButtonWithFrame:BACKButtonRect imageName:@"common_back.png" target:self method:@selector(leftButtonClick)];
    
    [self.naviView addSubview:self.backButton];
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(BiLiH(18), BiLiH(14), BiLiH(18), BiLiH(30));
    
    self.leftButton = self.backButton;
    
    //右边按钮
    self.rightButton = [MyControl createButtonWithFrame:RightButtonRect target:self method:@selector(rightButtonClick)];
    self.rightButton.hidden = YES;
    [self.naviView addSubview:self.rightButton];
    

    [self.rightButton setImage:[MyControl imageFileWithName:@"VC_cancel.png"] forState:UIControlStateNormal];
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(BiLiH(19) , BiLiH(19), BiLiH(19), BiLiH(19));
    
    
    //标题
    self.titleLabel = [MyControl createLabelWithFrame:CGRectMake(BiLiH(64), StatusHeight, ScreenWith-BiLiH(64*2), NaviHeight-StatusHeight) font:[UIFont systemFontOfSize:text_size_Navi] title:@""];
    [self.naviView addSubview:self.titleLabel];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:NaviTitleColor];
    if(self.title)
    {
        [self.titleLabel setText:self.title];
    }
    
    //如果是根视图，则不去显示返回按钮
    if (!self.navigationController || [[self.navigationController viewControllers] count] == 1)
    {
        
        [self setBackBtnHidden:YES];
        
    }
    
    
    
    self.view.clipsToBounds = YES;
    
}





-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)prefersStatusBarHidden
{
    return NO;
}




#pragma mark- ********************点击事件********************

/** 左边按钮点击*/
-(void)leftButtonClick
{
    [self popBack];
}


- (void)rightButtonClick
{

}
#pragma mark- ********************调用事件********************

-(void)reportPopBack
{
    if([self.BLVCActionDelegate respondsToSelector:@selector(BLVCViewBack:)])
    {
        [self.BLVCActionDelegate BLVCViewBack:self];
    }
}

#pragma mark- 功能方法
/** 暂停视图中的点击1s*/
-(void)delayTouchForSecond
{
    self.view.userInteractionEnabled = NO;
    [self performSelector:@selector(reEnableTouchView) withObject:nil afterDelay:1.0];
}



#pragma mark- ********************代理方法********************


#pragma mark- table delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.autoHideKeyboard)
    {
        [self hideKeyBoard];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if(self.autoHideKeyboard)
    {
        [self hideKeyBoard];
    }
}

#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视

/** 隐藏键盘*/
- (void)hideKeyBoard
{
    [self.view endEditing:YES];
}

#pragma mark- 界面样式设置
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [_titleLabel setText:title];
    
}
-(void)setBackBtnHidden:(BOOL)hidden
{
    self.backButton.hidden = hidden;
}
-(void)setNaviViewHiddent:(BOOL)hidden
{
    self.naviView.hidden = hidden;
}

#pragma mark- 快捷信息提示
/** 弹出提示消息*/
-(BLMessagepop *)showtagMessage:(NSString*)message
{
    if([NSThread isMainThread])
    {
        [self.view endEditing:YES];
        return [[BLManager shareManager] showtagMessage:message ControllerTag:self.controllerTag];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showtagMessage:message];
        });
    
    }
    return nil;
}



#pragma mark- 显示加载中
-(void)showLoadingView:(BOOL)show
{
    if(![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoadingView:show];
        });
        return;
    }
    
    if(!pop_loading)
    {
        pop_loading = [BLMessagepop customView];
        [pop_loading showMessageType:BLMessageTypeLoading content:nil];
       
        
    }
    
    if(show)
    {
        [pop_loading showInView:self.view];
        
    }
    else
    {
        [pop_loading dissMissAlert];
    }

}
#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面

/** 重新使点击生效*/
-(void)reEnableTouchView
{
    self.view.userInteractionEnabled = YES;
}

/** 视图是否可见 (视图已经展示出来，通过appear接口判断)*/
-(BOOL)isVCvisiable
{
    if([BLManager shareManager].mainVC == self)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



#pragma mark- 返回方法
-(void)popBack
{
    [self popBackAnimate:YES];
    
    [self reportPopBack];
    
}

- (void)popBackAnimate:(BOOL)animate
{
    [self.view endEditing:YES];
    
    if(self.backToRoot)
    {
        
        //找到最底层的navi
        UINavigationController* mainavi = self.navigationController;
        
        while (mainavi.presentingViewController && ![self navigationVCisMainVC:mainavi]) {
            
            UIViewController * presentVC = mainavi.presentingViewController;
            
            if([presentVC isKindOfClass:[UINavigationController class]])
            {
                mainavi =  (UINavigationController*)presentVC;
            }
            else
            {
                break;
            }
            
        }
        
        //            //设置首页位置为第一页
        //            if([mainavi isKindOfClass:[UINavigationController class]])
        //            {
        //                UITabBarController*tabcontrol = [mainavi.viewControllers objectAtIndexSafe:0];
        //                if([tabcontrol isKindOfClass:[UITabBarController class]])
        //                {
        //                    tabcontrol .selectedIndex = 0;
        //                }
        //            }
        
        //            mainavi.presentedViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [mainavi dismissViewControllerAnimated:animate completion:^{
            
        }];
        //如果很多层，直接返回第一层
        [mainavi popToRootViewControllerAnimated:animate];
        
        if([mainavi isKindOfClass:[UINavigationController class]])
        {
            [BLManager shareManager].mainNavi = (UINavigationController*)mainavi;
            
        }
        
        
        return;
    }
    
    if(self == [self.navigationController.viewControllers objectAtIndexSafe:0] && self.navigationController.presentingViewController)
    {//navigationController 自身是present出来的
        
        if([self.navigationController.presentingViewController isKindOfClass:[UINavigationController class]])
        {
            [BLManager shareManager].mainNavi = (UINavigationController*)self.navigationController.presentingViewController;
            
        }
        [self.navigationController dismissViewControllerAnimated:animate completion:^{
            
        }];
        
        
        return;
        
    }
    
    
    if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:animate];
    }
    else
    {
        if(self.presentingViewController)
        {
            [self dismissViewControllerAnimated:animate completion:^{
                
            }];
        }
        
    }
    
}


/** 判断navi是不是主navi*/
-(BOOL)navigationVCisMainVC:(UINavigationController*)navi
{
    
    UIViewController * rootVC = [BLManager shareManager].mainWindows.rootViewController;
    
    if(![rootVC isKindOfClass:[UINavigationController class]])
    {//跟视图不是navi返回yes
        return YES;
    }
    if(navi == rootVC)
    {
        return YES;
    }
    return NO;
}


@end
