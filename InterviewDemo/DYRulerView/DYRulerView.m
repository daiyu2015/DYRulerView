//
//  DYRulerView.m
//  InterviewDemo
//
//  Created by 代雨 on 15/7/11.
//  Copyright (c) 2015年 代雨. All rights reserved.
//

#import "DYRulerView.h"
#import "DYRulerCollectionViewCell.h"

@interface DYRulerView() <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, DYRulerViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) NSInteger minValue;
@property (nonatomic) NSInteger maxValue;

@property (nonatomic) NSInteger minorScaleCount;
@property (nonatomic) NSInteger scaleSpacing;
@property (nonatomic) CGSize minorScaleSize;
@property (nonatomic) CGSize majorScaleSize;
@property (nonatomic) BOOL isShowMinorScale;
@property (nonatomic, copy) NSArray *majorScales;
@property (nonatomic, strong) UIFont *majorScaleFont;
@property (nonatomic) CGSize pointerSize;

@end

@implementation DYRulerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self createSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor blueColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[DYRulerCollectionViewCell class]  forCellWithReuseIdentifier:@"DYRulerCollectionViewCell"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.collectionView];
    
    NSDictionary *nameMap = @{ @"collectionView" : self.collectionView };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:nameMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:0 metrics:nil views:nameMap]];
    
    self.pointerImageView = [[UIImageView alloc] init];
    self.pointerImageView.backgroundColor = [UIColor whiteColor];
    self.pointerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.pointerImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self configureDataSource];
}

- (void)configureDataSource
{
    self.majorScales = [self.dataSource majorScalesInRulerView:self];
    self.minorScaleCount = [self.dataSource numberOfMinorScaleInRulerView:self];
    
    if ([self.delegate respondsToSelector:@selector(spacingBetweenMinorScaleInRulerView:)]) {
        self.scaleSpacing = MAX([self.delegate spacingBetweenMinorScaleInRulerView:self], 10);
    } else {
        self.scaleSpacing = 15;
    }
    
    // 指针视图尺寸
    if ([self.delegate respondsToSelector:@selector(rulerView:sizeForPointerImageView:)]) {
        self.pointerSize = [self.delegate rulerView:self sizeForPointerImageView:self.pointerImageView];
    } else {
        self.pointerSize = CGSizeMake(4, 50);
    }
    // 指针视图添加约束
    [self addConstraintForPointerImageView];
    
    // 小刻度尺寸
    if ([self.delegate respondsToSelector:@selector(sizeForMinorScaleViewInRulerView:)]) {
        self.minorScaleSize = [self.delegate sizeForMinorScaleViewInRulerView:self];
    } else {
        self.minorScaleSize = CGSizeMake(1, 10);
    }
    
    // 大刻度尺寸
    if ([self.delegate respondsToSelector:@selector(sizeForMajorScaleViewInRulerView:)]) {
        self.majorScaleSize = [self.delegate sizeForMajorScaleViewInRulerView:self];
    } else {
        self.majorScaleSize = CGSizeMake(2*self.minorScaleSize.width, 2*self.minorScaleSize.height);
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
}

- (void)addConstraintForPointerImageView
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pointerImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    NSDictionary *metricsMap = @{ @"width" : @(self.pointerSize.width),
                                  @"height" : @(self.pointerSize.height) };
    NSDictionary *nameMap = @{ @"pointerImageView" : self.pointerImageView };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pointerImageView(==width)]" options:0 metrics:metricsMap views:nameMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pointerImageView(==height)]|" options:0 metrics:metricsMap views:nameMap]];
}

- (void)reloadData
{
    [self configureDataSource];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    rulerCollectionViewCell.majorScaleSize = self.majorScaleSize;
    rulerCollectionViewCell.isShowMinorScale = self.isShowMinorScale;
    rulerCollectionViewCell.majorScaleFont = self.majorScaleFont;
    rulerCollectionViewCell.pointerHeight = self.pointerSize.height;
    [rulerCollectionViewCell configureWithIndexPath:indexPath];
    return rulerCollectionViewCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(self.frame.size.width*0.5-self.scaleSpacing, self.collectionView.frame.size.height);
    } else if (indexPath.row == self.majorScales.count) {
        return CGSizeMake(self.frame.size.width*0.5+self.scaleSpacing, self.collectionView.frame.size.height);
    } else {
        return CGSizeMake(self.minorScaleCount*self.scaleSpacing, self.collectionView.frame.size.height);
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
    NSLog(@"scrollViewDidEndDragging%f", scrollView.contentOffset.x);
    float accurateScale = (scrollView.contentOffset.x)/(self.scaleSpacing*self.minorScaleCount);
    float inaccurateScale = round(accurateScale*self.minorScaleCount)/self.minorScaleCount;
    [scrollView setContentOffset:CGPointMake((inaccurateScale)*self.scaleSpacing*self.minorScaleCount, 0) animated:YES];
    if (accurateScale >= 0 && accurateScale <= self.maxValue-self.minValue) {
        if ([self.delegate respondsToSelector:@selector(rulerView:didChangeScaleWithMajorScale:minorScale:)]) {
            [self.delegate rulerView:self didChangeScaleWithMajorScale:(int)inaccurateScale minorScale:(int)fmod(inaccurateScale*self.minorScaleCount, self.minorScaleCount)];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

@end
