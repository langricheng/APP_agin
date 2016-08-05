//
//  MyXibTableViewCell.m
//  MySecondProduct
//
//  Created by chengwen on 16/7/25.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "MyXibTableViewCell.h"


@interface MyXibTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;

@property (weak, nonatomic) IBOutlet UIView *v_seperate;
@property (weak, nonatomic) IBOutlet UIButton *btn_click;
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
@end

@implementation MyXibTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    //当xib中设置了约束，此方法中仍可以改变子视图的大小
    self.img_head.frame = CGRectMake(120, 10, 120, 120);
    
}

@end
