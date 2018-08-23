//
//  CenteredCollectionViewLayout.m
//  CenteredCollectionView
//
//  Created by AllenHuang on 2018/8/19.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "CenteredCollectionViewLayout.h"


@interface CenteredCollectionViewLayout(){
    
}

@property(readonly) CGFloat pageWidth;
@property(strong) NSTimer* timer;

@end

@implementation CenteredCollectionViewLayout

@synthesize pageWidth=_pageWidth;

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:10 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSInteger totalPage = [weakSelf.collectionView.dataSource collectionView:weakSelf.collectionView numberOfItemsInSection:0];
            if (weakSelf.currentPage+1 < totalPage) {
                [weakSelf scrollToPage:weakSelf.currentPage+1 animated:YES];
            }
            else
            {
                [weakSelf scrollToPage:0 animated:YES];
            }
        }];
    }
    return self;
}

- (void)stopTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
   return  [self targetContentOffsetForProposedContentOffset:proposedContentOffset];
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    
    UICollectionViewLayoutAttributes *candidateAttributes = [self candidateAttributesForCollectionView:self.collectionView proposedContentOffset:proposedContentOffset];
    
    CGFloat centerOffset = proposedContentOffset.x + self.collectionView.bounds.size.width/2;
    CGFloat offsetAdjustment = candidateAttributes.center.x - centerOffset;
    CGFloat newOffset = proposedContentOffset.x + offsetAdjustment;
    
    return CGPointMake(newOffset, proposedContentOffset.y);
}


- (CGFloat)pageWidth{
    
    _pageWidth = self.itemSize.width + self.minimumLineSpacing;
    return _pageWidth;
}

- (CGRect)determineProposedRectForCollectionView:(UICollectionView *)collectionView proposedContentOffset:(CGPoint)proposedContentOffset{
    CGRect proposedRect;
    proposedRect.origin = CGPointMake(proposedContentOffset.x, collectionView.contentOffset.y);
    proposedRect.size = collectionView.bounds.size;
    return proposedRect;
}

- (UICollectionViewLayoutAttributes *)candidateAttributesForCollectionView:(UICollectionView*)collectionView proposedContentOffset:(CGPoint)proposedContentOffset{

    UICollectionViewLayoutAttributes *candidateAttributes;
    CGFloat proposedCenterOffset = proposedContentOffset.x + collectionView.bounds.size.width/2;
    
    CGRect proposedRect = [self determineProposedRectForCollectionView:collectionView proposedContentOffset:proposedContentOffset];
    NSArray *layoutAttributes = [self layoutAttributesForElementsInRect:proposedRect];
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        if (!candidateAttributes) {
            candidateAttributes = attributes;
            continue;
        }
        if (fabs(attributes.center.x-proposedCenterOffset) < fabs(candidateAttributes.center.x - proposedCenterOffset) ) {
            candidateAttributes = attributes;
        }
    }
    
    return candidateAttributes;
}

static CGFloat const activeDistance = 40;
static CGFloat const scaleFactor = 0.1;

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;

    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        if (CGRectIntersectsRect(attributes.frame, visibleRect)) {
            CGFloat distance = fabs(attributes.center.x - CGRectGetMidX(visibleRect));
            if (distance<activeDistance) {
                CGFloat scale = 1 + scaleFactor *(1-distance/activeDistance);
                attributes.transform3D = CATransform3DMakeScale(scale, scale, 1);
                attributes.zIndex = 1;
            }
        }
    }
    return layoutAttributes;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


- (void)scrollToPage:(NSInteger)index animated:(BOOL)animated{
    CGFloat pagedOffset = index*self.pageWidth - self.collectionView.contentInset.left;
    CGPoint proposedOffset = CGPointMake(pagedOffset, self.collectionView.contentOffset.y);
    CGPoint targetOffset = [self targetContentOffsetForProposedContentOffset:proposedOffset];
    BOOL shouldAnimate = fabs(self.collectionView.contentOffset.x - pagedOffset)>1 ? animated:NO;
    [self.collectionView setContentOffset:targetOffset animated:shouldAnimate];
}

- (int)currentPage{
    CGPoint centerPoint;
    centerPoint.x = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2;
    centerPoint.y = self.collectionView.contentOffset.y + self.collectionView.bounds.size.height/2;
    return (int)[self.collectionView indexPathForItemAtPoint:centerPoint].item;
}

@end
