//
//  DrawerController.h
//  MySecondProduct
//
//  Created by chengwen on 16/3/14.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerController : UIViewController


- (instancetype)initWithLeftVC:(UIViewController *)leftVC centerVC:(UIViewController *)centerVC rightVC:(UIViewController *)rightVC;

- (void)openLetfVC;
- (void)openRightVC;
- (void)close;
@end
