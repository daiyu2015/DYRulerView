//
//  BirthdayViewController.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/12.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "BirthdayViewController.h"
#import "DYRulerView.h"

@interface BirthdayViewController () <DYRulerViewDelegate, DYRulerViewDataSource>

@property (nonatomic, weak) IBOutlet DYRulerView *rulerView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@property (nonatomic, copy) NSArray *majorScales;

@end

@implementation BirthdayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *majorScales = [NSMutableArray array];
    for (NSInteger index=1990; index<2015; index++) {
        [majorScales addObject:@(index)];
    }
    self.majorScales = majorScales;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DYRulerViewDataSource
- (NSArray *)majorScalesInRulerView:(DYRulerView *)rulerView
{
    return self.majorScales;
}

- (NSInteger)numberOfMinorScaleInRulerView:(DYRulerView *)rulerView
{
    return 12;
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

- (CGSize)sizeForMajorScaleViewInRulerView:(DYRulerView *)rulerView
{
    return CGSizeMake(6, 40);
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
