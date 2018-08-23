//
//  CenteredCollectionViewLayout.h
//  CenteredCollectionView
//
//  Created by AllenHuang on 2018/8/19.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CenteredCollectionViewLayout : UICollectionViewFlowLayout

- (void)scrollToPage:(NSInteger)index animated:(BOOL)animated;

@property(readonly) int currentPage;

@end
