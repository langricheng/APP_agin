//
//  MorePageScrolView.h
//  MySecondProduct
//
//  Created by chengwen on 16/3/17.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScrollAnimatedBlock)(NSInteger);
@interface MorePageScrolView : UIView

@property (nonatomic, copy) ScrollAnimatedBlock hasScrolled;

- (instancetype)initWithFrame:(CGRect)frame andVCArr:(NSArray<UIViewController *> *)array andParentVC:(UIViewController *)parentVC;

- (void)scrollContentOffset:(CGFloat)offset;

@end
