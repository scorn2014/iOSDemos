//
//  PhotosViewController.m
//  PhotoBrowser
//
//  Created by AllenHuang on 2018/8/18.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoBrowserViewController.h"

@interface PhotosViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property UICollectionView *collectionView;
@property UICollectionViewFlowLayout *collectionFlowLayout;
@property NSMutableArray<UIImage *> *images;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Photos";
    
    _collectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_collectionFlowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_collectionView];
    
    UILayoutGuide *viewGuide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
                                              [_collectionView.leadingAnchor constraintEqualToAnchor:viewGuide.leadingAnchor],
                                              [_collectionView.trailingAnchor constraintEqualToAnchor:viewGuide.trailingAnchor],
                                              [_collectionView.topAnchor constraintEqualToAnchor:viewGuide.topAnchor constant:10],
                                              [_collectionView.bottomAnchor constraintEqualToAnchor:viewGuide.bottomAnchor]
                                              ]];
    
    [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class])];
    
    _images =[NSMutableArray arrayWithCapacity:10];
    for (int i=33; i<43; i++) {
        NSString *name = [NSString stringWithFormat:@"IMG_04%d",i];
        UIImage *image = [UIImage imageNamed:name];
        [_images addObject:image];
    }
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = _images[indexPath.item];
    
    return cell;
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){60,60};
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoBrowserViewController *browser = [[PhotoBrowserViewController alloc] init];
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect cellFrame = cell.frame;
    CGRect convertFrame = [collectionView convertRect:cellFrame toView:browser.view];
    browser.originFrame = convertFrame;
    browser.view.frame = [UIScreen mainScreen].bounds;
    
    browser.images = self.images;
    browser.currentIndex = indexPath.item;
    
    [self.navigationController.view addSubview:browser.view];
    [self.navigationController addChildViewController:browser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
