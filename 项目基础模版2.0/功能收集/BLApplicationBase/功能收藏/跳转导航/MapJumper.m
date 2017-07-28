//
//  MapJumper.m
//  DaJiShi
//
//  Created by camore on 16/12/12.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "MapJumper.h"

// 引入地图功能所有的头文件
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import <BaiduMapAPI_Map/BMKMapComponent.h>
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>


#import <MapKit/MapKit.h>
#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface MapJumper ()<UIActionSheetDelegate>
{
    /***************数据控制***************/
    /** 起始位置*/
    CLLocationCoordinate2D location_Start;
    /** 结束位置*/
    CLLocationCoordinate2D location_End;
    
    /** 结束位置名*/
    NSString                *   name_End;
    /***************视图***************/
}
@property ( nonatomic , strong ) NSMutableArray * mapsUrlArray;



@end


@implementation MapJumper






#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(void)chuShiHua
{

}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
#pragma mark- ********************点击事件********************
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma --mark-- actionsheetdelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    if (buttonIndex==0) {
        CLLocationCoordinate2D to;
        
        to.latitude = location_End.latitude;
        to.longitude = location_End.longitude;
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
        
        
        toLocation.name = name_End;
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation,  nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeWalking, [NSNumber numberWithBool:YES],  nil]
                                      
                                      
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey,  nil]]];
    }
    else{
        NSString *str=[_mapsUrlArray objectAtIndex:buttonIndex];
        str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * myURL_APP_A =[[NSURL alloc] initWithString:str];
        NSLog(@"%@",myURL_APP_A);
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
            
            
        }
    }
    
}

//#pragma mark - MKMapViewDelegate
//
//- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
//            rendererForOverlay:(id<MKOverlay>)overlay
//{
//    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
//    renderer.lineWidth = 5.0;
//    renderer.strokeColor = [UIColor purpleColor];
//    return renderer;
//}
//
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    _coordinate.latitude = userLocation.location.coordinate.latitude;
//    _coordinate.longitude = userLocation.location.coordinate.longitude;
//    
//    [self setMapRegionWithCoordinate:_coordinate];
//}
//
//- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    MKCoordinateRegion region;
//    
//    region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(.1, .1));
//    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
//    [_mapView setRegion:adjustedRegion animated:YES];
//}

#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{

}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************


-(void)openOtherMapFrom:(CLLocationCoordinate2D)locationStart to:(CLLocationCoordinate2D)locationEnd name:(NSString*)nameEnd
{
    location_Start = locationStart;
    /** 结束位置*/
    location_End = locationEnd;
    
    name_End = nameEnd;
    
    
    UIActionSheet * _actionSheet= [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    
    
    // 地图
    NSMutableArray *mapsArray = [NSMutableArray array];
    //url
    _mapsUrlArray = [[NSMutableArray alloc] init];
    
    ////苹果地图
    NSURL * apple_App = [NSURL URLWithString:@"http://maps.apple.com/"];
    if ([[UIApplication sharedApplication] canOpenURL:apple_App]) {
        [mapsArray addObject:@"使用苹果自带地图导航"];
        
//        NSString *str=[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=%f,%f",locationStart.latitude,locationStart.longitude,locationEnd.latitude,locationEnd.longitude];
        NSString *str=[NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f",locationEnd.latitude,locationEnd.longitude];
        [_mapsUrlArray addObject:str];
    }
    
    ///百度地图
    NSURL * baidu_App = [NSURL URLWithString:@"baidumap://"];

    if ([[UIApplication sharedApplication] canOpenURL:baidu_App]) {
        [mapsArray addObject:@"使用百度地图导航"];
        
        CLLocation * myLocation=[[CLLocation alloc]initWithLatitude:locationStart.latitude longitude:locationStart.longitude];
        
//        myLocation = [myLocation locationBaiduFromMars];
        
        CLLocationCoordinate2D currentLocation = [myLocation coordinate];//当前经纬度
        float x_axis=currentLocation.longitude;
        float y_axis=currentLocation.latitude;
        
        CLLocation * myLocationTwo=[[CLLocation alloc]initWithLatitude:locationEnd.latitude longitude:locationEnd.longitude];
        
//        myLocationTwo = [myLocationTwo locationBaiduFromMars];
        
        CLLocationCoordinate2D currentLocationTwo=[myLocationTwo coordinate];//当前经纬度
        float x_a = currentLocationTwo.longitude;
        float y_a = currentLocationTwo.latitude;
        
        NSString *str=[NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving&src=companyName|appName",y_axis,x_axis,y_a,x_a];
//        NSString *str=[NSString stringWithFormat:@"baidumap://map/direction?destination=%f,%f&mode=walking",y_a,x_a];
        
        [_mapsUrlArray addObject:str];
    }
    
    ///高德地图
    
    NSURL * gaode_App = [NSURL URLWithString:@"iosamap://"];
    if ([[UIApplication sharedApplication] canOpenURL:gaode_App]) {
        [mapsArray addObject:@"使用高德地图导航"];
        
        NSString *str=[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&backScheme=applicationScheme&slat=%f&slon=%f&sname=我&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=1",locationStart.latitude,locationStart.longitude,locationEnd.latitude,locationEnd.longitude,nameEnd];
//        NSString *str=[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&backScheme=applicationScheme&sname=我&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=1",locationEnd.latitude,locationEnd.longitude,nameEnd];
        
        [_mapsUrlArray addObject:str];
    }
    
    ///google 地图
    NSURL * google_App = [NSURL URLWithString:@"comgooglemaps://"];
    if ([[UIApplication sharedApplication] canOpenURL:google_App]) {
        [mapsArray addObject:@"使用Google Maps导航"];
        
        NSString *str=[NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%f,%f&directionsmode=walking",locationStart.latitude,locationStart.longitude,locationEnd.latitude,locationEnd.longitude];
//        NSString *str=[NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f&directionsmode=walking",locationEnd.latitude,locationEnd.longitude];
        [_mapsUrlArray addObject:str];
    }
    
    for (int x=0; x<mapsArray.count; x++) {
        [_actionSheet addButtonWithTitle:[mapsArray objectAtIndex:x]];
        
    }
    
    [_actionSheet addButtonWithTitle:@"取消"];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    // NB - 这会导致该按钮显示时有黑色背景
    _actionSheet.cancelButtonIndex = _actionSheet.numberOfButtons-1;
    [_actionSheet showInView:[AppManager shareManager].mainWindows];
    
}



@end
