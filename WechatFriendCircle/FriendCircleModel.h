//
//  FriendCircleModel.h
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/26.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYText/YYText.h>

@interface CommentModel : NSObject

@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *avatarString;
@property(copy,nonatomic) NSString *content;
@property(copy,nonatomic) NSString *createdTime;
@property(strong,nonatomic,readonly) YYTextLayout *contentLayout;

@end

@interface FriendCircleModel : NSObject

@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *avatarString;
@property(copy,nonatomic) NSString *content;
@property(copy,nonatomic) NSString *createdTime;
@property(strong,nonatomic,readonly) YYTextLayout *contentLayout;
@property(strong,nonatomic) NSMutableArray<CommentModel *> *commentArray;
@property(assign,nonatomic,readonly) CGFloat commentTblViewHeight;
@property(strong,nonatomic) NSMutableArray<UIImage *> *images;
@property(assign,nonatomic,readonly) CGFloat imagesHeight;
@property(assign,nonatomic,readonly) CGFloat imageHeight;
@property(strong,nonatomic) NSMutableArray<UIImage *> *likeImages;

- (CGFloat)commentCellHeightForRow:(NSInteger)row;

@end


