//
//  DYRulerCollectionViewCell.h
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const ScaleLineHeight;
extern CGFloat const ScaleLineWidth;
extern CGFloat const ScaleSpacing;

@interface DYRulerCollectionViewCell : UICollectionViewCell

- (void)configureWithIndexPath:(NSIndexPath *)indexPath minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue;

@end
