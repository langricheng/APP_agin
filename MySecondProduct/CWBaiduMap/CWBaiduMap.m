//
//  CWBaiduMap.m
//  MySecondProduct
//
//  Created by chengwen on 16/7/28.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "CWBaiduMap.h"


#define GlobalInstance [CWBaiduMap shareInstance]

@interface CWBaiduMap ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapManager *bmkManger;
@property (nonatomic, strong) BMKLocationService *localService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;


@property (nonatomic, copy) BaiduMapResult locationResult;//定位成功bolock
@property (nonatomic, copy) BaiduMapResult reverseGeoResult;  //反地理编码结果bolock
@property (nonatomic, copy) BaiduMapGeoCodeResult geoCodeResult; // 根据地址获取地理信息结果bock


@property (nonatomic, strong) BMKUserLocation *currentLocation;

@end

@implementation CWBaiduMap


+ (CWBaiduMap *)shareInstance
{
   static CWBaiduMap *cwMap = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        cwMap = [[CWBaiduMap alloc]init];
        
    });

    return cwMap;
    
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.bmkManger = [[BMKMapManager alloc]init];
        self.localService = [[BMKLocationService alloc]init];
        self.localService.delegate = self;
        
        self.geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        self.geoCodeSearch.delegate = self;
        
    }
    
    return self;
}

#pragma mark - 公共方法

+ (BOOL)authorizeBaiduMapWithKey:(NSString *)key andDegate:(id)delegate
{
    BOOL ret = NO;
    ret = [GlobalInstance.bmkManger start:key generalDelegate:delegate];
    
    if (!ret) {
        NSLog(@"百度地图------------ 初始化失败");
    }
    return ret;
    
}

+ (BMKMapView *)obtainMapWithFrame:(CGRect)frame
{
    BMKMapView *map = [[BMKMapView alloc]initWithFrame:frame];
    [map setMapType:BMKMapTypeStandard]; //设置地图类型
    [map setTrafficEnabled:YES];//开启实时路况
    map.zoomLevel = 18;
    map.showsUserLocation = YES;
    
    return map;
}


+ (void)startLocateWithResult:(BaiduMapResult)reslut
{
    //启动定位
    [GlobalInstance.localService startUserLocationService];
    
    if (reslut) {
        GlobalInstance.locationResult = reslut;
    }
}


+ (BMKUserLocation *)obtainCurrentUserLocation
{
    return GlobalInstance.currentLocation;
}

+ (void)reverseGeoCodeWith:(CLLocationCoordinate2D)coordinate andReslut:(BaiduMapResult)result
{
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = coordinate;
    
  
   BOOL ret = [GlobalInstance.geoCodeSearch reverseGeoCode:option];
    if (!ret) {
        if (result) {
            result(nil,@"反编码失败");
            
            return;
        }
    }
    
    if (result) {
        GlobalInstance.reverseGeoResult = result;
    }
    
}

+ (void)geoCodeWith:(NSString *)city andAddress:(NSString *)address andResult:(BaiduMapGeoCodeResult)result
{
    BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc]init];
    option.city = city;
    option.address = address;
    
    BOOL ret = [GlobalInstance.geoCodeSearch geoCode:option];
    
    if (!ret) {
        if (result) {
            result(nil,@"搜索地理信息失败");
            
            return;
        }
    }
    
    if (result) {
        GlobalInstance.geoCodeResult = result;
    }
    
}


#pragma mark - BMKLocationServiceDelegate

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    GlobalInstance.currentLocation = userLocation;
    
    //将定位好的地理坐标进行反编码
   [CWBaiduMap reverseGeoCodeWith:userLocation.location.coordinate andReslut:^(BMKReverseGeoCodeResult *reverseResult, id error) {
       if (self.locationResult) {
           self.locationResult(reverseResult,error);
       }
   }];
    
}

#pragma mark - BMKGeoCodeSearchDelegate

//返回地址信息搜索结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.geoCodeResult) {
        if (error == 0) {
            self.geoCodeResult(result,nil);
        }
        else{
            self.geoCodeResult(nil,[NSString stringWithFormat:@"%d",error]);
        }
    }
}

//返回反地理编码搜索结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.reverseGeoResult) {
        if (error == 0) {
            self.reverseGeoResult(result,nil);
            
            [self.localService stopUserLocationService];//有结果了就停止定位
        }
        else{
            self.geoCodeResult(nil,[NSString stringWithFormat:@"%d",error]);
        }
    }
}

@end
