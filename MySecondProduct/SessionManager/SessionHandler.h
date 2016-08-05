//
//  SessionHandler.h
//  MySecondProduct
//
//  Created by chengwen on 16/7/8.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef void(^SessionSuccessBlock)(id result);
typedef void(^SessionFailureBlock)(id error);
typedef void(^SessionNetStatusBlock)(AFNetworkReachabilityStatus state);

@interface SessionHandler : NSObject


 //配置一些基本的参数
+ (NSDictionary *)configSystemParameters;

// get请求
+ (NSURLSessionDataTask *)getRequestWithUrl:(NSString *)url params:(NSDictionary *)params andSuccess:(SessionSuccessBlock)success andFailurre:(SessionFailureBlock)failure;


// post请求
+ (NSURLSessionDataTask *)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params andSuccess:(SessionSuccessBlock)success andFailure:(SessionFailureBlock)failure;

// 上传图片等
+ (NSURLSessionDataTask *)uploadRequestWithUrl:(NSString *)url params:(NSDictionary *)params  andName:(NSString *)name andData:(NSData *)data andFileName:(NSString *)fileName andType:(NSString *)type andSuccess:(SessionSuccessBlock)success andFailure:(SessionFailureBlock)failure;


//监测网络
+ (void)checkNetStatus:(SessionNetStatusBlock)netSate;


@end
