//
//  MapJumper.h
//  DaJiShi
//
//  Created by camore on 16/12/12.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
/** 跳转导航控制*/
@interface MapJumper : NSObject

-(void)openOtherMapFrom:(CLLocationCoordinate2D)locationStart to:(CLLocationCoordinate2D)locationEnd name:(NSString*)nameEnd;

@end
