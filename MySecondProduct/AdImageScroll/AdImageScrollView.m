//
//  AdImageScrollView.m
//  FramesForAllProduct
//
//  Created by chengwen on 16/1/7.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "AdImageScrollView.h"
#import "AdImageItem.h"
#import "AdImageModel.h"
#import "DCWebImageManager.h"

#define theWidth (self.frame.size.width)
#define theHeight (self.frame.size.height)
#define pageControlSize 60

@interface AdImageScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll_bg;
@property (nonatomic, strong) AdImageItem *item_left;
@property (nonatomic, strong) AdImageItem *item_center;
@property (nonatomic, strong) AdImageItem *item_right;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImage *holdenImage;

@property (nonatomic, strong) NSArray *arr_imageData;
@property (nonatomic, strong) NSString *str_itemClass;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger i_centerIndex;
@property (nonatomic, assign) NSInteger i_leftIndex;
@property (nonatomic, assign) NSInteger i_rightIndex;

@property (nonatomic, assign) AdImageScrollPageControlType pageType;


@end

@implementation AdImageScrollView

-(void)dealloc {
    [self removeTimer];
}

- (id)initWithFrame:(CGRect)frame itemClassStr:(NSString *)classStr pageControlType:(AdImageScrollPageControlType)pageType placeHolden:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        if (classStr) {
            self.str_itemClass = classStr;
        }
        else{
            self.str_itemClass = @"AdImageItem";
        }
        
        
        self.pageType = pageType;
        
        self.holdenImage = image;
        
        [self initScroll];
        [self initPageControl];
        [self addIamges];
        
        [self bringSubviewToFront:self.pageControl];
        
    }
    return self;

}

#pragma mark - initUI


- (void)setIsAanimated:(BOOL)isAanimated
{
    _isAanimated = isAanimated;
    
    if (self.timeDelay > 0 && isAanimated) {
        self.timer = [NSTimer timerWithTimeInterval:self.timeDelay target:self selector:@selector(timerScroll) userInfo:nil repeats:YES];
    }
    
}

- (void)initScroll
{
    self.scroll_bg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, theWidth,theHeight)];
    self.scroll_bg.backgroundColor = [UIColor blueColor];
     self.scroll_bg.contentSize = CGSizeMake(3*theWidth, theHeight);
    //self.scroll_bg.backgroundColor = [UIColor clearColor];
    self.scroll_bg.bounces = NO;
    self.scroll_bg.showsHorizontalScrollIndicator = NO;
    self.scroll_bg.showsVerticalScrollIndicator = NO;
    self.scroll_bg.pagingEnabled = YES;
    self.scroll_bg.delegate = self;
   
    
    [self addSubview:self.scroll_bg];
    
}

- (void)initPageControl
{
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
   
    
    [self addSubview:self.pageControl];
    
    
    switch (self.pageType) {
        case AdImageScrollPageControlTypeLeft:
            self.pageControl.hidden = NO;
            self.pageControl.frame = CGRectMake(0, theHeight - 7, pageControlSize, 7);
            break;
        case AdImageScrollPageControlTypeCenter:
            self.pageControl.hidden = NO;
            self.pageControl.frame = CGRectMake((theWidth - pageControlSize)/2, theHeight - 40, pageControlSize, 7);
            break;
        case AdImageScrollPageControlTypeRight:
            self.pageControl.hidden = NO;
            self.pageControl.frame = CGRectMake(theWidth - pageControlSize, theHeight - 7, pageControlSize, 7);
            break;
        case AdImageScrollPageControlTypeNone:
            self.pageControl.hidden = YES;
            
            break;
        default:
            break;
    }
    
    
}

