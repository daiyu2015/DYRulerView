//
//  ViewController.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "ViewController.h"
#import "DYRulerView.h"

@interface ViewController () <DYRulerViewDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    
    NSInteger maxValue = 1100;
    NSInteger minValue = 1000;
    NSInteger spacing = 10;
    
    DYRulerView *rulerView = [[DYRulerView alloc] initWithFrame:CGRectMake(0, 150, deviceWidth, CollectionViewHeight) minValue:minValue maxValue:maxValue spacing:spacing];
    rulerView.delegate = self;
    [self.view addSubview:rulerView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(110, 400, 100, 30)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor blackColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.text = [NSString stringWithFormat:@"%@", @((maxValue+minValue)*.5)];
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RulerViewDelegate
- (void)rulerView:(DYRulerView *)rulerView didChangeScale:(float)scale
{
    self.label.text = [NSString stringWithFormat:@"%.2f", scale];
}

@end
