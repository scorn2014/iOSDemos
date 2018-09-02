//
//  FriendCircleTableViewCell.h
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/24.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYText.h>
#import "FriendCircleModel.h"

typedef void(^TapImageHandler)(NSInteger index,NSArray *imageViews);

@interface FriendCircleTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *imageViews;
}
@property(strong,nonatomic) UIImageView *avatarImageView;
@property(strong,nonatomic) UILabel *nameLbl;
@property(strong,nonatomic) YYLabel *contentLbl;
@property(strong,nonatomic) UILabel *timeLbl;
@property(strong,nonatomic) UIButton *commentBtn;
@property(strong,nonatomic) FriendCircleModel *cellModel;
@property(strong,nonatomic) UITableView *commentTblView;
@property(copy,nonatomic) TapImageHandler tapImageHandler;
@property(strong,nonatomic) UIView *commentView;
@property(strong,nonatomic) UIButton *likeBtn;
@property(strong,nonatomic) UIButton *actualcommentBtn;
@property(strong,nonatomic) UIView *commentLineView;
@property(assign,nonatomic) BOOL isCommentOpen;

- (void)animateCommentWithOpen:(BOOL)isOpen;

@end
