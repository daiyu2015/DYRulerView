//
//  DYRulerView.h
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DYRulerViewDataSource, DYRulerViewDelegate;
@interface DYRulerView : UIView

@property (nonatomic, strong) UIImageView *pointerImageView;

@property (nonatomic, weak) id <DYRulerViewDataSource> dataSource;
@property (nonatomic, weak) id <DYRulerViewDelegate> delegate;

- (void)reloadData;

- (instancetype)initWithFrame:(CGRect)frame;

@end

@protocol DYRulerViewDataSource <NSObject>

@required
// 大刻度数组
- (NSArray *)majorScalesInRulerView:(DYRulerView *)rulerView;
// 小刻度的数量
- (NSInteger)numberOfMinorScaleInRulerView:(DYRulerView *)rulerView;
// 小刻度的间距
- (CGFloat)spacingBetweenMinorScaleInRulerView:(DYRulerView *)rulerView;
// 刻度尺高度
- (CGFloat)heightForRulerView:(DYRulerView *)rulerView;

@end

@protocol DYRulerViewDelegate <NSObject>

@optional
// 指针的尺寸
- (CGSize)rulerView:(DYRulerView *)rulerView sizeForPointerImageView:(UIImageView *)pointerImageView;
// 刻度字体
- (UIFont *)fontForMajorScaleInRulerView:(DYRulerView *)rulerView;
// 是否显示小刻度
- (BOOL)rulerViewShouldShowMinorScale:(DYRulerView *)rulerView;
// 小刻度的尺寸
- (CGSize)sizeForMinorScaleViewInRulerView:(DYRulerView *)rulerView;
// 选择刻度
- (void)rulerView:(DYRulerView *)rulerView didChangeScaleWithMajorScale:(int)majorScale minorScale:(int)minorScale;

@end
