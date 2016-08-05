//
//  BaseTableViewCell.h
//  Ce_06
//
//  Created by chengwen on 15/12/29.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;

@interface BaseTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *customSeparatorLine;      //分割线：自定义控制是否显示及显示的位置
@property (nonatomic, assign) CGFloat customRetract;            //分割线自定义缩进量
@property (nonatomic, assign) BOOL isRetract;                   //分割线是否缩进
@property (nonatomic, assign) BOOL isEditing;                   //tableView是否处在编辑状态

@property (strong, nonatomic) UIImageView *arrowImageV;         //箭头：  自定义控制是否显示及显示的位置

- (void)customInit;
- (void)refreshCellWith:(BaseModel *)model;

@end

