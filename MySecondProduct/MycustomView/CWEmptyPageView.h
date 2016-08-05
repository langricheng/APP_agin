//
//  CWEmptyPageView.h
//  HealthCloud
//
//  Created by chengwen on 16/6/24.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWEmptyPageView : UIView

- (void)showInView:(UIView *)view withType:(NSInteger)type andTitle:(NSString *)title;

- (void)dismiss;
@end
