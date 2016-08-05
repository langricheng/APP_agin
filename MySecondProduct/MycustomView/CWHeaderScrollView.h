//
//  CWHeaderScrollView.h
//  QCCommunity
//
//  Created by chengwen on 16/5/3.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemBeTouchedBlock)(NSInteger index);
@interface CWHeaderScrollView : UIView

@property (nonatomic, strong) NSArray *arr_titles;
@property (nonatomic, copy)ItemBeTouchedBlock block_itemTouched;
@property (nonatomic, assign) BOOL separated; /**< 是否有分割线  默认没有分割线*/

- (void)setCurrentIndex:(NSInteger)index;

@end
