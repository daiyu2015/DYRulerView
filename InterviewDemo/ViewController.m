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
@property (nonatomic, strong) DYRulerView *rulerView;
@property (nonatomic) NSInteger minorScaleCount;

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
    
    CGFloat deviceWidth = [UIScreen mainScreen].bounds.size.width;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"体重", @"生日"]];
    segmentedControl.frame = CGRectMake((deviceWidth-200)/2, 80, 200, 34);
    segmentedControl.tintColor = [UIColor blackColor];
    segmentedControl.selectedSegmentIndex = 0;
    self.minorScaleCount = 10;
    [segmentedControl addTarget:self action:@selector(changeRuler:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

    self.rulerView = [[DYRulerView alloc] initWithFrame:CGRectMake(0, 150, deviceWidth, 140)];
    self.rulerView.delegate = self;
    self.rulerView.dataSource = self;
    [self.view addSubview:self.rulerView];
    
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

- (void)changeRuler:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.minorScaleCount = 10;
        NSMutableArray *majorScales = [NSMutableArray array];
        for (NSInteger index=0; index<300; index+=10) {
            [majorScales addObject:@(index)];
        }
        self.majorScales = majorScales;
    } else {
        self.minorScaleCount = 12;
        NSMutableArray *majorScales = [NSMutableArray array];
        for (NSInteger index=1990; index<2015; index++) {
            [majorScales addObject:@(index)];
        }
        self.majorScales = majorScales;
    }
    [self.rulerView reloadData];
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
    return self.minorScaleCount;
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
    return [UIFont boldSystemFontOfSize:17];
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
