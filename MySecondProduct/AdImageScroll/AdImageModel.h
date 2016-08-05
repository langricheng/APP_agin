//
//  AdImageModel.h
//  FramesForAllProduct
//
//  Created by chengwen on 16/1/7.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdImageModel : NSObject

@property (nonatomic, strong) NSString *title;          /**< 图片标题          */
@property (nonatomic, strong) NSString *subject;        /**< 图片的描述性文字   */

@property (nonatomic, strong) NSString *imageUrl;       /**< 网络图片的url     */

@property (nonatomic, strong) UIImage *image;           /**< 已经加载好的图片 */

@end
