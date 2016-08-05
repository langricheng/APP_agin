//
//  CWHeaderScrollView.m
//  QCCommunity
//
//  Created by chengwen on 16/5/3.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "CWHeaderScrollView.h"

#define width_item (APPWidth/4)
#define tag_btnItem  10019

@interface CWHeaderScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll_main;

@end

@implementation CWHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initMainView];
    }
    
    return self;
}

- (void)initMainView
{
    self.scroll_main = [[UIScrollView alloc]initWithFrame:self.bounds];
    //self.scroll_main.userInteractionEnabled = NO;
    self.scroll_main.delegate = self;
    self.scroll_main.showsHorizontalScrollIndicator = NO;
    self.scroll_main.showsVerticalScrollIndicator = NO;
    
    
    [self addSubview:self.scroll_main];
    

}

- (void)setArr_titles:(NSArray *)arr_titles
{
    _arr_titles = arr_titles;
    
    for (UIView *subView in self.scroll_main.subviews) {
        
            [subView removeFromSuperview];
    }
    
    
    [self initsubButtonsWithTittles:arr_titles];
    
    //[self initsubLabelsWithTittles:arr_titles];
    
}

- (void)initsubButtonsWithTittles:(NSArray *)arr_titles
{
     NSInteger index = arr_titles.count;
    
    CGFloat itemWidth = width_item;
    for (int i=0; i<index; i++) {
        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subBtn.titleLabel.font = Font(14);
        subBtn.tag = tag_btnItem + i;
        [subBtn setTitle:[arr_titles objectAtIndex:i] forState:UIControlStateNormal];
        [subBtn setTitleColor:CUSTOM_GRAY forState:UIControlStateNormal];
        [subBtn setTitleColor:CUSTOM_BLUE forState:UIControlStateSelected];
        subBtn.selected = NO;
        
        subBtn.frame = CGRectMake(i*itemWidth, 0, itemWidth, self.frame.size.height);
        
        [subBtn addTarget:self action:@selector(action_beClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scroll_main addSubview:subBtn];
        
        if (self.separated) {
            if (i != index - 1) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(itemWidth+itemWidth*i, 10, 1, self.frame.size.height - 20)];
                line.backgroundColor = CUSTOM_SEPARATORLINE;
                [self.scroll_main addSubview:line];
            }
        }
        
        
    }

     self.scroll_main.contentSize = CGSizeMake(index*width_item, 0);
}

#pragma mark - action
- (void)action_beClick:(UIButton *)sender
{
    for (UIView *view in self.scroll_main.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)view;
            subBtn.selected = NO;
        }
    }
    sender.selected = YES;
    NSInteger index = sender.tag - tag_btnItem;
    if (self.block_itemTouched) {
        self.block_itemTouched(index);
    }
    
    //以下是为了每次点击保证item位置与边缘的距离
    if (index == self.arr_titles.count - 1) {
        return;
    }
    if (index == 0) {
        return;
    }
    
    CGPoint point = sender.center;
    CGPoint transformPoint = CGPointMake(point.x - self.scroll_main.contentOffset.x, point.y);
    
    CGFloat maxFloadt = self.frame.size.width - width_item - width_item/2;
    CGFloat minFloat = width_item/2 + width_item;
    
    CGFloat contoffsetX = self.scroll_main.contentOffset.x;
    if (transformPoint.x > maxFloadt) {
        self.scroll_main.contentOffset = CGPointMake(contoffsetX + (transformPoint.x - maxFloadt), self.scroll_main.contentOffset.y);
    }
    if (transformPoint.x < minFloat) {
         self.scroll_main.contentOffset = CGPointMake(contoffsetX - (minFloat - transformPoint.x), self.scroll_main.contentOffset.y);
    }
    NSLog(@"%@",NSStringFromCGPoint(transformPoint));
}

- (void)action_tapGesture:(UITapGestureRecognizer *)tap
{
   
}

- (void)setCurrentIndex:(NSInteger)index
{
    for (UIView *view in self.scroll_main.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)view;
            subBtn.selected = NO;
        }
    }

    
    UIButton *btn = [self.scroll_main viewWithTag:index+tag_btnItem];
    btn.selected = YES;
    
    if (self.block_itemTouched) {
        self.block_itemTouched(index);
    }

    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


#pragma mark - touchesBegan

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.scroll_main.userInteractionEnabled = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.superview];
    
    
    
    NSLog(@"%@",NSStringFromCGPoint(point));
    
   
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.scroll_main.userInteractionEnabled = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
