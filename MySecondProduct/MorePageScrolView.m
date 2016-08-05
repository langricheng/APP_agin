//
//  MorePageScrolView.m
//  MySecondProduct
//
//  Created by chengwen on 16/3/17.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "MorePageScrolView.h"

@interface MorePageScrolView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll_main;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, strong) NSArray *arr_childVC;
@property (nonatomic, assign) NSInteger i_currentIndex;

@end

@implementation MorePageScrolView

- (instancetype)initWithFrame:(CGRect)frame andVCArr:(NSArray<UIViewController *> *)array andParentVC:(UIViewController *)parentVC
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.parentVC = parentVC;
        self.arr_childVC = array;
        self.i_currentIndex = 0;
    
        [self initMainScroll];
        [self addChildVC];
    }
    return self;
    
}

- (void)initMainScroll
{
    self.scroll_main = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.scroll_main.bounces = NO;
    self.scroll_main.pagingEnabled = YES;
    self.scroll_main.delegate = self;
    [self addSubview:self.scroll_main];
    
    self.scroll_main.showsHorizontalScrollIndicator = NO;
    self.scroll_main.showsVerticalScrollIndicator = NO;
    self.scroll_main.contentSize = CGSizeMake(self.frame.size.width*(self.arr_childVC.count), 0);
    self.parentVC.automaticallyAdjustsScrollViewInsets = NO;
   
    
    UIViewController *vc = [self.arr_childVC firstObject];
    vc.view.frame = self.bounds;
    [self.scroll_main addSubview:vc.view];
}

- (void)addChildVC
{
    for (UIViewController *vc in self.arr_childVC) {
        [self.parentVC addChildViewController:vc];
    
        vc.view.frame = self.bounds;
        
    }
    
   
}

#pragma mark - action 公有

- (void)scrollContentOffset:(CGFloat)offset
{
    [self.scroll_main setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma mark - UIScrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger index = scrollView.contentOffset.x/self.frame.size.width + 1;//加一是为了保证一滑动就会添加控制器
    
   
    if (index > self.arr_childVC.count - 1) {
        //可能会超过最多数
        return;
    }
        UIViewController *vc = [self.arr_childVC objectAtIndex:index];
        if (vc.view.superview) {
            return;
        }
        vc.view.frame = CGRectMake(index*self.scroll_main.bounds.size.width, 0, self.scroll_main.bounds.size.width, self.scroll_main.bounds.size.height);
        [self.scroll_main addSubview:vc.view];
    
   
    
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.i_currentIndex = scrollView.contentOffset.x/self.frame.size.width;
    if (self.hasScrolled) {
        self.hasScrolled(self.i_currentIndex);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.i_currentIndex = scrollView.contentOffset.x/self.frame.size.width;
    if (self.hasScrolled) {
        self.hasScrolled(self.i_currentIndex);
    }
}
@end
