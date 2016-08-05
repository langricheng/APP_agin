//
//  BaseModel.h
//  Ce_06
//
//  Created by chengwen on 15/12/29.
//  Copyright © 2015年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//@property (nonatomic, assign) ModelStatus modelStatus; /**< 请求的状态变量：枚举类型 1：正在请求 2：请求失败 3：请求成功 */
//@property (nonatomic) CGSize messageSize; /**< 暂时我也不知道有毛用 */

//从字典给属性赋值
- (void)setObjectAndKeysWithDict:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;

@end
