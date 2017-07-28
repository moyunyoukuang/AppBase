//
//  QRCodeScan.m
//  deLaiSu
//
//  Created by sunyuchao on 16/1/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "QRCodeScan.h"
#import <AVFoundation/AVFoundation.h>
//#import <AudioToolbox/AudioToolbox.h>
#import "QRCodeReaderView.h"

@interface QRCodeScan ()<QRCodeReaderViewDelegate> {
    /** 二维码扫描对象 */
    QRCodeReaderView * readview;
    /** 第一次进入该页面 */
    BOOL isFirst;
}

@end

@implementation QRCodeScan

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeNav];
    isFirst = YES;
    [self initScan];
}

-(void)makeNav{
    [self setTitle:@"扫一扫"];
}

#pragma mark 初始化扫描
- (void)initScan
{
    if (readview) {
        [readview removeFromSuperview];
        readview = nil;
    }

    readview = [[QRCodeReaderView alloc]initWithFrame:CGRectMake(0, 64, ScreenWith, ScreenHeight-64)];
    readview.is_AnmotionFinished = YES;
    readview.backgroundColor = [UIColor clearColor];
    readview.delegate = self;
    readview.alpha = 0;
    [self.view addSubview:readview];
    
    [UIView animateWithDuration:0.5 animations:^{
        readview.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark -QRCodeReaderViewDelegate
- (void)readerScanResult:(NSString *)result
{
    readview.is_Anmotion = YES;
    [readview stop];
    
    if (result && result.length>0) {
      
        [self popBack];
        if([self.delegate respondsToSelector:@selector(QRCodeScan:postQRCode:)])
        {
            [self.delegate QRCodeScan:self postQRCode:result];
        }
      
    }else{
        [self performSelector:@selector(reStartScan) withObject:nil afterDelay:1.5];
    }
}

- (void)reStartScan
{
    readview.is_Anmotion = NO;
    
    if (readview.is_AnmotionFinished) {
        [readview loopDrawLine];
    }
    [readview start];
}

#pragma mark - view
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isFirst) {
        if (readview) {
            [self reStartScan];
        }
    }
    
    

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (readview) {
        [readview stop];
        readview.is_Anmotion = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (isFirst) {
        isFirst = NO;
    }
    
    if([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)
    {
        //    AVAuthorizationStatusNotDetermined = 0,// 未进行授权选择
        //
        //    AVAuthorizationStatusRestricted,　　　　// 未授权，且用户无法更新，如家长控制情况下
        //
        //    AVAuthorizationStatusDenied,　　　　　　 // 用户拒绝App使用
        //
        //    AVAuthorizationStatusAuthorized,　　　　// 已授权，可使用
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusNotDetermined || authStatus == AVAuthorizationStatusAuthorized){
            
        }else{
            //                未开启相机访问权限，请在手机的 设置-隐私-相机 中开启
            [self showtagMessage:@"请在手机设置中开启相机访问权限"];
            [self popBack];
        }
    }
}



@end
