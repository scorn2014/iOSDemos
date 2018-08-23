//
//  ExampleViewController.m
//  CenteredCollectionView
//
//  Created by AllenHuang on 2018/8/19.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "ExampleViewController.h"
#import "CenteredCollectionViewLayout.h"
#import "ExampleCollectionViewCell.h"

static const float cellPercentWidth = 0.7;

@interface ExampleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property UICollectionView *collectionView;
@property CenteredCollectionViewLayout *collectionFlowLayout;
@property NSArray *titles;

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.navigationItem.title = @"CenteredCollectionView";
    
    _collectionFlowLayout = [[CenteredCollectionViewLayout alloc] init];
    _collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_collectionFlowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.view addSubview:_collectionView];
    
    _collectionFlowLayout.itemSize = (CGSize){_collectionView.bounds.size.width*cellPercentWidth,_collectionView.bounds.size.height*0.6};
    _collectionFlowLayout.minimumLineSpacing = 20.f;

    
    UILayoutGuide *viewGuide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
                                              [_collectionView.leadingAnchor constraintEqualToAnchor:viewGuide.leadingAnchor],
                                              [_collectionView.trailingAnchor constraintEqualToAnchor:viewGuide.trailingAnchor],
                                              [_collectionView.topAnchor constraintEqualToAnchor:viewGuide.topAnchor constant:10],
                                              [_collectionView.bottomAnchor constraintEqualToAnchor:viewGuide.bottomAnchor]
                                              ]];
    
    [_collectionView registerClass:[ExampleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ExampleCollectionViewCell class])];
    
    _titles = @[@"Cell1",@"Cell2",@"Cell3",@"Cell4"];
    
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExampleCollectionViewCell *cell = (ExampleCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ExampleCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLbl.text = _titles[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionFlowLayout scrollToPage:indexPath.item animated:YES];
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating,contentOffset %@,currentPage:%d",NSStringFromCGPoint(scrollView.contentOffset),self.collectionFlowLayout.currentPage);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging,contentOffset %@,currentPage:%d",NSStringFromCGPoint(scrollView.contentOffset),self.collectionFlowLayout.currentPage);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
