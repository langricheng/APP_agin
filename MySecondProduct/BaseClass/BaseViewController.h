//
//  BaseViewController.h
//  BYDFans
//  基类视图控制器，所有视图控制器都要继承这个类
//  Created by Tentinet on 15-12-23.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * @author wanggw, 15-07-15 11:07:55
 *
 * @brief  系统的视图基类
 */
@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *leftNavBtnTitle;    /**< 左边导航栏返回按钮的标题 */


/** 跳转到其他视图 */
- (void)goViewControllerWith:(NSString *)vcStr;




/** 让滑动返回可以使用 */
- (void)enanblePopGobackGesture;


/** 我的：设置里面有个是否打开蒙版页 */
- (BOOL)shouldShowMasking;

/**
 * @author wanggw, 15-07-15 11:07:49
 *
 * @brief  显示蒙版的方法
 *
 * @param clazz  那个类
 * @param images 蒙版图片数组
 * @param frames 蒙版frame数组
 */
- (void)showMaskingViewForClass:(Class)clazz maskImages:(NSArray *)images frames:(NSArray *)frames;

@end
