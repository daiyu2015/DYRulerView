//
//  ViewController.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "ViewController.h"
#import "DYRulerView.h"

@interface ViewController () <DYRulerViewDelegate, DYRulerViewDataSource>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) NSArray *majorScales;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *majorScales = [NSMutableArray array];
    for (NSInteger index=0; index<300; index+=10) {
        [majorScales addObject:@(index)];
    }
    self.majorScales = majorScales;

    DYRulerView *rulerView = [[DYRulerView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 140)];
    rulerView.delegate = self;
    rulerView.dataSource = self;
    [self.view addSubview:rulerView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(110, 400, 100, 30)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor blackColor];
    self.label.textColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DYRulerViewDataSource
- (CGFloat)heightForRulerView:(DYRulerView *)rulerView
{
    return 140.0f;
}

- (NSArray *)majorScalesInRulerView:(DYRulerView *)rulerView
{
    return self.majorScales;
}

- (NSInteger)numberOfMinorScaleInRulerView:(DYRulerView *)rulerView
{
    return 10;
}

- (CGFloat)spacingBetweenMinorScaleInRulerView:(DYRulerView *)rulerView
{
    return 20;
}

#pragma mark - DYRulerViewDelegate
- (CGSize)rulerView:(DYRulerView *)rulerView sizeForPointerImageView:(UIImageView *)pointerImageView
{
    return CGSizeMake(8, 60);
}

- (UIFont *)fontForMajorScaleInRulerView:(DYRulerView *)rulerView
{
    return [UIFont boldSystemFontOfSize:20];
}

- (BOOL)rulerViewShouldShowMinorScale:(DYRulerView *)rulerView
{
    return YES;
}

- (CGSize)sizeForMinorScaleViewInRulerView:(DYRulerView *)rulerView
{
    return CGSizeMake(2, 20);
}

- (void)rulerView:(DYRulerView *)rulerView didChangeScaleWithMajorScale:(int)majorScale minorScale:(int)minorScale
{
    self.label.text = [NSString stringWithFormat:@"%@/%@", @(majorScale), @(minorScale)];
}

@end
