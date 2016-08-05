//
//  UIViewController+ViewCtrollerCategory.m
//  Ce_06
//
//  Created by chengwen on 15/12/30.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "UIViewController+VCCategory.h"

static NSCache *globalCache = nil;

@implementation UIViewController (VCCategory)

+ (NSCache *)shareCache
{
    if(!globalCache)
    {
        globalCache = [[NSCache alloc] init];
    }
    
    return globalCache;
}

- (NSCache *)shareCache  //不安全的共享的数据缓冲，内存警告的时候会自动释放
{
    return [[self class] shareCache];
}

+(UIViewController *)getNowViewController  //获取当前显示的视图控制器
{
      UIViewController *nowController = nil;
//    
//    BYDAppDelegate *delegate = (BYDAppDelegate *)[UIApplication sharedApplication].delegate;
//    //获取异常的类型名
//    UITabBarController *tab = (UITabBarController *)delegate.window.rootViewController;
    
#warning 自己修改了tab原本的值
    UITabBarController *tab = [[UITabBarController alloc]init];
    
    if([tab isKindOfClass:[UITabBarController class]])
    {
        nowController = [[self class] viewControllerFromTabBarController:tab];
    }
    else if([tab respondsToSelector:@selector(viewControllers)])
    {
        for(UINavigationController *nav in [tab viewControllers])
        {
            if([nav isKindOfClass:[UINavigationController class]])
            {
                if(nav.viewControllers.count > 1)
                {
                    nowController = nav.viewControllers.lastObject;
                    break;
                }
            }
        }
    }
    
    if(!nowController)
    {
        if([tab respondsToSelector:@selector(selectedViewController)])
        {
            id selectedVC = tab.selectedViewController;
            if([selectedVC respondsToSelector:@selector(viewControllers)])
            {
                nowController = [selectedVC viewControllers].lastObject;
            }
        }
    }
    
    if(!nowController)
    {
        nowController = tab;
    }
    
    if([nowController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)nowController;
        if(nav.viewControllers.count > 0)
        {
            nowController = nav.viewControllers.lastObject;
        }
    }
    
    return nowController;
}

+ (UIViewController *)viewControllerFromTabBarController:(UITabBarController *)tab
{
    UIViewController *nowController = nil;
    UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
    
    if([nav isKindOfClass:[UINavigationController class]])
    {
        if(nav.viewControllers.count > 0)
        {
            nowController = nav.viewControllers.lastObject;
        }
    }
    else if([nav isKindOfClass:[UITabBarController class]])
    {
        return [[self class] viewControllerFromTabBarController:tab];
    }
    else if([tab isKindOfClass:[UIViewController class]])
    {
        nowController = tab;
    }
    
    return nowController;
}


#pragma mark - ----创建返回键

- (void)addBackItemForSystem{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"返回";
        self.navigationItem.backBarButtonItem = returnButtonItem;
    } else {
        // 设置返回按钮的文本
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"返回"
                                       style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
        
        // 设置返回按钮的背景图片
        UIImage *img = [UIImage imageNamed:@"ic_back_nor"];
        img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:img
                                                          forState:UIControlStateNormal
                                                        barMetrics:UIBarMetricsDefault];
        // 设置文本与图片的偏移量
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0)
                                                             forBarMetrics:UIBarMetricsDefault];
        // 设置文本的属性
        NSDictionary *attributes = @{UITextAttributeFont:[UIFont systemFontOfSize:16],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]};
        [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }  
    
}

- (void)addDefaultBackButton:(NSString *)btnTitle //添加自动的返回按钮
{
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(5, 0, 5, 43);//上，左，下，右
    UIImage *imgBack = [UIImage imageNamed:@"Default"];
    UIImage *imgBackFocus = [UIImage imageNamed:@"Default"];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithSize:CGSizeMake(54, 30)];
    backButton.frame = CGRectMake(0, 0, 54, 30);
    [backButton setImage:imgBack forState:UIControlStateNormal];
    [backButton setImage:imgBackFocus forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = imageInsets;
    
    if(btnTitle){
        UIEdgeInsets titleInsets = UIEdgeInsetsMake(3, -13, 3, 0);//上，左，下，右
        backButton.titleEdgeInsets = titleInsets;
        [backButton setTitle:btnTitle forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
    
    //滑动返回
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //self.navigationItem.backBarButtonItem.style = UIBarButtonItemStyleDone;
}

- (void)addDefaultBackButton:(NSString *)btnTitle target:(id)target action:(SEL)action //添加自动的返回按钮
{
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(5, 0, 5, 43);//上，左，下，右
    UIImage *imgBack = [UIImage imageNamed:@"icon_nav_goBack"];
    UIImage *imgBackFocus = [UIImage imageNamed:@"icon_nav_goBack"];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithSize:CGSizeMake(54, 30)];
    backButton.frame = CGRectMake(0, 0, 54, 30);
    [backButton setImage:imgBack forState:UIControlStateNormal];
    [backButton setImage:imgBackFocus forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = imageInsets;
    
    if(btnTitle){
        UIEdgeInsets titleInsets = UIEdgeInsetsMake(3, -13, 3, 0);//上，左，下，右
        backButton.titleEdgeInsets = titleInsets;
        [backButton setTitle:btnTitle forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
}

- (void)addDefaultBackButtonWithBackImage:(NSString *)image target:(id)target action:(SEL)action  //添加自动的返回按钮
{
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(3, 0, 3, 43);//上，左，下，右
    UIImage *imgBack = [UIImage imageNamed:image];
    UIImage *imgBackFocus = [UIImage imageNamed:image];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithSize:CGSizeMake(54, 30)];
    backButton.frame = CGRectMake(0, 0, 58, 30);    [backButton setImage:imgBack forState:UIControlStateNormal];
    [backButton setImage:imgBackFocus forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = imageInsets;
    
    
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem.style = UIBarButtonItemStyleDone;
}

#pragma mark - ----创建通用按钮

- (UIButton *)createCommenButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:18.0];//Font(18.0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"icon_button_blue_bg_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:@"icon_button_blue_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateHighlighted];
    
    return button;
}

#pragma mark - ----去掉搜索框背景

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 * @author wanggw, 15-05-04 17:05:07
 *
 * @brief  去掉搜索框的SearchBarShadow
 *
 * @param view
 */
- (void)_findAndHideSearchBarShadowInView:(UIView *)view
{
    NSString *usc = @"_";
    NSString *sb = @"UISearchBar";
    NSString *sv = @"ShadowView";
    NSString *s = [[usc stringByAppendingString:sb] stringByAppendingString:sv];
    
    for (UIView *v in view.subviews)
    {
        if ([v isKindOfClass:NSClassFromString(s)]) {
            v.alpha = 0.0f;
        }
        [self _findAndHideSearchBarShadowInView:v];
    }
}

@end
