//
//  HCPickerView.h
//  HealthCloud
//
//  Created by chengwen on 16/5/26.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerSelectedBlock)(NSDictionary *);
@interface HCPickerView : UIView

- (instancetype)initWithData:(NSArray *)titles;

/**
 *  @author chengwen
 *
 *  @brief 刷新数据用的方法
 *
 *  @param data 传入的数据数组，里面的model必须为CityModel,或者继承自它
 */
- (void)refreshViewWith:(NSArray *)data;

/**
 *  @author chengwen
 *
 *  @brief 显示pagePicker 用此方法显示
 */
- (void)showWithBlock:(PickerSelectedBlock)selecedBlock;

/**
 *  @author chengwen
 *
 *  @brief 设置背景颜色
 *
 *  @param color 颜色
 */
- (void)setcontainerColor:(UIColor *)color;

- (void)setImageForBackGround:(UIImage *)image;

@end
