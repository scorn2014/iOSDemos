//
//  PagesHeaderCollectionViewCell.m
//  PagesController
//
//  Created by AllenHuang on 2018/8/16.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "PagesHeaderCollectionViewCell.h"

@implementation PagesHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *textLbl = [[UILabel alloc] initWithFrame:self.bounds];
        textLbl.backgroundColor = [UIColor clearColor];
        textLbl.font = [UIFont systemFontOfSize:17];
        textLbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLbl];
        _textLbl = textLbl;
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width-20)/2, self.bounds.size.height-2, 20, 2)];
        _lineView.backgroundColor = [UIColor blackColor];
        _lineView.hidden = YES;
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _lineView.hidden = !selected;
}

@end
