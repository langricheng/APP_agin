//
//  CWBaiduMap.h
//  MySecondProduct
//
//  Created by chengwen on 16/7/28.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

typedef void(^BaiduMapResult)(BMKReverseGeoCodeResult *reverseResult, id error);
typedef void(^BaiduMapGeoCodeResult)(BMKGeoCodeResult *geoResult, id error);

@interface CWBaiduMap : NSObject

+ (CWBaiduMap *)shareInstance;

/**
 *  注册百度地图
 *
 *  @param key      应用key
 *  @param delegate 注册时如果需要关注网络及授权验证事件 则设置代理
 *
 *  @return 注册是否成功
 */
+ (BOOL)authorizeBaiduMapWithKey:(NSString *)key andDegate:(id)delegate;

/**
 *  创建一张地图
 *
 *  @param frame 地图大小
 *
 *  @return
 */
+ (BMKMapView *)obtainMapWithFrame:(CGRect)frame;

/**
 *  开始启动定位
 *
 *  @param reslut 定位结果block
 */
+ (void)startLocateWithResult:(BaiduMapResult)reslut;


/**
 *  反地理编码
 *
 *  @param coordinate 地理坐标
 *
 *  @return
 */
+ (void)reverseGeoCodeWith:(CLLocationCoordinate2D)coordinate andReslut:(BaiduMapResult)result;

/**
 *  根据地址信息获取地理信息
 *
 *  @param city    城市名
 *  @param address  地址
 *  @param result
 */
+ (void)geoCodeWith:(NSString *)city andAddress:(NSString *)address andResult:(BaiduMapGeoCodeResult)result;

/**
 *  获取当前location
 *
 *  @return
 */
+ (BMKUserLocation *)obtainCurrentUserLocation;
@end
