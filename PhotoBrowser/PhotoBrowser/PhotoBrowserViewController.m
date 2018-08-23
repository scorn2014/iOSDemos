//
//  PhotoBrowserViewController.m
//  PhotoBrowser
//
//  Created by AllenHuang on 2018/8/18.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property UIScrollView *scrollView;
@property UIView *bgView;
@property(readonly) UIImageView *currentImageView;

@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UILayoutGuide *viewGuide = self.view.safeAreaLayoutGuide;
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.translatesAutoresizingMaskIntoConstraints = NO;
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    _bgView = bgView;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [bgView.leadingAnchor constraintEqualToAnchor:viewGuide.leadingAnchor],
                                              [bgView.trailingAnchor constraintEqualToAnchor:viewGuide.trailingAnchor],
                                              [bgView.topAnchor constraintEqualToAnchor:viewGuide.topAnchor],
                                              [bgView.bottomAnchor constraintEqualToAnchor:viewGuide.bottomAnchor]
                                              ]
     ];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [scrollView.leadingAnchor constraintEqualToAnchor:viewGuide.leadingAnchor],
                                              [scrollView.trailingAnchor constraintEqualToAnchor:viewGuide.trailingAnchor],
                                              [scrollView.topAnchor constraintEqualToAnchor:viewGuide.topAnchor],
                                              [scrollView.bottomAnchor constraintEqualToAnchor:viewGuide.bottomAnchor]
                                              ]
     ];
    
    [self addTapGesture];
}

- (void)addTapGesture
{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
}

- (void)viewTapped:(UITapGestureRecognizer *)tap
{
    [self remove];
}

- (void)remove
{
    CGRect targetFrame = [self.view convertRect:self.originFrame toView:self.scrollView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0;
        self.currentImageView.frame = targetFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
}

- (void)addPanGestureForImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPanHandle:)];
    pan.delegate = self;
    [imageView addGestureRecognizer:pan];
}

- (void)imageViewPanHandle:(UIPanGestureRecognizer *)pan{
    
    UIView *gestureView = pan.view;
    CGPoint movePoint = [pan translationInView:gestureView];
    
    CGRect frame = gestureView.frame;
    frame.origin.y = frame.origin.y + movePoint.y;
    frame.origin.x = frame.origin.x + movePoint.x;
    gestureView.frame = frame;
    
    CGFloat alpha = fabs(movePoint.y)/self.bgView.bounds.size.height;
    self.bgView.alpha = MAX(alpha, 0.4);
    
    [pan setTranslation:CGPointZero inView:gestureView];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self remove];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint movePoint = [pan translationInView:gestureRecognizer.view];
        if (movePoint.x<0 || movePoint.y <0) {
            return NO;
        }
    }
    return YES;
}

- (void)setImages:(NSArray<UIImage *> *)images
{
    _images = [images copy];
    for (UIImage *image in _images) {
        NSInteger index = [_images indexOfObject:image];
        CGRect frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        imageView.tag = index;
        [self addPanGestureForImageView:imageView];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*_images.count, self.view.bounds.size.height);
    self.scrollView.contentOffset = CGPointMake(_currentIndex*self.view.bounds.size.width, 0);
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(_currentIndex*self.view.bounds.size.width, 0);
    
    UIImageView *currentImageView = self.currentImageView;
    
    CGRect convertFrame = [self.view convertRect:self.originFrame toView:self.scrollView];
    currentImageView.frame = convertFrame;
    
    [UIView animateWithDuration:0.5 animations:^{
        currentImageView.frame = CGRectMake(currentIndex*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
           
        }
    }];
}

- (UIImageView *)currentImageView
{
    UIImageView *currentImageView;
    for (UIImageView *imageView in self.scrollView.subviews) {
        if (imageView.tag == _currentIndex) {
            currentImageView = imageView;
        }
    }
    return currentImageView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x/self.view.bounds.size.width;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
