//
//  LikeTableViewCell.h
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/9/2.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeTableViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView *leftImageView;
@property(strong,nonatomic) NSMutableArray<UIImage *> *likeImages;

@end
