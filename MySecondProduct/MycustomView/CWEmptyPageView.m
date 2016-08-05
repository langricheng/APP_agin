//
//  CWEmptyPageView.m
//  HealthCloud
//
//  Created by chengwen on 16/6/24.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "CWEmptyPageView.h"
#import "UIView+Helpers.h"

@interface CWEmptyPageView ()

@property (nonatomic, strong) UIImageView *img_page;
@property (nonatomic, strong) UILabel *lbl_titel;

@end

@implementation CWEmptyPageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.lbl_titel];
        [self addSubview:self.img_page];
        
    }
    
    return self;
}



#pragma mark - 公共的方法

- (void)showInView:(UIView *)view withType:(NSInteger)type andTitle:(NSString *)title
{
    [view addSubview:self];
    
    [self refreshTitel:title];
    [self refreshImageWithType:type];
    
    [self refreshFrame];
}

- (void)dismiss
{
    [self removeFromSuperview];
}


#pragma amrk - 私有的方法

- (void)refreshImageWithType:(NSInteger)type
{
    if (type == 0) {
        self.img_page.hidden = YES;
    }
    else{
        self.img_page.hidden = NO;
        
        self.img_page.image = [UIImage imageNamed:@""];
    }
    
    
}

-(void)refreshTitel:(NSString *)title
{
    if (title) {
        self.lbl_titel.text = title;
    }
    
}

- (void)refreshFrame
{
    if (self.img_page.hidden) {
        self.lbl_titel.frame = CGRectMake(20, 10, self.frameSizeWidth - 40, 35);
        self.frame = CGRectMake(self.frameOriginX, self.frameOriginY, self.frameSizeWidth, self.lbl_titel.frameSizeHeight + 20);
        
        
    }
    else{
        self.img_page.frame = CGRectMake(self.frameSizeWidth/2- 100/2, 10, 100, 100);
        self.lbl_titel.frame = CGRectMake(20, self.img_page.frameMaxY + 10, self.frameSizeWidth - 40, 35);
        self.frame = CGRectMake(self.frameOriginX, self.frameOriginY, self.frameSizeWidth, self.lbl_titel.frameMaxY + 10);
    }
}


#pragma mark - 懒加载

- (UIImageView *)img_page {
    if (!_img_page) {
        _img_page = [[UIImageView alloc]init];
    }
    
    return _img_page;
}

- (UILabel *)lbl_titel {
    if (!_lbl_titel) {
        _lbl_titel = [[UILabel alloc]init];
        _lbl_titel.textAlignment = NSTextAlignmentCenter;
        _lbl_titel.numberOfLines = 2;
        _lbl_titel.font = [UIFont systemFontOfSize:15];
        _lbl_titel.textColor = [UIColor lightGrayColor];
    }
    
    return _lbl_titel;
}
@end
