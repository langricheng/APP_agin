//
//  AdImageScrollView.h
//  FramesForAllProduct
//
//  Created by chengwen on 16/1/7.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

// 循环播放视图 ，具体用法参见AdViewController.m

#import <UIKit/UIKit.h>

typedef void(^AdImageItemBeTouchedBlock)(NSArray *, NSInteger);

/**  pageControl 的位置显示方式 */
typedef NS_ENUM(NSInteger, AdImageScrollPageControlType){
    
    AdImageScrollPageControlTypeNone = 0, //不显示分页标志
    AdImageScrollPageControlTypeLeft,     //分页标志在左边
    AdImageScrollPageControlTypeCenter,   //分页标志在中间
    AdImageScrollPageControlTypeRight     //分页标志在右边
    
};

@interface AdImageScrollView : UIView

/**< 图片被点击会调用该block */
@property (nonatomic,copy) AdImageItemBeTouchedBlock  imageBeTouchedBlock;//index从0开始

/**< 是否需要自动滑动 */
@property (nonatomic, assign) BOOL isAanimated;

/**< 自动滑动的时间间隔 如果是自动滑动，这个必须设置 */
@property (nonatomic, assign) CGFloat timeDelay;

/**
 *  @author chengwen
 *
 *  @brief 初始化方法
 *
 *  @param frame    大小
 *  @param classStr 自定义的显示格局，默认传入@“AdImageItem”
 *  @param pageType 分页标志显示方式
 *  @param image    如果加载不出来，显示的默认图片
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame itemClassStr:(NSString *)classStr pageControlType:(AdImageScrollPageControlType)pageType placeHolden:(UIImage *)image;

/**
 *  @author chengwen
 *
 *  @brief 更新图片数据的方法
 *
 *  @param imageData 传入的数据数组 , 里面的数据模型是AdImageModel
 */
- (void)refreshViewWithData:(NSArray *)imageData;

@end
