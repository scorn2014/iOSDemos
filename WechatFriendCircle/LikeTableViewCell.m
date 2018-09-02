//
//  LikeTableViewCell.m
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/9/2.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "LikeTableViewCell.h"
#import "UIColor+extension.h"
#import <Masonry/Masonry.h>

@implementation LikeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor commentColor];
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.image = [UIImage imageNamed:@"dianzan"];
        [self.contentView addSubview:_leftImageView];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(20);
            make.width.height.equalTo(@15);
        }];
    }
    return self;
}

- (void)setLikeImages:(NSMutableArray<UIImage *> *)likeImages{
    _likeImages = likeImages;
    
    for (UIImageView *imageView in self.contentView.subviews) {
        if (imageView.tag>=4000) {
            [imageView removeFromSuperview];
        }
    }
    
    //暂时没有考虑到照片太多超过一行需要换行的情况
    UIImageView *lastImageView;
    
    for (UIImage *image in likeImages) {
        NSInteger index = [likeImages indexOfObject:image];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 4000+index;
        imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:imageView];
        
        if (!lastImageView) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(10);
                make.left.equalTo(self.leftImageView).offset(20);
                make.width.height.equalTo(@30);
            }];
        }
        else
        {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(10);
                make.left.equalTo(lastImageView.mas_right).offset(10);
                make.width.height.equalTo(@30);
            }];
        }
        
        lastImageView = imageView;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
