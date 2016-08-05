//
//  FirstGuideViewController.h
//  MySecondProduct
//
//  Created by chengwen on 16/3/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StartActionBlock)();

@interface FirstGuideViewController : UIViewController


@property (nonatomic, copy) StartActionBlock startApp;
@end
