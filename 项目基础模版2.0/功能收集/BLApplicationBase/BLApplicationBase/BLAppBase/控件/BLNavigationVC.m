//
//  BLNavigationVC.m
//  BLApplicationBase
//
//  Created by camore on 2017/7/12.
//  Copyright © 2017年 BLapple. All rights reserved.
//

#import "BLNavigationVC.h"

@interface BLNavigationVC ()
{
    /** isBack为YES时表示 不可侧滑 */
    BOOL isBack;
}

@property(nonatomic,weak) UIViewController *currentShowVC;

@end

@implementation BLNavigationVC
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        self.delegate = (id)self;
        self.navigationBar.hidden = YES;
        [self setNavigationBarHidden:YES];
    }
    
    return self;
}

#pragma mark- 左划控制

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}


//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (navigationController.viewControllers.count <= 1) {
//        self.currentShowVC = nil;
//    }else{
//        self.currentShowVC = viewController;
//    }
//}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count <= 1) {
        self.currentShowVC = nil;
    }else{
        self.currentShowVC = viewController;
        
        if([viewController isKindOfClass:[BLVC class]])
        {
            BLVC * VC  = (BLVC*)viewController;
            if(VC.backButton.hidden == YES || VC.backToRoot == YES || VC.cancelSideslip)
            {
                //不可反回
                isBack = YES;
            }else
            {
                //可以反回
                isBack = NO;
            }
            
            
        }else
        {
            isBack = NO;
        }
        
    }
}

// 询问一个手势接收者是否应该开始解释执行一个触摸接收事件
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.currentShowVC == self.topViewController) {
            
            if(isBack == YES){
                
                return NO;
            }else{
           
                return YES;
            }
        }else{
        
            return NO;
        }
    }
   
    return YES;
}


@end


@implementation UIScrollView (AllowPanGestureEventPass)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    }else{
        return  NO;
    }
}

@end
