//
//  GWProgressHUD.h
//  GWTestProj
//
//  Created by wanggw on 15/1/9.
//  Copyright (c) 2015年 wanggw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Helpers.h"

@interface GWProgressHUD : UIView

+ (void)showInView:(UIView *)uiview;

+ (void)showInView:(UIView *)uiview tipString:(NSString *)tipString;

+ (void)dismiss;

+ (BOOL)isVisible;

@end
