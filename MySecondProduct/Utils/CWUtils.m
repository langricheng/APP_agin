//
//  Utils.m
//  Ce_06
//
//  Created by chengwen on 15/12/25.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import<CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "CWUtils.h"
#import "NSDate-Utilities.h"
@implementation CWUtils

+ (BOOL)isAtLeastIOS_5_0{
    //    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.f;
    return kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_5_0;
}

+ (BOOL)isAtLeastIOS_6_0{
    //    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.f;
    return kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0;
}

+ (BOOL)isAtLeastIOS_7_0{
    //    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.f;
    return ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) ;
}

+ (BOOL)isIpad{
    //#ifdef UI_USER_INTERFACE_IDIOM
    //	static NSInteger isPad = -1;
    //	if (isPad < 0) {
    //		isPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    //	}
    //	return isPad > 0;
    //#else
    //	return NO;
    //#endif
    static BOOL isIpad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIpad = ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"
                                                          options:NSCaseInsensitiveSearch].location!=NSNotFound);
    });
    return isIpad;
    
    //	static NSInteger isPad = -1;
    //	if (isPad < 0)
    //		isPad = ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"
    //                                                       options:NSCaseInsensitiveSearch].location!=NSNotFound);
    //	return isPad > 0;
}


+ (NSString *)getVesionNum
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSInteger)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    //NSString *stateString = @"wifi";
    NSInteger state = NotReachable;
    
    switch (type) {
        case 0:
            state  = NotReachable;
            break;
            
        case 1:
            state = ReachableVia2G;
            break;
            
        case 2:
            state = ReachableVia3G;
            break;
            
        case 3:
            state = ReachableVia4G;
            break;
            
        case 4:
            state = ReachableViaLTE;
            break;
            
        case 5:
            state = ReachableViaWiFi;
            break;
            
        default:
            break;
    }
    
    return state;
}

+ (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash uppercaseString];
}


+ (void)checkVersionWithID:(NSString *)appID versionBlock:(CheckVersionBlock)callback
{
        // 获取appStore版本号
    appID = @"987953868";
    NSString *path = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",appID];
    
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
        
        // 主线程执行：
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(receiveStatusDic);
        });
        
        
        
    }];
    
    [task resume];

}


+ (NSString *)getSundayWithTime:(NSString *)time
{
    
    NSString *wantStr;
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormater dateFromString:time];
    
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null],NSLocalizedString(@"Sunday", @"星期天"), NSLocalizedString(@"Monday", @"星期一"), NSLocalizedString(@"Tuesday", @"星期二"), NSLocalizedString(@"Wednesday", @"星期三"), NSLocalizedString(@"Thursday", @"星期四"), NSLocalizedString(@"Friday", @"星期五"), NSLocalizedString(@"Saturday", @"星期六"), nil];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
    return wantStr;
}

+ (void)postAnlocalNotificationWithStr:(NSString *)note
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置通知的提醒时间
        NSDate *currentDate   = [NSDate date];
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        notification.fireDate = [currentDate dateByAddingTimeInterval:5.0];
        
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitYear;
        
        // 设置提醒的文字内容
        notification.alertBody   = note;
        //notification.alertAction = @"删除";
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设置应用程序右上角的提醒个数
        notification.applicationIconBadgeNumber = 1;
        
        // 设定通知的userInfo，用来标识该通知
        NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
        //aUserInfo[local_noti_ilece_key] = local_noti_ilece_value;
        notification.userInfo = aUserInfo;
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}


+ (UIImage *)getImage:(UIImage *)image withNewSize:(CGSize)size
{
    UIGraphicsBeginImageContext (size);
    
    [image drawInRect : CGRectMake ( 0 , 0 ,size.width ,size.height )];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    
    UIGraphicsEndImageContext ();
    
    return newImage;
}

+ (void)openRemoteNotification
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    
    //ios适配：新代码:
    if (version >= 8.0) {
        
        //顺带适配ios8状态栏的字体颜色，不写下面这行代码，状态栏颜色就是黑色
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(
                                                                                               UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |
                                                                                               UIUserNotificationTypeSound)
                                                                             categories:nil]];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeNewsstandContentAvailability |
          UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |
          UIRemoteNotificationTypeSound)];
    }
    
}

