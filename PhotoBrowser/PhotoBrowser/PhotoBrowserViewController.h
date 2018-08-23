//
//  PhotoBrowserViewController.h
//  PhotoBrowser
//
//  Created by AllenHuang on 2018/8/18.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserViewController : UIViewController

@property(copy,nonatomic) NSArray<UIImage *> *images;
@property(assign,nonatomic) NSInteger currentIndex;
@property(assign,nonatomic) CGRect originFrame;

@end
