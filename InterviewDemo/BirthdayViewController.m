//
//  BirthdayViewController.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/12.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "BirthdayViewController.h"
#import "DYRulerView.h"
#import "NSDate+DateTools.h"

@interface BirthdayViewController () <DYRulerViewDelegate, DYRulerViewDataSource>

@property (nonatomic, weak) IBOutlet DYRulerView *rulerView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation BirthdayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DYRulerViewDataSource
- (NSInteger)numberOfMajorScaleInRulerView:(DYRulerView *)rulerView
{
    return 21;
}

- (NSInteger)numberOfMinorScaleInRulerView:(DYRulerView *)rulerView
{
    return 12;
}

- (NSString *)rulerView:(DYRulerView *)rulerView textOfMajorScaleAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@", @([[NSDate date] year]-[self numberOfMajorScaleInRulerView:rulerView]+index+1)];
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
    return CGSizeMake(6, 40);
}

- (CGSize)sizeForMinorScaleViewInRulerView:(DYRulerView *)rulerView
{
    return CGSizeMake(2, 20);
}

- (void)rulerView:(DYRulerView *)rulerView didChangeScaleWithMajorScale:(int)majorScale minorScale:(int)minorScale
{
    self.label.text = [NSString stringWithFormat:@"%@/%@", @([[NSDate date] year]-[self numberOfMajorScaleInRulerView:rulerView]+majorScale+1), @(minorScale+1)];
}

@end
