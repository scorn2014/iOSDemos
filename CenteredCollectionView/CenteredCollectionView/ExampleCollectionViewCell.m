//
//  ExampleCollectionViewCell.m
//  CenteredCollectionView
//
//  Created by AllenHuang on 2018/8/19.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "ExampleCollectionViewCell.h"

@implementation ExampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:self.bounds];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.font = [UIFont systemFontOfSize:19];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLbl];
        _titleLbl = titleLbl;
        
        self.layer.cornerRadius = 4.f;
    }
    return self;
}

@end
