//
//  CommentTableViewCell.m
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/26.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "CommentTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+extension.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor commentColor];
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.image = [UIImage imageNamed:@"coment"];
        [self.contentView addSubview:_leftImageView];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(20);
            make.width.height.equalTo(@15);
        }];
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_avatarImageView];
        
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self->_leftImageView.mas_right).offset(10);
            make.width.height.equalTo(@40);
        }];
        
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLbl.backgroundColor = [UIColor clearColor];
        _nameLbl.textColor = [UIColor nameColor];
        _nameLbl.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:_nameLbl];
        
        [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.width.equalTo(@150);
            make.left.equalTo(self->_avatarImageView.mas_right).offset(10);
        }];
        
        _contentLbl = [[YYLabel alloc] initWithFrame:CGRectZero];
        _contentLbl.backgroundColor = [UIColor clearColor];
        _contentLbl.font = [UIFont systemFontOfSize:17];
        _contentLbl.numberOfLines = 0;
        _contentLbl.displaysAsynchronously = YES;
        _contentLbl.textVerticalAlignment = YYTextVerticalAlignmentTop;
        [self.contentView addSubview:_contentLbl];
        
        [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_nameLbl.mas_bottom).offset(10);
            make.left.equalTo(self->_nameLbl).offset(0);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        _timeLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLbl.backgroundColor = [UIColor clearColor];
        _timeLbl.textColor = [UIColor grayColor];
        _timeLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLbl];
        
        [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_nameLbl.mas_top).offset(0);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(CommentModel *)cellModel{
    _cellModel = cellModel;
    self.nameLbl.text = cellModel.name;
    self.avatarImageView.image = [UIImage imageNamed:cellModel.avatarString];
    self.timeLbl.text = cellModel.createdTime;
    self.contentLbl.textLayout = cellModel.contentLayout;
    
    [self.contentLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.contentLbl.textLayout.textBoundingSize.height));
    }];
}

@end
