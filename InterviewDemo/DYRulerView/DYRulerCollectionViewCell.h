//
//  DYRulerCollectionViewCell.h
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYRulerCollectionViewCell : UICollectionViewCell

@property (nonatomic) NSInteger minorScaleCount;
@property (nonatomic) NSInteger scaleSpacing;
@property (nonatomic, copy) NSArray *majorScales;
@property (nonatomic) CGSize minorScaleSize;
@property (nonatomic) BOOL isShowMinorScale;
@property (nonatomic, strong) UIFont *majorScaleFont;

- (void)configureWithIndexPath:(NSIndexPath *)indexPath;

@end
