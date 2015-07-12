//
//  WeightViewController.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/12.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "WeightViewController.h"
#import "DYRulerView.h"

@interface WeightViewController () <DYRulerViewDelegate, DYRulerViewDataSource>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) DYRulerView *rulerView;

@end

@implementation WeightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rulerView = [[DYRulerView alloc] init];
    self.rulerView.delegate = self;
    self.rulerView.dataSource = self;
    self.rulerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.rulerView];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor redColor];
    self.label.textColor = [UIColor blackColor];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.label];
    
    NSDictionary *nameMap = @{ @"rulerView" : self.rulerView,
                               @"label" : self.label };
    NSDictionary *metricsMap = @{ @"rulerViewHeight" : @(140),
                                  @"labelHeight" : @(30),
                                  @"labelWidth" : @(100) };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[rulerView]|" options:0 metrics:nil views:nameMap]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[rulerView(==rulerViewHeight)]" options:0 metrics:metricsMap views:nameMap]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[label(==labelWidth)]" options:0 metrics:metricsMap views:nameMap]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rulerView]-110-[label(==labelHeight)]" options:0 metrics:metricsMap views:nameMap]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DYRulerViewDataSource
- (NSInteger)numberOfMajorScaleInRulerView:(DYRulerView *)rulerView
{
    return 200;
}

- (NSInteger)numberOfMinorScaleInRulerView:(DYRulerView *)rulerView
{
    return 10;
}

- (NSString *)rulerView:(DYRulerView *)rulerView textOfMajorScaleAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@", @(index+1)];
}


#pragma mark - DYRulerViewDelegate
- (CGFloat)spacingBetweenMinorScaleInRulerView:(DYRulerView *)rulerView
{
    return 15;
}

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

- (CGSize)sizeForMajorScaleViewInRulerView:(DYRulerView *)rulerView
{
    return CGSizeMake(4, 40);
}

- (CGSize)sizeForMinorScaleViewInRulerView:(DYRulerView *)rulerView
{
    return CGSizeMake(2, 20);
}

- (void)rulerView:(DYRulerView *)rulerView didChangeScaleWithMajorScale:(int)majorScale minorScale:(int)minorScale
{
    self.label.text = [NSString stringWithFormat:@"%@/%@", @(majorScale+1), @(minorScale)];
}

@end
