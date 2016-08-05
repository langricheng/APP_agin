//
//  SessionHandler.m
//  MySecondProduct
//
//  Created by chengwen on 16/7/8.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "SessionHandler.h"
#import "NSData+JSON.h"

@implementation SessionHandler

+ (NSDictionary *)configSystemParameters
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    //配置一些基本的参数
    
    
    return params;
}

// get请求
+ (NSURLSessionDataTask *)getRequestWithUrl:(NSString *)url  params:(NSDictionary *)params andSuccess:(SessionSuccessBlock)success andFailurre:(SessionFailureBlock)failure
{
    //发送请求前，监测网络先
    [self checkNetStatus:^(AFNetworkReachabilityStatus state) {
        if (state == AFNetworkReachabilityStatusNotReachable) {
            if (failure) {
                failure(@"AFNetworkReachabilityStatusNotReachable");
            }
        }
    }];
    
    AFHTTPSessionManager *manager = [self ceatAnSessionManager];
    NSString *mainUrl;
    if (url) {
       mainUrl = url;
    }
    else{
       mainUrl = @"";
    }
    
    return [manager GET:mainUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [data JSONOObject];
        
        

        if ([self isRequestSuccessful:jsonDict]) {
            if (success) {
                
                NSDictionary *dataDic = [jsonDict objectForKey:@"data"];
                
               
                success(dataDic);
            }
        }
        else{
            if (failure) {
                failure(jsonDict);
            }
        }
       

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
    
    
}


// post请求
+ (NSURLSessionDataTask *)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params andSuccess:(SessionSuccessBlock)success andFailure:(SessionFailureBlock)failure
{
    //发送请求前，监测网络先
    [self checkNetStatus:^(AFNetworkReachabilityStatus state) {
        if (state == AFNetworkReachabilityStatusNotReachable) {
            if (failure) {
                failure(@"AFNetworkReachabilityStatusNotReachable");
            }
        }
    }];
    
    AFHTTPSessionManager *manager = [self ceatAnSessionManager];
    NSString *mainUrl;
    if (url) {
        mainUrl = url;
    }
    else{
        mainUrl = @"";
    }
    return [manager POST:mainUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [data JSONOObject];
        
        if ([self isRequestSuccessful:jsonDict]) {
            if (success) {
                
                NSDictionary *dataDic = [jsonDict objectForKey:@"data"];
                
                
                success(dataDic);
            }
        }
        else{
            if (failure) {
                failure(jsonDict);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

// 上传图片等
+ (NSURLSessionDataTask *)uploadRequestWithUrl:(NSString *)url params:(NSDictionary *)params andName:(NSString *)name andData:(NSData *)data andFileName:(NSString *)fileName andType:(NSString *)type andSuccess:(SessionSuccessBlock)success andFailure:(SessionFailureBlock)failure
{
    
    //发送请求前，监测网络先
    [self checkNetStatus:^(AFNetworkReachabilityStatus state) {
        if (state == AFNetworkReachabilityStatusNotReachable) {
            if (failure) {
                NSLog(@"没有网络.......................");
                failure(@"AFNetworkReachabilityStatusNotReachable");
            }
        }
    }];
    
    AFHTTPSessionManager *manager = [self ceatAnSessionManager];
    NSString *mainUrl;
    if (url) {
        mainUrl = url;
    }
    else{
        mainUrl = @"";
    }
    return [manager POST:mainUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSString *file = [NSString stringWithFormat:@"file.%@.jpg",fileName];
        NSString *typeName;
        if (!type) {
           typeName = @"image/png";
        }
        else{
            typeName = type;
        }
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",name];
       
        [formData appendPartWithFileData:data name:imageName fileName:file mimeType:typeName];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [data JSONOObject];
        
        if ([self isRequestSuccessful:jsonDict]) {
            if (success) {
                
                NSDictionary *dataDic = [jsonDict objectForKey:@"data"];
                
                
                success(dataDic);
            }
        }
        else{
            if (failure) {
                failure(jsonDict);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (AFHTTPSessionManager *)ceatAnSessionManager
{
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://www.perasst.com:8081"]];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg", nil];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
    [manger.requestSerializer setValue:@"" forHTTPHeaderField:@""];
     //[self.requestSerializer setValue:@"" forKey:@""];
    
    return manger;
}


+ (BOOL)isRequestSuccessful:(NSDictionary * )responseDic
{
    
    
    BOOL isSuccessful=NO;
    
    if([[responseDic objectForKey:@"status"] intValue]==1)
    {
        isSuccessful=YES;
    }
    
    return  isSuccessful;
}

+ (void)checkNetStatus:(SessionNetStatusBlock)netStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        netStatus(status);
    }];
    [manager startMonitoring];
}


@end
