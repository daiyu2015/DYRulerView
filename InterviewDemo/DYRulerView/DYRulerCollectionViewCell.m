//
//  DYRulerCollectionViewCell.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "DYRulerCollectionViewCell.h"

CGFloat const ScaleLineHeight = 10.0f;
CGFloat const ScaleLineWidth = 1.0f;
CGFloat const ScaleSpacing = 20.0f;

@interface DYRulerCollectionViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DYRulerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

- (void)configureWithIndexPath:(NSIndexPath *)indexPath minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, MAX(ScaleSpacing*2, 40), 20)];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
    self.label.hidden = NO;
    self.label.text = [NSString stringWithFormat:@"%@", @(indexPath.row-1+minValue)];
    if (indexPath.row == 0) {
        self.label.hidden = YES;
    } else if (indexPath.row == 1) {
        [self createScaleViewWithInitialCount:1 totalCount:11 scaleSpacing:ScaleSpacing];
    } else if (indexPath.row == maxValue-minValue+1) {
        [self createScaleViewWithInitialCount:0 totalCount:2 scaleSpacing:ScaleSpacing];
    } else {
        [self createScaleViewWithInitialCount:0 totalCount:11 scaleSpacing:ScaleSpacing];
    }
}

- (void)createScaleViewWithInitialCount:(NSInteger)initialCount totalCount:(NSInteger)totalCount scaleSpacing:(CGFloat)scaleSpacing
{
    for (NSInteger index=initialCount; index<totalCount; index++) {
        UIView *view = [[UIView alloc] init];
        if (index == 1) {
            view.frame = CGRectMake(index*scaleSpacing-2*ScaleLineWidth, 1, 2*ScaleLineWidth, 2*ScaleLineHeight);
        } else {
            view.frame = CGRectMake(index*scaleSpacing-ScaleLineWidth, 1, ScaleLineWidth, ScaleLineHeight);
        }
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
    }
}

@end
