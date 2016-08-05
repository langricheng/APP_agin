//
//  BaseTableViewCell.m
//  Ce_06
//
//  Created by chengwen on 15/12/29.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UIView+Helpers.h"
#import "BaseModel.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self customInit];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //从xib或者storyboard加载完毕就会调用
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect lineFrame;
    if (self.isRetract) {
        lineFrame = CGRectMake(self.customRetract, self.contentView.frame.size.height - 0.5, [[UIScreen mainScreen]bounds].size.width, 0.5);
    }else{
        lineFrame = CGRectMake(0, self.contentView.frame.size.height - 0.5, [[UIScreen mainScreen]bounds].size.width, 0.5);
    }
    self.customSeparatorLine.frame = lineFrame;
    
    
    self.arrowImageV.frameOrigin = CGPointMake(self.contentView.frameSizeWidth - 30/2 - 18/2, self.contentView.frameSizeHeight/2 - 32/4);
}

- (void)refreshCellWith:(BaseModel *)model
{
    
}

- (void)customInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.customSeparatorLine = [[UIView alloc] init];
    self.customSeparatorLine.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [self.contentView addSubview:self.customSeparatorLine];
    
    //默认灰色箭头, 隐藏属性为YES
    
    self.arrowImageV = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width - 30/2 - 18/2, 140/4 - 32/4, 18/2, 32/2)];
    self.arrowImageV.hidden = YES;
    [self.contentView addSubview:self.arrowImageV];
    
}

@end
