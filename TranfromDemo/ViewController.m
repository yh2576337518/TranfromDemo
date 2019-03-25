//
//  ViewController.m
//  TranfromDemo
//
//  Created by 惠上科技 on 2019/3/25.
//  Copyright © 2019 惠上科技. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor redColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 50;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self animationScaleOnceWithView:button];
    [self animationUpDownWithView:button];
}


#pragma mark - 动画

- (void)animationScaleOnceWithView:(UIView *)view
{
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)animationUpDownWithView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint fromPoint = CGPointMake(position.x, position.y);
    CGPoint toPoint = CGPointZero;
    
    uint32_t typeInt = arc4random() % 100;
    CGFloat distanceFloat = 0.0;
    while (distanceFloat == 0) {
        distanceFloat = (6 + (int)(arc4random() % (9 - 7 + 1))) * 100.0 / 101.0;
    }
    if (typeInt % 2 == 0) {
        toPoint = CGPointMake(position.x, position.y - distanceFloat);
    } else {
        toPoint = CGPointMake(position.x, position.y + distanceFloat);
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.autoreverses = YES;
    CGFloat durationFloat = 0.0;
    while (durationFloat == 0.0) {
        durationFloat = 0.9 + (int)(arc4random() % (100 - 70 + 1)) / 31.0;
    }
    [animation setDuration:durationFloat];
    [animation setRepeatCount:MAXFLOAT];
    
    [viewLayer addAnimation:animation forKey:nil];
}


-(void)buttonClick:(UIButton *)button{
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.15, 1.15);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [button removeFromSuperview];
            }];
        }];
    }];
}

@end
