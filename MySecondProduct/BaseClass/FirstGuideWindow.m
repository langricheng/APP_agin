//
//  FirstGuideWindow.m
//  MySecondProduct
//
//  Created by chengwen on 16/3/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "FirstGuideWindow.h"

@interface FirstGuideWindow ()

@property (nonatomic, assign) BOOL isFistIn;
@property (nonatomic, strong) UIScrollView *scroll_main;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *btn_start;
@property (nonatomic, strong) NSArray *arr_image;

@end

@implementation FirstGuideWindow

- (instancetype)initWithIsFirstIn:(BOOL)isFirstIn
{
    self = [super init];
    if (self) {
        self.isFistIn = isFirstIn;
        
         self.windowLevel = UIWindowLevelStatusBar;
        [self setBackgroundColor:[UIColor clearColor]];
        self.frame = [UIScreen mainScreen].bounds;
        
        [self initMainView];
        
    }
    return self;
}

#pragma mark - initUI

- (void)initMainView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    self.scroll_main = [[UIScrollView alloc]initWithFrame:rect];
    self.scroll_main.contentSize = CGSizeMake(self.frame.size.width*self.arr_image.count, 0);
    self.scroll_main.showsHorizontalScrollIndicator = NO;
    self.scroll_main.showsVerticalScrollIndicator = NO;
    self.scroll_main.pagingEnabled = YES;
    self.scroll_main.bounces = NO;
    
    [self addSubview:self.scroll_main];
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(40, rect.size.height - 40, rect.size.width - 80, 60)];
    self.pageControl.numberOfPages = self.arr_image.count;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    [self addSubview:self.pageControl];
    
    self.btn_start = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_start  setTitle:@"开始体验" forState:UIControlStateNormal];
    [self.btn_start setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.btn_start.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btn_start.layer.borderWidth = 1.0;
    
    [self.btn_start addTarget:self action:@selector(action_start) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn_start];
    
}
#pragma mark - action

- (void)close
{
    
}

- (void)show{
    [self makeKeyAndVisible];
}

- (void)action_start
{
    if (self.startApp) {
        self.startApp();
    }
}

- (NSArray*)arr_image
{
    if (!_arr_image) {
        UIImage *image0 = [UIImage imageNamed:@"welcome1"];
        UIImage *image1 = [UIImage imageNamed:@"welcome2"];
        _arr_image = @[image0,image1];
    }
    return _arr_image;
}
@end
