//
//  FirstGuideWindow.h
//  MySecondProduct
//
//  Created by chengwen on 16/3/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StartActionBlock)();
@interface FirstGuideWindow : UIWindow

@property (nonatomic, copy) StartActionBlock startApp;

- (instancetype)initWithIsFirstIn:(BOOL)isFirstIn;

- (void)show;
- (void)close;
@end
