//
//  DYRulerView.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "DYRulerView.h"
#import "DYRulerCollectionViewCell.h"

CGFloat const CollectionViewHeight = 140.0f;
CGFloat const PointerImageViewHeight = 50.0f;
CGFloat const PointerImageViewWidth = 4.0f;

@interface DYRulerView() <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, DYRulerViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) NSInteger minValue;
@property (nonatomic) NSInteger maxValue;

@property (nonatomic) NSInteger minorScaleCount;
@property (nonatomic) NSInteger scaleSpacing;
@property (nonatomic, copy) NSArray *majorScales;
@property (nonatomic) CGSize minorScaleSize;
@property (nonatomic) BOOL isShowMinorScale;
@property (nonatomic, strong) UIFont *majorScaleFont;

@end

@implementation DYRulerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor blueColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[DYRulerCollectionViewCell class]  forCellWithReuseIdentifier:@"DYRulerCollectionViewCell"];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
            
        self.pointerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-PointerImageViewWidth/2, frame.size.height-PointerImageViewHeight, PointerImageViewWidth, PointerImageViewHeight)];
        self.pointerImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pointerImageView];
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.majorScales = [self.dataSource majorScalesInRulerView:self];
    self.minorScaleCount = [self.dataSource numberOfMinorScaleInRulerView:self];
    self.scaleSpacing = [self.dataSource spacingBetweenMinorScaleInRulerView:self];
    
    // 小刻度尺寸
    if ([self.delegate respondsToSelector:@selector(sizeForMinorScaleViewInRulerView:)]) {
        self.minorScaleSize = [self.delegate sizeForMinorScaleViewInRulerView:self];
    } else {
        self.minorScaleSize = CGSizeMake(1, 10);
    }
    
    // 是否显示小刻度
    if ([self.delegate respondsToSelector:@selector(rulerViewShouldShowMinorScale:)]) {
        self.isShowMinorScale = [self.delegate rulerViewShouldShowMinorScale:self];
    } else {
        self.isShowMinorScale = YES;
    }
    
    // 大刻度字体
    if ([self.delegate respondsToSelector:@selector(fontForMajorScaleInRulerView:)]) {
        self.majorScaleFont = [self.delegate fontForMajorScaleInRulerView:self];
    }
    
    self.minValue = [self.majorScales[0] integerValue];
    self.maxValue = [self.majorScales[self.majorScales.count-1] integerValue];
    
    return self.majorScales.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DYRulerCollectionViewCell";
    DYRulerCollectionViewCell *rulerCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    rulerCollectionViewCell.majorScales = self.majorScales;
    rulerCollectionViewCell.scaleSpacing = self.scaleSpacing;
    rulerCollectionViewCell.minorScaleCount = self.minorScaleCount;
    rulerCollectionViewCell.minorScaleSize = self.minorScaleSize;
    rulerCollectionViewCell.isShowMinorScale = self.isShowMinorScale;
    rulerCollectionViewCell.majorScaleFont = self.majorScaleFont;
    [rulerCollectionViewCell configureWithIndexPath:indexPath];
    return rulerCollectionViewCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(self.frame.size.width*0.5-self.scaleSpacing, CollectionViewHeight);
    } else if (indexPath.row == self.majorScales.count) {
        return CGSizeMake(self.frame.size.width*0.5+self.scaleSpacing, CollectionViewHeight);
    } else {
        return CGSizeMake(self.minorScaleCount*self.scaleSpacing, CollectionViewHeight);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating%f", scrollView.contentOffset.x);
    float scale = (scrollView.contentOffset.x)/self.scaleSpacing+self.minValue;
    if (scale >= self.minValue && scale <= self.maxValue) {
        if ([self.delegate respondsToSelector:@selector(rulerView:didChangeScale:)]) {
            [self.delegate rulerView:self didChangeScale:scale];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging%f", scrollView.contentOffset.x);
    float scale = (scrollView.contentOffset.x)/self.scaleSpacing+self.minValue;
    if (scale >= self.minValue && scale <= self.maxValue) {
        if ([self.delegate respondsToSelector:@selector(rulerView:didChangeScale:)]) {
            [self.delegate rulerView:self didChangeScale:scale];
        }
    }
}

@end
