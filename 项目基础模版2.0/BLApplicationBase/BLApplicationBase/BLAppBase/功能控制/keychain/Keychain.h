//
//  Keychain.h
//  keychaiTest
//
//  Created by camore on 16/11/7.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Keychain : NSObject


+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
//+ (void)delete:(NSString *)service;

@end
