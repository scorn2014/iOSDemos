//
//  PagesViewController.m
//  PagesController
//
//  Created by AllenHuang on 2018/8/16.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "PagesViewController.h"
#import "PagesHeaderCollectionViewCell.h"
#import "globalConstant.h"
#import "BaseViewController.h"

@protocol PagesHeaderDelegate <NSObject>

@required
- (void)pageHeaderSelectedIndex:(NSInteger)index;

@end

@interface PagesHeaderView:UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property UICollectionView *collectionView;
@property UICollectionViewFlowLayout *collectionFlowLayout;
@property(copy,nonatomic) NSArray *titles;
@property(weak,nonatomic) id<PagesHeaderDelegate> delegate;

@end

@implementation PagesHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_collectionFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[PagesHeaderCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PagesHeaderCollectionViewCell class])];
        
        _titles = @[];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = [titles copy];
    [self.collectionView reloadData];
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
    PagesHeaderCollectionViewCell *cell = (PagesHeaderCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PagesHeaderCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLbl.text = _titles[indexPath.item];
    
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){60,collectionView.bounds.size.height};
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate pageHeaderSelectedIndex:indexPath.item];
}

@end

@interface PagesViewController ()<UIScrollViewDelegate,PagesHeaderDelegate>

@property UIScrollView *scrollView;
@property PagesHeaderView *headerView;
@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *headerTitles = @[@"广告",@"生活",@"动画",@"搞笑",@"开胃",@"创意",@"运动",@"音乐",@"萌宠",@"剧情",@"科技"];
    
    PagesHeaderView *headerView = [[PagesHeaderView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    headerView.titles = headerTitles;
    [headerView.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    headerView.delegate = self;
    [self.navigationController.navigationBar addSubview:headerView];
    _headerView = headerView;
    
    UILayoutGuide *viewGuide = self.view.safeAreaLayoutGuide;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.contentSize = CGSizeMake(headerTitles.count*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [scrollView.leadingAnchor constraintEqualToAnchor:viewGuide.leadingAnchor],
                                              [scrollView.trailingAnchor constraintEqualToAnchor:viewGuide.trailingAnchor],
                                              [scrollView.topAnchor constraintEqualToAnchor:viewGuide.topAnchor],
                                              [scrollView.bottomAnchor constraintEqualToAnchor:viewGuide.bottomAnchor]
                                              ]
     ];
    
    for (NSString *title in headerTitles) {
        
        NSInteger index = [headerTitles indexOfObject:title];
        
        BaseViewController *controller = [[BaseViewController alloc] init];
        controller.view.backgroundColor = randomColor;
        controller.textLbl.text = title;
        controller.view.frame = CGRectMake(index*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [_scrollView addSubview:controller.view];
        [self addChildViewController:controller];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    [self.headerView.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:pageIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)pageHeaderSelectedIndex:(NSInteger)index
{
    CGPoint contentOffset = CGPointMake(index*[UIScreen mainScreen].bounds.size.width, 0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
