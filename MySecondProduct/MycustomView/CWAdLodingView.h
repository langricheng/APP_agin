//
//  CWAdLodingView.h
//  HealthCloud
//
//  Created by chengwen on 16/7/1.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CWAdLoadingBlock)();

@interface CWAdLodingView : UIView

+ (void)showWithImageUrl:(NSString *)imageUrl andContenUrl:(NSString *)contentUrl andCloseBlock:(CWAdLoadingBlock)close andTapClickBlock:(CWAdLoadingBlock)tapClick;

+ (void)dismiss;

@end
