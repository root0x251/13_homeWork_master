//
//  ViewController.m
//  13-HomeWorkAnimationMario
//
//  Created by Slava on 01.01.17.
//  Copyright © 2017 Slava. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *arrayWithRock;    // массив с камнями
@property (strong, nonatomic) NSMutableArray *arrayWithCloud;   // массив с облачками
@property (strong, nonatomic) UIView *earth;
@property (strong, nonatomic) UIView *borderForCercle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayWithRock = [NSMutableArray new];
    self.arrayWithCloud = [NSMutableArray new];
    
//    self.view.backgroundColor = [UIColor blueColor];
    // создаем градиент неба
    CAGradientLayer *gradientSky = [CAGradientLayer new];
    gradientSky.frame = self.view.bounds;
    gradientSky.startPoint = CGPointMake(1, 1);
    gradientSky.endPoint = CGPointZero;
    gradientSky.colors = @[(id)[UIColor colorWithRed:119.0 / 255.0 green:171.0 / 255.0 blue:255.0 / 255.0  alpha:1].CGColor,
                           (id)[UIColor colorWithRed:33 / 255.0 green:106 / 255.0 blue:224 / 255.0 alpha:1].CGColor];
    [self.view.layer insertSublayer:gradientSky atIndex:0];
    
    // границы для облаков
    for (int i = 0; i < 8; i++) {
        self.borderForCercle = [UIView new];
        CGFloat randomX =+ 100;
        CGFloat rangomY =+ 100;
        self.borderForCercle = [self createRect:[UIColor colorWithWhite:0 alpha:0] withX:randomX withY:rangomY withWidth:arc4random_uniform(50) + 100 withHight:arc4random_uniform(50) + 50];
        CGRect rectBorderForCercle = self.borderForCercle.bounds;
        [self.view addSubview:self.borderForCercle];
        // create Cloud
        // подвижная
        for (int j = 0; j < 1; j++) {
            CGFloat randomX = arc4random_uniform(CGRectGetWidth(rectBorderForCercle));
            CGFloat rangomY = arc4random_uniform(CGRectGetHeight(rectBorderForCercle));
            UIView *circle = [UIView new];
            circle = [self createRect:[UIColor redColor] withX:randomX withY:rangomY withWidth:50 withHight:50];
            circle.layer.cornerRadius = 25;
            [self.borderForCercle addSubview:circle];
        }
    }
    

//    UIView *circle = [UIView new];
//    circle = [self createRect:[UIColor redColor] withX:55 withY:222 withWidth:50 withHight:50];
//    circle.layer.cornerRadius = 25;
//    [self.view addSubview:circle];
//    [self moveCloud:circle];
    
    // create earth
    CGRect rectEarth = self.view.bounds;
    self.earth = [UIView new];
    self.earth = [self createRect:[UIColor brownColor] withX:0 withY:0 withWidth:CGRectGetWidth(rectEarth) withHight:60];
    [self.view addSubview:self.earth];
    
    //create shadow
    CGRect rectShadow = self.view.bounds;
    UIView *shadow = [UIView new];
    shadow = [self createRect:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f] withX:0 withY:55 withWidth:CGRectGetWidth(rectShadow) withHight:5];
    [self.earth addSubview:shadow];
    
    // create grass
    CGRect rectGrass = self.view.bounds;
    UIView *grass = [UIView new];
    grass = [self createRect:[UIColor greenColor] withX:0 withY:60 withWidth:CGRectGetWidth(rectGrass) withHight:10];
    [self.earth addSubview:grass];
    
    //createRock
        // подвижная
    for (int i = 0; i < 12; i++) {
        CGFloat randomX = arc4random_uniform(CGRectGetWidth(rectEarth));
        CGFloat randomY = arc4random_uniform(50) + 1;
        CGFloat randomWidth = arc4random_uniform(4) + 2;
        CGFloat randomHight = arc4random_uniform(2) + 2;
        UIView *rock = [UIView new];
        rock = [self createRect:[UIColor blackColor] withX:randomX withY:randomY withWidth:randomWidth withHight:randomHight];
        [self.earth addSubview:rock];
        [self.arrayWithRock addObject:rock];
    }
    for (UIView *myRock in self.arrayWithRock) {
        [self moveRock:myRock];
    }

}

// метод создания квадратов (полей)
- (UIView *) createRect:(UIColor *) colorRect withX:(CGFloat) x withY:(CGFloat) y withWidth:(CGFloat) width withHight:(CGFloat) hight {
    CGRect rect = CGRectMake(x, y, width, hight);
    UIView *createRect = [[UIView alloc] initWithFrame:rect];
    createRect.backgroundColor = colorRect;
//    [self.view addSubview:createRect];
    return createRect;
}


// метод анимации облаков
- (void) moveRock:(UIView *) view  {
    CGFloat x = CGRectGetMinX(view.frame);
    CGFloat y = CGRectGetMinY(view.frame);


    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.center = CGPointMake(x, y);
                     } completion:^(BOOL finished) {
                         NSLog(@"end");
                         __weak UIView *v = view;
                         [self moveRock:v];
                     }];
}

// метод анимации камней



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
