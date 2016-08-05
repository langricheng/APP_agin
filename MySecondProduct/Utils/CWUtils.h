//
//  Utils.h
//  Ce_06
//
//  Created by chengwen on 15/12/25.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CheckVersionBlock)(NSDictionary *);

typedef enum : NSInteger {
    NotReachable = 0,    //没有网络
    ReachableVia2G,      //使用的是2g
    ReachableVia3G,      //使用的是3g
    ReachableVia4G,      //使用的是4g
    ReachableViaLTE,      //使用的是LTE
    ReachableViaWiFi,    //当前使用Wifi网络
    
} NetworkStatus;

@interface CWUtils : NSObject

//************************************************ 系统相关 *******************************************
/** 判断当前IOS版本至少为5.0 */
+ (BOOL)isAtLeastIOS_5_0;

/** 判断当前IOS版本至少为6.0 */
+ (BOOL)isAtLeastIOS_6_0;

/** 判断当前IOS版本至少为7.0 */
+ (BOOL)isAtLeastIOS_7_0;

/** 判断是否为iPad */
+ (BOOL)isIpad;

/** 获取应用的版本号  */
+ (NSString *)getVesionNum;

/** 获取当前网络状态 */
+ (NSInteger)networkingStatesFromStatebar;

/** 检测appstore版本 */
+ (void)checkVersionWithID:(NSString *)appID versionBlock:(CheckVersionBlock)callback;

/** 打开远程推送 */
+ (void)openRemoteNotification;

/** 发送一个本地通知 */
+ (void)postAnlocalNotificationWithStr:(NSString *)note;

/** 跳转到系统设置界面 */
+ (void)jumpSystemSettingsWithType:(NSInteger)type;

/** 判断当前系统语言是不是英文 */
+ (BOOL)currentLanguageIsEn;

/**
 *  打电话
 *
 *  @param tel
 *  @param view
 */
+ (void)maakeAncallPhoneWithTel:(NSString *)tel inView:(UIView *)view;

//********************************************* 工具类 *************************************************

/** 加密 */
+ (NSString *)md5HexDigest:(NSString *)url;

/** 通过一个时间算出星期几 */
+ (NSString *)getSundayWithTime:(NSString *)time;

/** 将图片裁剪成想要的图片 */
+ (UIImage *)getImage:(UIImage *)image withNewSize:(CGSize)size;

/** 通过颜色返回一张图片 */
+ (UIImage *)getAnImageWithSize:(CGSize)size andColor:(UIColor *)color;

/**
 *  给某个tbv添加上啦下啦,用时需要打开屏蔽
 *
 *  @param tbv tbv
 */

+ (void)addFooterAndHeaderForTbv:(UIView *)tbv andHeader:(void (^)())headerAction andFooter:(void (^)())footerAction;
+ (void)addOnlyHeaderForTbv:(UIView *)tbv header:(void(^)())headerAction;

/**
 *  根据date获取固定格式的时间或者时间戳
 *
 * 如果formaterStr传入的是nil则默认返回时间戳
 */
+(NSString*)getTimeWithDate:(NSDate *)date andFormaterStr:(NSString *)formaterStr;

@end
