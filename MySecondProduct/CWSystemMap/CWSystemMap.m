//
//  CWSystemMap.m
//  MySecondProduct
//
//  Created by chengwen on 16/7/27.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "CWSystemMap.h"


@interface CWSystemMap ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager_location;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, copy) CWSystemMapLocateResult sartLocationResult;
@end

@implementation CWSystemMap

/**
 
  注意要在infoplist 中添加下面两项
  1）NSLocationAlwaysUsageDescription
 （2）NSLocationWhenInUseUsageDescription
 
 */

+ (CWSystemMap *)shareInstance
{
    static CWSystemMap *cwMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cwMap = [[CWSystemMap alloc]init];
        
    });
    
    return cwMap;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager_location = [[CLLocationManager alloc]init];
        self.manager_location.delegate = self;//设置定位代理
        self.manager_location.desiredAccuracy = kCLLocationAccuracyBest;//设置精确度
        self.manager_location.distanceFilter = 10;//指定最小距离更新
        
        if ([[UIDevice currentDevice]systemVersion].floatValue >= 8.0) {
            [self.manager_location requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        
    }
    
    return self;
}

#pragma mark - 公共的方法

+ (void)startLocateWithResult:(CWSystemMapLocateResult)result
{
    CWSystemMap *cwMap = [CWSystemMap shareInstance];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [cwMap.manager_location startUpdatingLocation];
        
        if (result) {
            cwMap.sartLocationResult = result;
        }
    }
    else{
        NSLog(@"无法定位");
        if (result) {
            result(nil,@"无法定位");
        }
        
    }
}


+ (void)cw_obtainRegionInfoWithLocation:(CLLocationCoordinate2D)coordinate andResult:(CWSystemMapLocateResult)locateResult;
{
    
    
    //根据经纬度反向地理编译出地址信息
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
              NSString *city = placemark.locality; //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
             if (locateResult) {
                 locateResult(placemark,nil);
             }
             
         }else if (error == nil && [array count] == 0)
         {
             
         }else if (error != nil)
         {
             if (locateResult) {
                 locateResult(nil,error);
             }
         }
     }];

}

+ (CLLocation *)obtainCurrentLocationRegion
{
    CWSystemMap *cw_map = [CWSystemMap shareInstance];
    
    return cw_map.currentLocation;
}

+ (MKMapView *)obtainAnMapWithFrame:(CGRect)frame
{
    MKMapView *map = [[MKMapView alloc]initWithFrame:frame];
    map.userTrackingMode = MKUserTrackingModeFollow;// 跟踪用户位置，还可以跟踪用户方向
    map.mapType = MKMapTypeStandard;  //标准类型，还有卫星地图和混合地图
    map.showsUserLocation = YES;
    return map;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    self.currentLocation = [locations lastObject];
    
     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             NSString *city = placemark.locality; //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
             if (!city) {
                 city = placemark.administrativeArea;
             }
            
             if (self.sartLocationResult) {
                 self.sartLocationResult(placemark,nil);
             }
             
             [self.manager_location stopUpdatingLocation];
             
         }else if (error == nil && [array count] == 0)
         {
             
         }else if (error != nil)
         {
             if (self.sartLocationResult) {
                 self.sartLocationResult(nil,error);
             }
         }
     }];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.sartLocationResult) {
        self.sartLocationResult(nil,error);
    }
}


@end
