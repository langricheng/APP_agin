//
//  BaseViewController.m
//  BYDFans
//
//  Created by Tentinet on 15-12-23.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+VCCategory.h"
#import "NSArray+Helper.h"


#define kMaskingKey         @"maskingKey"        //蒙版
#define kIsShowMaskKey      @"isShowMaskkey"     //是否显示蒙版页

@interface BaseViewController ()
{
    NSInteger      maskingCount;   //
    NSInteger      maskTapCount;   //在msking上tap手势点击次数
}

@end

@implementation BaseViewController

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    NSString *tTitle = self.navigationController.title;
    NSLog(@"%@",tTitle);
    
    
    if(!self.navigationItem.leftBarButtonItem && self.navigationController.viewControllers.count > 1 ) {
        if(![tTitle isEqualToString:self.title]){//区分是不是一级控制器
            //自定义的返回按钮
            //[self addDefaultBackButton:self.leftNavBtnTitle];
        }
    }
    
    //设置系统返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated:)];
    [self.navigationController.navigationBar setTintColor:WhiteColor];//这个保证系统返回按钮为白色,不然和导航栏颜色一样

    //得到当前的视图控制器，这里存在一个问题，如果是登陆的视图控制器，我们需要忽略
    if (self.navigationController.viewControllers.count >= 1) {
        //UIViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 1];
//        if (![vc isKindOfClass:[BYD_LoginRegistViewController class]]) {
//            [GlobalCommen setCurrentViewController:vc];
//            //NSLog(@"_______当前视图控制器_______%@", [vc class]);
//        }
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置这个会排除主视图向下偏移64个单位
    //self.navigationController.navigationBar.translucent = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self enanblePopGobackGesture];
    
    //------ios7进入后台导航栏变黑解决方案
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];//RGB_A(247);
    
    //------
    self.navigationController.navigationBar.barTintColor = CUSTOM_BLUE;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:WhiteColor,NSFontAttributeName:Font(18)}];
    
    //去掉导航栏的边界黑线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}


- (void)enanblePopGobackGesture
{
    //------滑动返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //自定义了返回键就要设置代理为nil
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - 登录相关



- (void)goViewControllerWith:(NSString *)vcStr;
{
    
    if (vcStr.length > 0) {
        BaseViewController *myclass = [[NSClassFromString([NSString stringWithFormat:@"%@",vcStr]) alloc] init];
        myclass.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myclass animated:YES];
    }
    
  
}

#pragma mark - 蒙版相关

- (BOOL)shouldShowMasking
{
     return [[NSUserDefaults standardUserDefaults] boolForKey:kIsShowMaskKey];
}

- (void)showMaskingViewForClass:(Class)clazz maskImages:(NSArray *)images frames:(NSArray *)frames
{
    if (![self shouldShowMasking]) return;
    if (images == nil || images.count < 1) return;
    if (frames == nil || frames.count < 1) return;
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kMaskingKey];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:[mutDic objectForKey:NSStringFromClass(clazz)]];
    if ([[dataDic valueForKey:@"showMask"] boolValue]) {
        [dataDic setValue:@(NO) forKey:@"showMask"];
        [mutDic setValue:dataDic forKey:NSStringFromClass(clazz)];
        
        [[NSUserDefaults standardUserDefaults] setObject:mutDic forKey:kMaskingKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSInteger count = [[dataDic valueForKey:@"maskCount"] integerValue];
        maskingCount = count;
        maskTapCount = 0;
        [self setupMaskingView:images frames:frames];
    }
}

//展示蒙版
- (void)setupMaskingView:(NSArray *)images frames:(NSArray *)frames
{
    UIView *alphaWind = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    alphaWind.tag = 1000000;
    alphaWind.alpha = 0.8;
    alphaWind.backgroundColor = [UIColor blackColor];
    
    UIView *maskWind = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    maskWind.tag = 1000001;
    maskWind.backgroundColor = [UIColor clearColor];
    maskWind.userInteractionEnabled = YES;
    
    for (NSInteger i = 0; i < images.count; i++) {
        
        UIImage *imag = [UIImage imageNamed:[images safeGetIndexObj:i]];
        NSDictionary *frameDic = frames[i];
        CGRect frame = CGRectMake([frameDic[@"orgx"] floatValue], [frameDic[@"orgy"] floatValue], [frameDic[@"width"] floatValue], [frameDic[@"height"] floatValue]);
        UIImageView *imagView = [[UIImageView alloc] initWithFrame:frame];
        imagView.image = imag;
        imagView.tag = i + 1;
        if (i == 0) {
            imagView.hidden = NO;
        }
        else{
            imagView.hidden = YES;
        }
        [maskWind addSubview:imagView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForMasking:)];
    [maskWind addGestureRecognizer:tap];
    
    [[UIApplication sharedApplication].keyWindow addSubview:alphaWind];
    
    [[UIApplication sharedApplication].keyWindow addSubview:maskWind];
}


- (void)tapForMasking:(UIGestureRecognizer *)gesture
{
    maskTapCount = maskTapCount + 1;
    if (maskTapCount == maskingCount) {
        for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
            //if ([view isKindOfClass:[UIView class]] && ![view isKindOfClass:[AKTabBarView class]]) {
            //    [view removeFromSuperview];
            //}
            if (view.tag == 1000000 || view.tag == 1000001) {
                [view removeFromSuperview];
            }
        }
    }
    else{
        NSArray *views = [[UIApplication sharedApplication].keyWindow subviews];
        UIView *maskWind = [views lastObject];
        for (NSInteger i = 1; i <= maskingCount; i ++) {
            [maskWind viewWithTag:maskTapCount].hidden = YES;
            [maskWind viewWithTag:maskTapCount + 1].hidden = NO;
        }
    }
}


@end
