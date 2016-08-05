//
//  TableViewController.m
//  MySecondProduct
//
//  Created by chengwen on 16/7/4.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "TableViewController.h"
#import "SWTableViewCell.h"
#import "MJRefresh.h"
#import "UINavigationBar+Awesome.h"
#import "UIView+Helpers.h"
#import "MyXibTableViewCell.h"  

#define NAVBAR_CHANGE_POINT 50
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tab_main;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GIF";
    self.tab_main = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight - 50) style:UITableViewStylePlain];
    self.tab_main.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab_main.delegate = self;
    self.tab_main.dataSource = self;
    [self.view addSubview:self.tab_main];
    
    [self addFooterandHeader];
    
     //[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.tab_main];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = CUSTOM_BLUE;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }

}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

#pragma mark - initUI

- (void)addFooterandHeader
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.tab_main.mj_header endRefreshing];
    }];

    header.lastUpdatedTimeLabel.hidden = YES;
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%d", i]];
        [idleImages addObject:image];
    }
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
 
    [header setImages:idleImages forState:MJRefreshStatePulling];
   
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    
    self.tab_main.mj_header = header;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    //xib中，cell要设置重用标记MyXibTableViewCell_id
    MyXibTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyXibTableViewCell_id"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyXibTableViewCell" owner:self options:nil]firstObject];
    }
    
//    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];//滑动删除的第三方
//    if (!cell) {
//        cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
//    
//    cell.textLabel.text = @"哈哈";
//    cell.rightUtilityButtons = [self rightButtons];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc = [[BaseViewController alloc]init];
    vc.title = @"测试title";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}


@end
