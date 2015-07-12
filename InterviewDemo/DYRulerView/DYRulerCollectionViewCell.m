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
        
        self.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

- (void)configureWithIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.minorScaleSize.height*2+10, MAX(self.scaleSpacing*2, 40), 20)];
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
