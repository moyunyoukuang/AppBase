//
//  QRCodeScan.h
//  deLaiSu
//
//  Created by sunyuchao on 16/1/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppVC.h"

@class QRCodeScan;

@protocol QRCodeScanDelegate <NSObject>

-(void)QRCodeScan:(QRCodeScan*)VC postQRCode:(NSString *)qrcode;

@end

@interface QRCodeScan : AppVC

@property (nonatomic,weak) id<QRCodeScanDelegate> delegate;

@end
