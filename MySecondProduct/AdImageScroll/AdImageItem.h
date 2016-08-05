//
//  AdImageItem.h
//  FramesForAllProduct
//
//  Created by chengwen on 16/1/7.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

/// 用于图片轮播视图的每页的显示item , 可以自定义

#import <UIKit/UIKit.h>

@class AdImageModel;

@interface AdImageItem : UIView


@property (nonatomic, strong) UIImageView *img_item; /**< 图片 */
@property (nonatomic, strong) UILabel *lbl_title;    /**< 标题 */
@property (nonatomic, strong) UIView *view_textBackground; /**< 标题背景 */

/**
 *  @author chengwen
 *
 *  @brief 更新数据时用此方法
 *
 *  @param imageModel 传入的数据模型
 *  @param image      没有加载成功时默认图片
 */
- (void)refreshViewWithModel:(AdImageModel *)imageModel andHoldImage:(UIImage *)image;

/**
 *  @author chengwen
 *
 *  @brief 自定义时重写此方法
 */
- (void)customInit;
@end
