//
//  AdImageItem.m
//  FramesForAllProduct
//
//  Created by chengwen on 16/1/7.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "AdImageItem.h"
#import "AdImageModel.h"
#import "DCWebImageManager.h"

#define textViewHeight 30

@interface AdImageItem ()

@property (nonatomic, strong) AdImageModel *adModel;

@end

@implementation AdImageItem


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0;
        [self customInit];
    }
    
    return self;
}


- (void)customInit
{
    self.img_item = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self addSubview:self.img_item];
    
    self.view_textBackground = [[UIView alloc]init];
    self.view_textBackground.backgroundColor = [UIColor blackColor];
    self.view_textBackground.alpha = .5;
    [self addSubview:self.view_textBackground];
    
    self.lbl_title = [[UILabel alloc]init];
    self.lbl_title.textColor = [UIColor whiteColor];
    self.lbl_title.textAlignment = NSTextAlignmentLeft;
    self.lbl_title.font = [UIFont systemFontOfSize:12];
    [self.view_textBackground addSubview:self.lbl_title];
    
    
}

- (void)refreshViewWithModel:(AdImageModel *)imageModel andHoldImage:(UIImage *)image
{
    if (imageModel.image) {
        self.img_item.image = imageModel.image;
        
       
    }
    else{
       
       self.img_item.image = image;
        
       
    }
    
    
    if (imageModel.title && ![imageModel.title isEqualToString:@""]) {
        self.view_textBackground.hidden = NO;
        self.lbl_title.text = imageModel.title;
    }
    else{
        self.view_textBackground.hidden = YES;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.img_item.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.view_textBackground.frame = CGRectMake(0, self.frame.size.height - textViewHeight, self.frame.size.width,textViewHeight);
    self.lbl_title.frame = CGRectMake(0, 0, 100, self.view_textBackground.frame.size.height);
    
}
@end
