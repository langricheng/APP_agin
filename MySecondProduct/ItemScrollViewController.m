//
//  ItemScrollViewController.m
//  MySecondProduct
//
//  Created by chengwen on 16/3/18.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "ItemScrollViewController.h"
#import "MorePageScrolView.h"
#import "MediaCtroller.h"
#import "JSOCViewController.h"

@interface ItemScrollViewController ()

@property (nonatomic, strong) MorePageScrolView *scroll_main;
@property (nonatomic, strong) UIView *v_header;
@property (nonatomic, strong) NSArray *arr_pages;

@end

@implementation ItemScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self initHeader];
    [self initMainScroll];
    [self initNavi];
}

#pragma mark - initUI

- (void)initHeader
{
    self.v_header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 50)];
    self.v_header.backgroundColor = [UIColor lightGrayColor];
    
    for (int i=0; i<2; i++) {
        UIButton *item  = [[UIButton alloc]initWithFrame:CGRectMake(i*160, 0, 160, 50)];
        item.tag = i+9999;
        [item setTitle:@"item" forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [item addTarget:self action:@selector(action_itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.v_header addSubview:item];
    }
    
    [self.view addSubview:self.v_header];
}


- (void)initNavi
{
    UIButton *btn_right = [CWUIFactory creatButtonWithTitle:@"JS-OC" customImage:nil selecteImage:nil highlightedImage:nil titleColor:WhiteColor font:Font(14)];
    btn_right.frame = CGRectMake(0, 0, 60, 20);
    [btn_right addTarget:self action:@selector(action_JS_OC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn_right];
}

- (void)initMainScroll
{
    self.scroll_main = [[MorePageScrolView alloc]initWithFrame:CGRectMake(0, 114, 320, self.view.frame.size.height - 64 - 50 - 50) andVCArr:self.arr_pages andParentVC:self];
    self.scroll_main.hasScrolled = ^(NSInteger index){
        NSLog(@"%ld",index);
    };
    
    [self.view addSubview:self.scroll_main];
    
}

#pragma mark - action
- (void)action_itemClick:(UIButton *)sender
{
    NSInteger tag = sender.tag - 9999;
    [self.scroll_main scrollContentOffset:tag*self.scroll_main.bounds.size.width];
}


- (void)action_JS_OC
{
    JSOCViewController *jsocVc = [[JSOCViewController alloc]init];
    [self.navigationController pushViewController:jsocVc animated:YES];
}

- (NSArray *)arr_pages
{
    if (!_arr_pages) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        MediaCtroller *media = [[MediaCtroller alloc]init];
        
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor grayColor];
        
        [arr addObject:media];
        [arr addObject:vc];
        
        _arr_pages = [arr mutableCopy];
    }
    return _arr_pages;
}

@end
