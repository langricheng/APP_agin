//
//  GWAlertView.h
//  BYDFans
//
//  Created by wanggw on 15/1/27.
//  Copyright (c) 2015年 Tentinet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Helpers.h"

typedef void(^CancelBlock)();
typedef void(^SureBlock)();

typedef enum {
    GWAlertNoe = 1,
    GWAlertOnlyMessage,
    GWAlertSureCancel
} GWAlertType;

@interface GWAlertView : UIWindow

@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) SureBlock sureBlock;

- (void)show;

//常规提示视图
+ (GWAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;

//只有确定按钮的提示视图
+ (GWAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message AlertType:(GWAlertType)alertType;

//能够定制确定按钮标题的常规视图
+ (GWAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message SureButtonTitle:(NSString *)buttonTitle;

@end
