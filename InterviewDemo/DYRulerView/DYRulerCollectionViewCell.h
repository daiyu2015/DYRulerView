//
//  DYRulerCollectionViewCell.h
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYRulerCollectionViewCell : UICollectionViewCell

@property (nonatomic) NSInteger majorScaleCount;
@property (nonatomic) NSInteger minorScaleCount;
@property (nonatomic) NSInteger scaleSpacing;
@property (nonatomic) CGSize minorScaleSize;
@property (nonatomic) CGSize majorScaleSize;
@property (nonatomic) BOOL isShowMinorScale;
@property (nonatomic, strong) UIFont *majorScaleFont;
@property (nonatomic) CGFloat pointerHeight;
@property (nonatomic, strong) NSString  *labelText;

- (void)configureWithIndexPath:(NSIndexPath *)indexPath;

@end
