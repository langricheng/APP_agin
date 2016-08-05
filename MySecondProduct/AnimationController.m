//
//  AnimationController.m
//  MySecondProduct
//
//  Created by chengwen on 16/2/24.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()

@property (nonatomic, strong) UIView *v_animated;
@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.backgroundColor = [UIColor redColor].CGColor;
    self.view.layer.cornerRadius = 20;
    
    [self initUI];
    [self startAnimation];
}

#pragma mark - init UI
- (void)initUI
{
    self.v_animated = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 200, 60)];
    self.v_animated.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.v_animated];
    
    
}

#pragma mark - action
- (void)startAnimation
{
    //创建一个关键帧动画来改变位置
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2;
    //animation.repeatCount = 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.v_animated.center];
    [path addLineToPoint:CGPointMake(160, 300)];
    
    animation.path = path.CGPath;
    
    //创建一个动画改变透明度
    CABasicAnimation *animation_1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation_1.removedOnCompletion = NO;
    animation_1.fillMode = kCAFillModeForwards;
    animation_1.duration = 2;
   // animation_1.repeatCount = 2;
    animation_1.fromValue = @1;
    animation_1.toValue = @.5;
   
    
    //创建一个动画改变transform
    CABasicAnimation *animation_2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation_2.removedOnCompletion = NO;
    animation_2.fillMode = kCAFillModeForwards;
    animation_2.duration = 2;
   // animation_2.repeatCount = 2;
    animation_2.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation_2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(.1, .1, .1)];
    
    
    [self.v_animated.layer addAnimation:animation forKey:nil];
    [self.v_animated.layer addAnimation:animation_1 forKey:nil];
    [self.v_animated.layer addAnimation:animation_2 forKey:nil];
    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.duration = 2.0;
//    group.animations = @[animation,animation_1,animation_2];
//    group.delegate = self;
//    [self.v_animated.layer addAnimation:group forKey:nil];
    
}
@end
