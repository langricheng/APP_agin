//
//  MapViewController.m
//  MySecondProduct
//
//  Created by chengwen on 16/7/27.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "MapViewController.h"
#import "CWSystemMap.h"
#import "CustomAnnotation.h"
#import "CWBaiduMap.h"

@interface MapViewController ()<MKMapViewDelegate,BMKMapViewDelegate>

@property (nonatomic, strong)MKMapView *v_map;
@property (nonatomic, strong)BMKMapView *v_baiduMap;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //[self initMKMap];
    
    //[self initBaiduMap];
    
    
    //这一步定位，非地图定位，可以忽略，两种方式定位，地图和系统定位
//    [CWSystemMap startLocateWithResult:^(CLPlacemark *placeMark, id error) {
//        
//       
//    }];
    
    
    
    //测试内存泄漏
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action_cuont) userInfo:nil repeats:YES];
    NSString *ce_str = [[NSMutableString alloc]init];
}

- (void)action_cuont
{
    NSLog(@"哈哈.....");
}


- (void)initMKMap
{
    self.v_map = [CWSystemMap obtainAnMapWithFrame:CGRectMake(0, 64, APPWidth, APPHeight - 64)];
    self.v_map.delegate = self;
    
    [self.view addSubview:self.v_map];
    
    
   
}


- (void)initBaiduMap
{
    self.v_baiduMap = [CWBaiduMap obtainMapWithFrame:CGRectMake(0, 64, APPWidth, APPHeight - 64)];
    self.v_baiduMap.delegate = self;
    
    [self.view addSubview:self.v_baiduMap];
    
    
    [CWBaiduMap startLocateWithResult:^(BMKReverseGeoCodeResult *reverseResult, id error) {
        // [self.v_baiduMap updateLocationData:[CWBaiduMap obtainCurrentUserLocation]];
        [self.v_baiduMap setCenterCoordinate:reverseResult.location animated:YES];
        
        
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = reverseResult.location;
        annotation.title = reverseResult.address;
        [self.v_baiduMap addAnnotation:annotation];
        
       
        
    }];
}

#pragma mark - BMKMapviewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSArray *array = mapView.annotations;
    for (BMKPointAnnotation *annotation in array) {
        [mapView selectAnnotation:annotation animated:YES];
    }
}

#pragma mark - MKMapVeiwDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
//        MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
//        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    [self.v_map setRegion:region animated:YES];
    
    CustomAnnotation *annotation =[[CustomAnnotation alloc]init];
                annotation.tag = @"1";
                annotation.title = @"哈哈哈";
                annotation.subtitle = @"呵呵";
                annotation.coordinate = userLocation.coordinate;
    
                [self.v_map addAnnotation:annotation];
    
    NSArray *arrView = mapView.annotations;
    
    //这一步是为了显示大头针的标语
    for (CustomAnnotation *annotation in arrView) {
        if ([annotation isKindOfClass:[CustomAnnotation class]]) {
            if ([annotation.tag isEqualToString:@"1"]) {//
                [mapView selectAnnotation:annotation animated:YES];
                
                mapView.showsUserLocation = NO;//一旦显示了位置，就关掉位置更新
            }
        }
       
       
    }
    
}


//- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    
//    
//    if ([annotation isKindOfClass:[CustomAnnotation class]])
//    {
//        
//        static NSString *identifier = @"CustomAnnotation";
//        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        }
//        annotationView.selected = YES;
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，
//        annotationView.draggable = YES;        //设置标注可以拖动
//        annotationView.image = [UIImage imageNamed:@"dropdown_loading_03"];//自定义大头针图片
//        
//        return annotationView;
//    }
//    
//    return nil;
//}

@end
