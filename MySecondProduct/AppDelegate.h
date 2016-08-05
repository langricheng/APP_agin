//
//  AppDelegate.h
//  MySecondProduct
//
//  Created by chengwen on 16/2/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tab_main;
@property (nonatomic, strong) MMDrawerController *drawerVC;
@end

