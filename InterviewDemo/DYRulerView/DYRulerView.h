//
//  DYRulerView.h
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const CollectionViewHeight;
extern CGFloat const PointerImageViewHeight;
extern CGFloat const PointerImageViewWidth;

@protocol DYRulerViewDelegate;
@interface DYRulerView : UIView

@property (nonatomic, strong) UIImageView *pointerImageView;

@property (nonatomic, weak) id <DYRulerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue spacing:(NSInteger)spacing;

@end

@protocol DYRulerViewDelegate <NSObject>

@optional
- (void)rulerView:(DYRulerView *)rulerView didChangeScale:(float)scale;

@end
