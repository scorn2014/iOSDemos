//
//  BaseViewController.m
//  PagesController
//
//  Created by AllenHuang on 2018/8/16.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILayoutGuide *viewGuide = self.view.safeAreaLayoutGuide;

    UILabel *textLbl = [[UILabel alloc] initWithFrame:self.view.bounds];
    textLbl.backgroundColor = [UIColor clearColor];
    textLbl.font = [UIFont boldSystemFontOfSize:24];
    textLbl.textAlignment = NSTextAlignmentCenter;
    textLbl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textLbl];
    _textLbl = textLbl;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [textLbl.centerXAnchor constraintEqualToAnchor:viewGuide.centerXAnchor],
                                              [textLbl.centerYAnchor constraintEqualToAnchor:viewGuide.centerYAnchor]
                                              ]
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
