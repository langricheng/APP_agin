//
//  GWTimePicker.h
//  BaseProject
//
//  Created by wanggw on 14/11/21.
//  Copyright (c) 2014年 wanggw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Helpers.h"

typedef void(^SelectTimeBlock)(NSString *selectTime);

@interface GWTimePicker : UIView

//show in window上，做了底的挡板
//获取以前的时间
+ (void)showInView:(UIView *)view SelectPreviousTime:(SelectTimeBlock)block;

+ (void)showInView:(UIView *)view andDateStr:(NSString *)date SelectPreviousTime:(SelectTimeBlock)block;

//获取以后的时间
+ (void)showInView:(UIView *)view SelectLaterTime:(SelectTimeBlock)block;

+ (void)showInView:(UIView *)view andDateStr:(NSString *)date SelectLaterTime:(SelectTimeBlock)block;

+ (void)showInView:(UIView *)view andDateStr:(NSString *)date SelectLaterAccurateTime:(SelectTimeBlock)block;

+ (void)showInViewToSelectSepeatorTime:(UIView *)view dataSource:(NSArray *)source SelectLaterAccurateTime:(SelectTimeBlock)block;

@end
