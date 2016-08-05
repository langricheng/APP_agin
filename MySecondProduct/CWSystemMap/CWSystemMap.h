//
//  CWSystemMap.h
//  MySecondProduct
//
//  Created by chengwen on 16/7/27.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


typedef void(^CWSystemMapLocateResult)(CLPlacemark *placeMark , id error);

@interface CWSystemMap : NSObject

+ (CWSystemMap *)shareInstance;

//=====================================  定位相关 ============================
/** 开始定位 ,其实地图本身就有定位功能*/
+ (void)startLocateWithResult:(CWSystemMapLocateResult)result;

/** 通过坐标获取地理位置信息 */
+ (void)cw_obtainRegionInfoWithLocation:(CLLocationCoordinate2D)coordinate andResult:(CWSystemMapLocateResult)locateResult;

/** 获取当前的位置 */
+ (CLLocation *)obtainCurrentLocationRegion;

//=================================== 地图相关 =================================

+ (MKMapView *)obtainAnMapWithFrame:(CGRect)frame;

@end