- (void)addIamges
{
    self.item_left = [[NSClassFromString(self.str_itemClass) alloc] initWithFrame:CGRectMake(0, 0,theWidth, theHeight)];
    self.item_center = [[NSClassFromString(self.str_itemClass) alloc] initWithFrame:CGRectMake(theWidth, 0,theWidth, theHeight)];
    self.item_right = [[NSClassFromString(self.str_itemClass) alloc] initWithFrame:CGRectMake(theWidth * 2, 0,theWidth, theHeight)];
    
    self.item_center.userInteractionEnabled = YES;
    [self.item_center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [self.scroll_bg addSubview:self.item_left];
    [self.scroll_bg addSubview:self.item_center];
    [self.scroll_bg addSubview:self.item_right];
    
    
    
}

#pragma mark - action

- (void)refreshViewWithData:(NSArray *)imageData
{
    self.arr_imageData = imageData;
    self.pageControl.numberOfPages = self.arr_imageData.count;
    self.pageControl.currentPage = 0;
    
    if (self.arr_imageData.count >1) {
        self.i_centerIndex = 0;
        self.i_leftIndex = self.arr_imageData.count - 1;
        self.i_rightIndex = 1;
    }
    else if (self.arr_imageData.count == 1){
        self.i_centerIndex = 0;
        self.i_leftIndex = 0;
        self.i_rightIndex = 0;
    }
    
    
    DCWebImageManager *mgr = [DCWebImageManager shareManager];
    mgr.completeImageDownload = ^(NSArray *data){
        self.arr_imageData = data;
       
        
        [self refreshItems];

    };
    [mgr startDownLoadWithImageData:self.arr_imageData];
    [self refreshItems];
    
    if (self.isAanimated) {
        [self startTimer];
    }
   
}

- (void)imageViewDidTap {
    if (self.imageBeTouchedBlock) {
        self.imageBeTouchedBlock(self.arr_imageData, self.i_centerIndex);
    }
}

- (void)startTimer {
    
    if (self.isAanimated) {
        self.timer = [NSTimer timerWithTimeInterval:self.timeDelay target:self selector:@selector(timerScroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    else{
        
    }
    
    
}


- (void)removeTimer {
    if (self.timer == nil) return;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerScroll
{
    [self.scroll_bg setContentOffset:CGPointMake(self.scroll_bg.contentOffset.x + theWidth, 0) animated:YES];
}

- (void)changeImageWithOffset:(CGFloat)offsetX {
    
    if (offsetX >= theWidth * 2) {
        self.i_centerIndex++;
        
        if (self.i_centerIndex == self.arr_imageData.count-1) {
            self.i_leftIndex = self.i_centerIndex - 1;
            self.i_rightIndex = 0;
            
           
            
        }else if (self.i_centerIndex == self.arr_imageData.count) {
            
            self.i_centerIndex = 0;
            self.i_leftIndex = self.arr_imageData.count - 1;
            self.i_rightIndex = 1;
          
            
        }else {
            self.i_leftIndex = self.i_centerIndex - 1;
            self.i_rightIndex = self.i_centerIndex + 1;
            
          
        }
        
        self.pageControl.currentPage = self.i_centerIndex;
        [self refreshItems];
      
        
    }
    
    if (offsetX <= 0) {
        self.i_centerIndex--;
        
        if (self.i_centerIndex == 0) {
            self.i_leftIndex = self.arr_imageData.count - 1;
            self.i_rightIndex = 1;
          
            
        }else if (self.i_centerIndex == -1) {
            self.i_centerIndex = self.arr_imageData.count - 1;
            self.i_leftIndex = self.i_centerIndex - 1;
            self.i_rightIndex = 0;
            
        }else {
            self.i_leftIndex = self.i_centerIndex - 1;
            self.i_rightIndex = self.i_centerIndex + 1;
            
          
        }
        
        self.pageControl.currentPage = self.i_centerIndex;
        [self refreshItems];
       
    }
   
   
    
}

- (void)refreshItems{
    
    [self.item_left refreshViewWithModel:self.arr_imageData[self.i_leftIndex] andHoldImage:self.holdenImage];
    [self.item_center refreshViewWithModel:self.arr_imageData[self.i_centerIndex] andHoldImage:self.holdenImage];
    [self.item_right refreshViewWithModel:self.arr_imageData[self.i_rightIndex] andHoldImage:self.holdenImage];
    
    if (self.arr_imageData.count == 1) {
        self.pageControl.hidden = YES;
        [self.scroll_bg setContentOffset:CGPointMake(0, 0)];
    }
    else{
        self.pageControl.hidden = NO;
        [self.scroll_bg setContentOffset:CGPointMake(theWidth, 0)];
    }
    
}



#pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isAanimated) {
        [self startTimer];
    }
    else{
        
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
   
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    [self changeImageWithOffset:offsetX];
    
     //NSLog(@"%f,%f",scrollView.contentSize.width,scrollView.contentSize.height);
}



@end
