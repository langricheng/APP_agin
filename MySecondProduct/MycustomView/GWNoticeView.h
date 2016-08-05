//
//  GWNoticeView.h
//  GWTestProj
//
//  Created by wanggw on 15/2/4.
//  Copyright (c) 2015年 wanggw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Helpers.h"

@interface GWNoticeView : UIView

+ (void)successNoticeInView:(UIView *)view title:(NSString *)title;
+ (void)successNoticeInWindow:(UIWindow *)window title:(NSString *)title;
+ (void)errorNoticeInView:(UIView *)view title:(NSString *)title;
+ (void)errorNoticeInWindow:(UIWindow *)window title:(NSString *)title;
+ (void)errorNoticeInView:(UIView *)view title:(NSString *)title top:(BOOL)isTop;

@end
