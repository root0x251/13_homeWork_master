//
//  ViewController.m
//  13-HomeWorkAnimationMario
//
//  Created by Slava on 01.01.17.
//  Copyright © 2017 Slava. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *marioMutableArray;
@property (weak, nonatomic) UIImageView *imgCloud;
@property (weak, nonatomic) UIImageView *imgEarth;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCloud];
    [self createMario];
    [self createRect];

    
    // создаем градиент неба
    CAGradientLayer *gradientSky = [CAGradientLayer new];
    gradientSky.frame = self.view.bounds;
    gradientSky.startPoint = CGPointMake(1, 1);
    gradientSky.endPoint = CGPointZero;
    gradientSky.colors = @[(id)[UIColor colorWithRed:119.0 / 255.0 green:171.0 / 255.0 blue:255.0 / 255.0  alpha:1].CGColor,
                           (id)[UIColor colorWithRed:33 / 255.0 green:106 / 255.0 blue:224 / 255.0 alpha:1].CGColor];
    [self.view.layer insertSublayer:gradientSky atIndex:0];


}
// create plaer
- (void) createMario {
    self.marioMutableArray = [NSMutableArray new];
    // создаем массив с изображениями
    CGFloat x = (CGRectGetHeight(self.view.bounds) / 2) + 100;
    CGFloat y = CGRectGetMinY(self.view.bounds) + 35;
    UIImageView *marioView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
    [self.view addSubview:marioView];
    NSInteger nameOfImg = 11;
    do {
        NSString *imgName = [NSString stringWithFormat:@"%d.png", nameOfImg--];   // добовляем img в массив
        UIImage *marioImg = [UIImage imageNamed:imgName];
        [self.marioMutableArray addObject:marioImg];
    } while (nameOfImg > 0);
    marioView.animationImages = self.marioMutableArray;
    marioView.transform = CGAffineTransformMakeRotation(M_PI);  // какого-то хера оно перевернуло мне мзображение
    marioView.animationDuration = .8;
    [marioView startAnimating]; // анимируем img
    
}

- (void) createCloud {
    // создаем облака
    CGFloat randCloudWidth = arc4random_uniform(100) + 50;
    CGFloat randCloudHeight = arc4random_uniform(40) + 50;
    CGFloat randX = CGRectGetMinX(self.view.bounds);
    CGFloat randY = arc4random_uniform(CGRectGetMidY(self.view.bounds));
    UIImageView *cloudImgView = [[UIImageView alloc] initWithFrame:CGRectMake(randX, randY, randCloudWidth, randCloudHeight)];
    [self.view addSubview:cloudImgView];
    UIImage *cloudImg = [UIImage imageNamed:@"cloud2.png"];
    NSArray *arrayCloud = @[cloudImg];
    cloudImgView.animationImages = arrayCloud;
    cloudImgView.transform = CGAffineTransformMakeRotation(M_PI);   // какого-то хера оно перевернуло мне мзображение
    [cloudImgView startAnimating];
    self.imgCloud = cloudImgView;
    [self moveCloud:self.imgCloud];
}

- (void) createRect {
    // создаем землю
    CGFloat x = CGRectGetMinX(self.view.frame) - 300;
    CGFloat y = CGRectGetMinY(self.view.frame);
    CGFloat rectSize = CGRectGetHeight(self.view.frame) / 8;
    for (int i = 0; i < self.view.bounds.size.height; i++) {
        UIImageView *earthImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, rectSize, rectSize)];
        [self.view addSubview:earthImgView];
        UIImage *earthImg = [UIImage imageNamed:@"rock"];
        NSArray *arrayRock = @[earthImg];
        earthImgView.animationImages = arrayRock;
        earthImgView.transform = CGAffineTransformMakeRotation(M_PI);   // какого-то хера оно перевернуло мне мзображение
        [earthImgView startAnimating];
        x += 30;
        [self moveRock:earthImgView];
    }
    
}

// метод анимации камня
- (void) moveRock:(UIView *) view {
//    CGFloat x = CGRectGetMinX(view.frame);
//    CGFloat y = CGRectGetMinY(view.frame);
    CGFloat x = CGRectGetMinX(view.frame) + 80;
    CGFloat y = 20;
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         view.center = CGPointMake(x, y);
                     } completion:^(BOOL finished) {
                         NSLog(@"end");
                         __weak UIView *v = view;
                         [self moveRock:v];
                     }];
}

// метод анимации облаков
- (void) moveCloud:(UIView *) cloudView {
//    CGFloat x = CGRectGetMaxX(cloudView.frame);
//    CGFloat y = CGRectGetWidth(cloudView.frame);
//    [UIView animateWithDuration:5
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         cloudView.center = CGPointMake(x, y);
//                     } completion:^(BOOL finished) {
//                         NSLog(@"end");
//                         __weak UIView *v = cloudView;
//                         [self moveRock:v];
//                     }];
CGFloat x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(cloudView.bounds);
CGFloat y = CGRectGetMidY(cloudView.frame);
[UIView animateWithDuration:10
                      delay:0
                    options:UIViewAnimationOptionCurveLinear
                 animations:^{
                     cloudView.center = CGPointMake(x, y);
                 } completion:^(BOOL finished) {
                     NSLog(@"end");
                     __weak UIView *v = cloudView;
                     [self moveRock:v];
                 }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
