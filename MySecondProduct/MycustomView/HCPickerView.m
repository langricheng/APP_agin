//
//  HCPickerView.m
//  HealthCloud
//
//  Created by chengwen on 16/5/26.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "HCPickerView.h"
#import "NSArray+Helper.h"

#define headerViewHeight 40
#define containerViewHeight 202

@interface HCPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *arr_titles;

@property (nonatomic, strong) UIPickerView *piker;
@property (nonatomic, strong) UIImageView *view_container;
@property (nonatomic, strong) UIView *view_head;
@property (nonatomic, strong) UIButton *btn_cancle;
@property (nonatomic, strong) UIButton *btn_conmit;

@property (nonatomic, strong) NSDictionary *dic_selected;

@property (nonatomic, copy) PickerSelectedBlock block_selected;

@end

@implementation HCPickerView



- (instancetype)initWithData:(NSArray *)titles
{
    self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    if (self) {
        self.arr_titles = titles;
        
        [self initMainView];
    }
    
    return self;
}


#pragma mark - initUI

- (void)initMainView
{
    self.view_container = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, containerViewHeight)];
    self.view_container.userInteractionEnabled = YES;
    
    [self addSubview:self.view_container];
    
    
    self.view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, headerViewHeight)];
    self.view_head.backgroundColor = [UIColor clearColor];
    [self.view_container addSubview:self.view_head];

    
    //取消按钮
    self.btn_cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_cancle.frame = CGRectMake(15, 0, 60, self.view_head.frame.size.height);
    [self.btn_cancle setTitle:NSLocalizedString(@"cancel", @"取消") forState:UIControlStateNormal];
    [self.btn_cancle setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btn_cancle.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_cancle addTarget:self action:@selector(action_cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.view_head addSubview:self.btn_cancle];
    
    //确定按钮
    self.btn_conmit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_conmit.frame = CGRectMake(self.view_container.frame.size.width - 75, 0, 60, self.view_head.frame.size.height);
    [self.btn_conmit setTitle:NSLocalizedString(@"determine", @"确定") forState:UIControlStateNormal];
    [self.btn_conmit setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.btn_conmit.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_conmit addTarget:self action:@selector(action_comit) forControlEvents:UIControlEventTouchUpInside];
    [self.view_head addSubview:self.btn_conmit];
    
    
    self.piker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, headerViewHeight,self.frame.size.width, containerViewHeight - headerViewHeight)];
    self.piker.backgroundColor = [UIColor clearColor];
    self.piker.dataSource = self;
    self.piker.delegate = self;
    [self.view_container addSubview:self.piker];
    
}


#pragma mark - 公共方法


- (void)refreshViewWith:(NSArray *)data
{
   
    self.arr_titles = data;
    
    
    [self.piker reloadAllComponents];
    
    
}

- (void)showWithBlock:(PickerSelectedBlock)selecedBlock
{
    UIWindow *keyWindow = [[UIApplication sharedApplication].keyWindow.subviews firstObject];
    
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.view_container.frame = CGRectMake(0, self.frame.size.height - containerViewHeight, self.frame.size.width, containerViewHeight);
    }];
    
    
    self.block_selected = selecedBlock;
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.view_container.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, containerViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}


- (void)setcontainerColor:(UIColor *)color
{
    self.view_container.backgroundColor = color;
}

- (void)setImageForBackGround:(UIImage *)image
{
     self.view_container.image = image;
}


#pragma mark - 内部方法
- (void)action_cancle
{
    
    [self hide];
}

- (void)action_comit
{
    if (self.dic_selected) {
        
        if (self.block_selected) {
            self.block_selected(self.dic_selected);
        }
    }
    
    [self hide];
   
}

#pragma mark - delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arr_titles.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *str = [self.arr_titles safeGetIndexObj:row];
    NSString *key = [NSString stringWithFormat:@"%d",row +1];
    self.dic_selected = @{key:str};
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arr_titles safeGetIndexObj:row];
}


@end
