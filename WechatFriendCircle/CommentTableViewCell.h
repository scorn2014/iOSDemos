//
//  CommentTableViewCell.h
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/26.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYText.h>
#import "FriendCircleModel.h"

@interface CommentTableViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView *leftImageView;
@property(strong,nonatomic) UIImageView *avatarImageView;
@property(strong,nonatomic) UILabel *nameLbl;
@property(strong,nonatomic) YYLabel *contentLbl;
@property(strong,nonatomic) UILabel *timeLbl;
@property(strong,nonatomic) CommentModel *cellModel;

@end
