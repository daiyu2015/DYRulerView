//
//  DYRulerCollectionViewCell.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "DYRulerCollectionViewCell.h"

@interface DYRulerCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DYRulerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
                
    }
    return self;
}

- (void)addConstraintForPointerImageView
{
    NSDictionary *metricsMap = @{ @"height" : @(20) };
    NSDictionary *nameMap = @{ @"label" : self.label };
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.scaleSpacing+self.minorScaleSize.width*0.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.minorScaleSize.height*2+20]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(==height)]" options:0 metrics:metricsMap views:nameMap]];
}

- (void)configureWithIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.label = [[UILabel alloc] init];
    self.label.backgroundColor = [UIColor lightGrayColor];
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.label.textColor = [UIColor whiteColor];
    if (self.majorScaleFont) {
        self.label.font = self.majorScaleFont;
    }
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.hidden = NO;
    if (indexPath.row > 0) {
        self.label.text = [NSString stringWithFormat:@"%@", self.majorScales[indexPath.row-1]];
    }
    [self.contentView addSubview:self.label];
    [self addConstraintForPointerImageView];
    if (indexPath.row == 0) {
        self.label.hidden = YES;
    } else if (indexPath.row == 1) {
        [self createScaleViewWithInitialCount:1 totalCount:self.minorScaleCount+1];
    } else if (indexPath.row == self.majorScales.count) {
        [self createScaleViewWithInitialCount:0 totalCount:2];
    } else {
        [self createScaleViewWithInitialCount:0 totalCount:self.minorScaleCount+1];
    }
}

- (void)createScaleViewWithInitialCount:(NSInteger)initialCount totalCount:(NSInteger)totalCount
{
    for (NSInteger index=initialCount; index<totalCount; index++) {
        UIView *view = [[UIView alloc] init];
        if (index == 1) {
            view.frame = CGRectMake(index*self.scaleSpacing-self.minorScaleSize.width, 1, 2*self.minorScaleSize.width, 2*self.minorScaleSize.height);
        } else {
            if (self.isShowMinorScale) {
                view.frame = CGRectMake(index*self.scaleSpacing-0.5*self.minorScaleSize.width, 1, self.minorScaleSize.width, self.minorScaleSize.height);
            } else {
                view.frame = CGRectZero;
            }
        }
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
    }
}

@end
