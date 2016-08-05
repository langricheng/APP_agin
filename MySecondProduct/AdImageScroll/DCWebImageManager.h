//
//  DCWebImageManager.h
//  DCWebPicScrollView
//
//  Created by dengchen on 15/12/7.
//  Copyright © 2015年 name. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdImageModel;

typedef void(^CompleteImageDownload)(NSArray *data);
typedef void(^FaildDownloadAnImage)(NSError *error,NSString *imageUrl);

@interface DCWebImageManager : NSObject

//只需要设置这2个就行了

//下载失败重复下载次数,默认不重复,
@property (nonatomic,assign) NSUInteger DownloadImageRepeatCount;

/**图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
error错误信息
url下载失败的imageurl
 */
@property (nonatomic,copy) void(^downLoadImageError)(NSError *error,AdImageModel *image);

/**
   全部图片加载完毕后调用此block
 */
@property (nonatomic, copy) void(^completeImageDownload)(NSArray *data);


+ (instancetype)shareManager;


- (void)downloadImageWithModel:(AdImageModel *)imageModel;

/** 开始加载图片 
   imageData 必须装的是AdImageModel类 
 
 */
- (void)startDownLoadWithImageData:(NSArray *)imageData;


@end
