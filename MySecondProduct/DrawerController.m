//
//  DrawerController.m
//  MySecondProduct
//
//  Created by chengwen on 16/3/14.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "DrawerController.h"

#define leftMargin 100
#define rightMargin 120

typedef enum {
    VCOpenStateLeft = 0,
    VCOpenStateCenter,
    VCOpenStateRight
}VCOpenState;

@interface DrawerController ()

@property (nonatomic, strong) UIViewController *letfVC;
@property (nonatomic, strong) UIViewController *centerVC;
@property (nonatomic, strong) UIViewController *rightVC;
@property (nonatomic, assign) VCOpenState openState;

@end


@implementation DrawerController

- (instancetype)initWithLeftVC:(UIViewController *)leftVC centerVC:(UIViewController *)centerVC rightVC:(UIViewController *)rightVC{
    self = [super init];
    if (self) {
        self.letfVC = leftVC;
        self.centerVC = centerVC;
        self.rightVC = rightVC;
        
        self.letfVC?[self addChildViewController:self.letfVC]:nil;
        self.rightVC?[self addChildViewController:self.rightVC]:nil;
        self.centerVC?[self addChildViewController:self.centerVC]:nil;
        
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.centerVC.view];
    self.centerVC.view.frame = self.view.bounds;
    self.openState = VCOpenStateCenter;

    
}

- (void)openLetfVC
{
   
    self.openState = VCOpenStateLeft;
    
    [self transitionFromViewController:self.centerVC toViewController:self.letfVC duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:nil completion:^(BOOL finished) {
        
    }];
    
//                               
//                                [self.rightVC.view removeFromSuperview];
//                                self.centerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//                                
//                                
//                                
//                                [self.view addSubview:self.letfVC.view];
//                                self.letfVC.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
//                                [UIView animateWithDuration:.5 animations:^{
//                                    self.centerVC.view.frame = CGRectMake(leftMargin, 0, self.view.frame.size.width, self.view.frame.size.height);
//                                    self.letfVC.view.frame = CGRectMake(-(self.view.frame.size.width - leftMargin), 0, self.view.frame.size.width, self.view.frame.size.height);
//                                    
//                                } completion:nil];

    
    
    
}

- (void)openRightVC
{
    self.openState = VCOpenStateRight;
    
    [self.letfVC.view removeFromSuperview];
    self.centerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.rightVC.view];
    self.rightVC.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:.5 animations:^{
        self.centerVC.view.frame = CGRectMake(-rightMargin, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.rightVC.view.frame = CGRectMake(self.view.frame.size.width - rightMargin, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:nil];
}

- (void)close
{
    
    [UIView animateWithDuration:.5 animations:^{
        switch (self.openState) {
            case VCOpenStateLeft:
                self.letfVC.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
                break;
            case VCOpenStateCenter:
                
                break;
            case VCOpenStateRight:
                self.rightVC.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
                break;
            default:
                break;
        }
        self.centerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
            [self.letfVC.view removeFromSuperview];
            [self.rightVC.view removeFromSuperview];
        
        
    }];
    
   

}

@end
