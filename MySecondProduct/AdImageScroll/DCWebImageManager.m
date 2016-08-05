//
//  DCWebImageManager.m
//  DCWebPicScrollView
//
//  Created by dengchen on 15/12/7.
//  Copyright © 2015年 name. All rights reserved.
//

#import "DCWebImageManager.h"
#import "AdImageModel.h"

@interface DCWebImageManager ()


@property (nonatomic,strong) NSMutableDictionary *DownloadImageCount;

@property (nonatomic, assign) NSInteger downLoadCount;

@property (nonatomic, strong) NSArray *arr_imageData;

@end

@implementation DCWebImageManager

+ (instancetype)shareManager {
    
    static DCWebImageManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DCWebImageManager alloc] init];
        
    });
    
    instance.downLoadCount = 0;
    
    return  instance;
}

#pragma mark downLoadImage


- (void)downloadImageWithModel:(AdImageModel *)imageModel{
    

    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:imageModel.imageUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [self downLoadImagefinish:data
                                  model:imageModel
                                error:error
                             response:response];
            
        }] resume];
        
    }else {
            
//        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlSting]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//            
//            [self downLoadImagefinish:data
//                                  url:urlSting
//                                error:connectionError
//                             response:response];
//        }] ;
        
    }
}

- (void)startDownLoadWithImageData:(NSArray *)imageData
{
    self.arr_imageData = imageData;
    
    
    for (AdImageModel *imgModel in self.arr_imageData) {
        
        
        
        [self downloadImageWithModel:imgModel];
    }
    
    
    
}

- (void)downLoadImagefinish:(NSData *)data model:(AdImageModel *)model error:(NSError *)error response:(NSURLResponse *)response{
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (error) {
        [self repeatDownLoadImage:model error:error];
        return ;
    }
    
    if (!image) {
        
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSString *errorData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"错误数据字符串信息:%@\nhttp statusCode(错误代码):%zd",errorData,res.statusCode] code:0 userInfo:nil];
        
        [self repeatDownLoadImage:model error:error];
        return ;
    }
    
   
    model.image = image;
    
    self.downLoadCount++;
    
    if (self.downLoadCount == self.arr_imageData.count) {
       
        
        
        if (self.completeImageDownload) {
            self.completeImageDownload(self.arr_imageData);
        }
    }
 
    
}

- (void)repeatDownLoadImage:(AdImageModel *)imageM error:(NSError *)error{
    
    NSNumber *num = [self.DownloadImageCount objectForKey:imageM.imageUrl];
    NSInteger count = num ? [num integerValue] : 0;
    
    if (self.DownloadImageRepeatCount > count ) {
        
        [self.DownloadImageCount setObject:@(++count) forKey:imageM.imageUrl];
        [self downloadImageWithModel:imageM];
        
    }else {
        
        if (self.downLoadImageError) {
            self.downLoadImageError(error,imageM);
        }
    }
}



#pragma mark lazyload


- (NSMutableDictionary *)DownloadImageCount {
    if (!_DownloadImageCount) {
        _DownloadImageCount = [NSMutableDictionary dictionary];
    }
    return _DownloadImageCount;
}

@end
