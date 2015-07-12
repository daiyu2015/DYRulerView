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
@property (nonatomic) NSInteger spacing;
@property (nonatomic) NSInteger numberOfItems;

@end

@implementation DYRulerView

- (instancetype)initWithFrame:(CGRect)frame minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue spacing:(NSInteger)spacing
{
    if (self = [super initWithFrame:frame]) {
        
        self.minValue = minValue;
        self.maxValue = maxValue;
        self.spacing = spacing;
        self.numberOfItems = self.maxValue-self.minValue+2;
        
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
    return self.numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DYRulerCollectionViewCell";
    DYRulerCollectionViewCell *rulerCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [rulerCollectionViewCell configureWithIndexPath:indexPath minValue:self.minValue maxValue:self.maxValue];
    return rulerCollectionViewCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(self.frame.size.width*0.5-ScaleSpacing, CollectionViewHeight);
    } else if (indexPath.row == self.numberOfItems-1) {
        return CGSizeMake(self.frame.size.width*0.5+ScaleSpacing, CollectionViewHeight);
    } else {
        return CGSizeMake(10*ScaleSpacing, CollectionViewHeight);
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
    float scale = (scrollView.contentOffset.x)/(ScaleSpacing*self.spacing)+self.minValue;
    if (scale >= self.minValue && scale <= self.maxValue) {
        if ([self.delegate respondsToSelector:@selector(rulerView:didChangeScale:)]) {
            [self.delegate rulerView:self didChangeScale:scale];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging%f", scrollView.contentOffset.x);
    float scale = (scrollView.contentOffset.x)/(ScaleSpacing*self.spacing)+self.minValue;
    if (scale >= self.minValue && scale <= self.maxValue) {
        if ([self.delegate respondsToSelector:@selector(rulerView:didChangeScale:)]) {
            [self.delegate rulerView:self didChangeScale:scale];
        }
    }
}

@end
