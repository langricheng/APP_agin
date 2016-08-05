//
//  AppDelegate.m
//  MySecondProduct
//
//  Created by chengwen on 16/2/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewViewController.h"
#import "AnimationController.h"
#import "MySecondProduct-Swift.h"
#import "ItemScrollViewController.h"
#import "FirstGuideViewController.h"
#import "TableViewController.h"
#import "Peaple.h"
#import <JRDB.h>

#import "CWBaiduMap.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    NSMutableArray *arr_point = [NSMutableArray array];
    //[arr_point addObject:nil];
    
    [self initMainTab];
    
//    self.window.rootViewController = self.drawerVC;
//    [self.window makeKeyAndVisible];
    
    FirstGuideViewController *vc = [[FirstGuideViewController alloc]init];
    vc.startApp = ^(){
        self.window.rootViewController = self.drawerVC;
    };
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    //数据库操作示例
    //[self initDB];
    
    //注册百度地图
    [self initBaiduMap];
    
    //测试运行时
   // [self ce_runtime];
    
    return YES;
}

- (void)ce_runtime
{
   Class class_set = NSClassFromString([AppDelegate class]);
    NSString *class_str = NSStringFromClass([AppDelegate class]);
    
    
}


- (void)initBaiduMap
{
    [CWBaiduMap authorizeBaiduMapWithKey:@"oDUKVWtylBqUInzBil5ecGWDaKnuNXiM" andDegate:nil];
}

- (void)initDB
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"--------------\napp path : %@", path);
    
    //第一步，需要加入的数据库额类需要先注册，不然会崩溃
    [[JRDBMgr shareInstance] registerClazzes:@[
                                               [Peaple class]
                                               ]];
    [JRDBMgr shareInstance].debugMode = NO;
    //更新表,比如添加一个属性
    [Peaple jr_updateTable];
    
    
    //单个插入
    Peaple *p = [[Peaple alloc]init];
    p.name = @"成文";
    p.age = @"1";
    [p jr_save];
    
    [J_Insert(p) exe:nil];
    
    [J_Select([Peaple class]).Recursive(YES).Sync(YES) exe:nil];
    
    
    NSMutableArray *arr_all = [NSMutableArray array];
    for (int i=0; i<100; i++) {
        Peaple *p0 = [[Peaple alloc]init];
        p0.name = @"成文01";
        p0.age = @"2";
        
        if (i%2==0) {
            p0.name = @"成文02";
            p0.age = @"2";
        }
        
        [arr_all addObject:p0];
    }
    
//    [arr_all jr_saveWithComplete:^(BOOL success) {
//        NSLog(@"添加完毕");
//    }];//批量添加
    
    //查询全部
    NSArray *arr = [Peaple jr_findAll];
    
    
    
   // NSArray *arr03 = [Peaple jr_findAllOrderBy:@"_age" isDesc:NO];
    
   //条件查询
    NSArray *condis = @[
                        [JRQueryCondition condition:@"_name = ?" args:@[@"成文"] type:JRQueryConditionTypeAnd],
                        ];
    
  //  NSArray *arr_order = [Peaple jr_findByConditions:condis
//                                       groupBy:nil
//                                       orderBy:@"_age"
//                                         limit:@"limit 5"
//                                        isDesc:YES];
    
    //更新
    Peaple *p_update = [arr firstObject];
    p_update.name = @"成文01";
    [p_update jr_updateColumns:nil];
    
    //删除
    Peaple *p_delete = [Peaple jr_findAll].firstObject;
    [p_delete jr_delete];
    
   // [Peaple jr_deleteAllOnly];//全部删除
    [@[] jr_delete]; //批量删除
    
    
    NSArray *arr02 = [Peaple jr_findAll];
    
   
}
- (void)initMainTab
{
    
    FirstViewViewController *vc0 = [[FirstViewViewController alloc]init];
    vc0.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"好" image:[UIImage imageNamed:@"tab_home_normal"] selectedImage:[UIImage imageNamed:@"tab_home_check"]];
    vc0.leftNavBtnTitle = @"好";
    UINavigationController *navi0 = [[UINavigationController alloc]initWithRootViewController:vc0];
    
    AnimationController *vc1 = [[AnimationController alloc]init];
    vc1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"的" image:[UIImage imageNamed:@"tab_mall_normal"] selectedImage:[UIImage imageNamed:@"tab_mall_check"]];
    vc1.title = @"Animation";
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    
    
    ItemScrollViewController *vc2 = [[ItemScrollViewController alloc]init];
    vc2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"啊" image:[UIImage imageNamed:@"tab_mine_normal"] selectedImage:[UIImage imageNamed:@"tab_mine_check"]];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    
    
    TableViewController *vc3 = [[TableViewController alloc]init];
    vc3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"额" image:[UIImage imageNamed:@"tab_mine_normal"] selectedImage:[UIImage imageNamed:@"tab_mine_check"]];
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    
    
    
    self.tab_main = [[UITabBarController alloc]init];
    self.tab_main.selectedIndex = 0;
    self.tab_main.tabBar.barTintColor = [UIColor whiteColor];//设置bar的颜色
    self.tab_main.viewControllers = @[navi0,navi1,navi2,navi3];
    
    //设置item字的颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    SwiftCtoller *swift = [[SwiftCtoller alloc]init];
    UINavigationController *navi4 = [[UINavigationController alloc]initWithRootViewController:swift];
    
    self.drawerVC = [[MMDrawerController alloc]initWithCenterViewController:self.tab_main leftDrawerViewController:navi4];
    
    
    
    [self.drawerVC setMaximumLeftDrawerWidth:200];//设置抽屉左边间距
    [self.drawerVC setShadowColor:[UIColor redColor]];//设置打开时的毛边颜色
    [self.drawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];//支持滑动手势打开
    [self.drawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];//支持滑动手势关闭
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
