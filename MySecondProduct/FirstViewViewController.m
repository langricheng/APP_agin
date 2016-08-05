//
//  FirstViewViewController.m
//  MySecondProduct
//
//  Created by chengwen on 16/2/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "FirstViewViewController.h"
#import "CWUtils.h"
#import "AdImageScrollView.h"
#import "AdImageModel.h"
#import "MediaCtroller.h"
#import "MySecondProduct-Swift.h"
#import "AnimationController.h"
#import "AppDelegate.h"
#import "DrawerController.h"
#import "MapViewController.h"


@interface FirstViewViewController ()
@property (nonatomic, strong) AdImageScrollView *adImageView;
@property (nonatomic, strong) NSMutableArray *arr_adData;
@end

@implementation FirstViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"black";
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //btn.selected = NO;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"呵" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
  
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapBtn addTarget:self action:@selector(action_map) forControlEvents:UIControlEventTouchUpInside];
    [mapBtn setTitle:@"地图" forState:UIControlStateNormal];
    [mapBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    mapBtn.frame = CGRectMake(0, 0, 60, 20);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:mapBtn];
    
    
    
    
    
    
    
    [self initADScroll];
    //Masonry 实例
    [self initAview];
    

    
}

#pragma mark - Aciotn
- (void)click:(UIButton *)sender
{
    if (sender.selected) {
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.drawerVC closeDrawerAnimated:YES completion:nil];

    }
    else{
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.drawerVC openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
    }
    
    sender.selected = !sender.selected;
}


- (void)action_map
{
    MapViewController *mapVc = [[MapViewController alloc]init];
    mapVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapVc animated:YES];
    
}


#pragma mark - initUI

- (void)initADScroll
{
    self.adImageView = [[AdImageScrollView alloc]initWithFrame:CGRectMake(0, 100, 320, 200) itemClassStr:nil pageControlType:AdImageScrollPageControlTypeCenter placeHolden:nil];
    //[UIImage imageNamed:@"111.jpg"]
    
    self.adImageView.isAanimated = YES;
    self.adImageView.timeDelay = 2.0;
    
    [self.view addSubview:self.adImageView];
    
    [self.adImageView refreshViewWithData:self.arr_adData];
    
    
}

- (void)initAview{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = YellowColor;
    [self.view addSubview:v];
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(self.adImageView).offset(10);
        make.left.equalTo(self.view).offset(30);
        
        
    }];
    
}

#pragma mark - configData
- (NSArray *)arr_adData
{
    if (!_arr_adData) {
        _arr_adData = [NSMutableArray array];
        
        
        for (int i=0; i< 3; i++) {
            AdImageModel *m = [[AdImageModel alloc]init];
            switch (i) {
                case 0:
                {
                    //NSBundle *bu = [NSBundle mainBundle];
                    // NSString *filepTH = [bu pathForResource:@"111" ofType:@"jpg"];
                    m.title = @"哈哈";
                    // m.imageFile = filepTH;
                    m.imageUrl = @"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg";
                }
                    break;
                case 1:
                {
                    //                    NSBundle *bu = [NSBundle mainBundle];
                    //                    NSString *filepTH = [bu pathForResource:@"222" ofType:@"jpg"];
                    
                    m.title = @"呵呵";
                    // m.imageFile = filepTH;
                    m.imageUrl =  @"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png";
                    
                    break;
                }
                case 2:
                {
                    //                    NSBundle *bu = [NSBundle mainBundle];
                    //                    NSString *filepTH = [bu pathForResource:@"333" ofType:@"jpg"];
                    
                    m.title = @"呼呼";
                    // m.imageFile = filepTH;
                    m.imageUrl =  @"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg";
                    break;
                }
                default:
                    break;
            }
            
            [_arr_adData addObject:m];
        }
        
    }
    return _arr_adData;
}


@end