+ (void)jumpSystemSettingsWithType:(NSInteger)type
{
//    About — prefs:root=General&path=About
//    Accessibility — prefs:root=General&path=ACCESSIBILITY
//    Airplane Mode On — prefs:root=AIRPLANE_MODE
//    Auto-Lock — prefs:root=General&path=AUTOLOCK
//    Brightness — prefs:root=Brightness
//    Bluetooth — prefs:root=General&path=Bluetooth
//    Date & Time — prefs:root=General&path=DATE_AND_TIME
//    FaceTime — prefs:root=FACETIME
//    General — prefs:root=General
//    Keyboard — prefs:root=General&path=Keyboard
//    iCloud — prefs:root=CASTLE
//    iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
//    International — prefs:root=General&path=INTERNATIONAL
//    Location Services — prefs:root=LOCATION_SERVICES
//    Music — prefs:root=MUSIC
//    Music Equalizer — prefs:root=MUSIC&path=EQ
//    Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
//    Network — prefs:root=General&path=Network
//    Nike + iPod — prefs:root=NIKE_PLUS_IPOD
//    Notes — prefs:root=NOTES
//    Notification — prefs:root=NOTIFICATIONS_ID
//    Phone — prefs:root=Phone
//    Photos — prefs:root=Photos
//    Profile — prefs:root=General&path=ManagedConfigurationList
//    Reset — prefs:root=General&path=Reset
//    Safari — prefs:root=Safari
//    Siri — prefs:root=General&path=Assistant
//    Sounds — prefs:root=Sounds
//    Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
//    Store — prefs:root=STORE
//    Twitter — prefs:root=TWITTER
//    Usage — prefs:root=General&path=USAGE
//    VPN — prefs:root=General&path=Network/VPN
//    Wallpaper — prefs:root=Wallpaper
//    Wi-Fi — prefs:root=WIFI
     //在项目中的info.plist中添加 URL types 并设置一项URL Schemes为prefs
    

    NSString *urlStr;
    switch (type) {
        case 0://跳转到设置
           urlStr = UIApplicationOpenSettingsURLString;
            break;
        case 1://跳转到定位服务
            urlStr = @"prefs:root=LOCATION_SERVICES";
            break;
        case 2://跳转到推送设置
            urlStr = @"prefs:root=NOTIFICATIONS_ID";
            break;
        case 3://跳转到facetime
            urlStr = @"prefs:root=FACETIME";
            break;
        case 4://跳转到音乐
            urlStr = @"prefs:root=MUSIC";
            break;
        case 5://跳转到WIFE
            urlStr = @"prefs:root=WIFE";
            break;
        default:
            break;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

+ (void)maakeAncallPhoneWithTel:(NSString *)tel inView:(UIView *)view
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",tel]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [view addSubview:callWebview];
}


+ (UIImage *)getAnImageWithSize:(CGSize)size andColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}


+ (BOOL)currentLanguageIsEn
{
    BOOL isEn = NO;
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        isEn = NO;
    }
    else{
        isEn = YES;
    }
    
    return isEn;
    
}


+(NSString*)getTimeWithDate:(NSDate *)date andFormaterStr:(NSString *)formaterStr
{
    if (formaterStr) {
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:formaterStr];
        NSString *  locationString = [dateformatter stringFromDate:date];
        return locationString;
    }
    else{
        NSTimeInterval timeInteval = [date timeIntervalSince1970];
        
        NSString *timeStr =  [NSString stringWithFormat:@"%f",timeInteval];
        
        return timeStr;
    }
}

+ (void)addFooterAndHeaderForTbv:(UIView *)tbv andHeader:(void (^)())headerAction andFooter:(void (^)())footerAction
{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (headerAction) {
//            headerAction();
//        }
//    }];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        if (footerAction) {
//            footerAction();
//        }
//    }];
    
    //    /** 普通闲置状态 */
    //    MJRefreshStateIdle = 1,
    //    /** 松开就可以进行刷新的状态 */
    //    MJRefreshStatePulling,
    //    /** 正在刷新中的状态 */
    //    MJRefreshStateRefreshing,
    //    /** 即将刷新的状态 */
    //    MJRefreshStateWillRefresh,
    //    /** 所有数据加载完毕，没有更多的数据了 */
    //    MJRefreshStateNoMoreData
    
//    [footer setTitle:NSLocalizedString(@"Pull can load more", nil) forState:MJRefreshStateIdle];
//    [footer setTitle:NSLocalizedString(@"Load more immediate release", nil) forState:MJRefreshStatePulling];
//    [footer setTitle:NSLocalizedString(@"loading...", nil) forState:MJRefreshStateRefreshing];
//    [footer setTitle:NSLocalizedString(@"Have all been loaded", nil) forState:MJRefreshStateNoMoreData];
//    if ([tbv isKindOfClass:[UITableView class]]) {
//        UITableView *table = (UITableView *)tbv;
//        table.mj_header = header;
//        table.mj_footer = footer;
//    }
//    else if([tbv isKindOfClass:[UICollectionView class]]){
//        UICollectionView *cov = (UICollectionView *)tbv;
//        
//        cov.mj_header = header;
//        cov.mj_footer = footer;
//    }
    
}

+ (void)addOnlyHeaderForTbv:(UIView *)tbv header:(void(^)())headerAction
{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (headerAction) {
//            headerAction();
//        }
//    }];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    
//    if ([tbv isKindOfClass:[UITableView class]]) {
//        UITableView *table = (UITableView *)tbv;
//        table.mj_header = header;
//        
//    }
//    else if([tbv isKindOfClass:[UICollectionView class]]){
//        UICollectionView *cov = (UICollectionView *)tbv;
//        
//        cov.mj_header = header;
//    }
    
    
}

@end
