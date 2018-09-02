//
//  FriendCircleTableViewCell.m
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/24.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "FriendCircleTableViewCell.h"
#import <Masonry/Masonry.h>
#import <YYText/YYText.h>
#import "CommentTableViewCell.h"
#import "UIColor+extension.h"
#import "LikeTableViewCell.h"

@implementation FriendCircleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        imageViews = [NSMutableArray arrayWithCapacity:0];
        
        _isCommentOpen = NO;
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_avatarImageView];
        
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
            make.width.height.equalTo(@40);
        }];
        
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLbl.backgroundColor = [UIColor clearColor];
        _nameLbl.textColor = [self nameColor];
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
            make.top.equalTo(self->_contentLbl.mas_bottom).offset(10);
            make.left.equalTo(self->_contentLbl).offset(0);
        }];
        
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"coment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commentBtn];
        
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_timeLbl).offset(-10);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.height.equalTo(@30);
        }];
        
        [self.contentView addSubview:self.commentView];
        [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentBtn);
            make.width.equalTo(@0);
            make.height.equalTo(@50);
            make.right.equalTo(self.commentBtn.mas_left).offset(-5);
        }];
        
        _commentTblView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _commentTblView.delegate = self;
        _commentTblView.dataSource = self;
        _commentTblView.scrollEnabled = NO;
        [_commentTblView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CommentTableViewCell class])];
        [_commentTblView registerClass:[LikeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LikeTableViewCell class])];
        [self.contentView addSubview:_commentTblView];
        
        [_commentTblView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_avatarImageView);
            make.top.equalTo(self->_timeLbl.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@(0));
        }];
    }
    return self;
}

- (UIView *)commentView
{
    if (!_commentView) {
        _commentView = [[UIView alloc] init];
        _commentView.backgroundColor = [self commentViewColor];
        _commentView.layer.cornerRadius = 4.f;
        
        UIButton *likeBtn = [[UIButton alloc] init];
        [likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [likeBtn setTitle:@"赞" forState:UIControlStateNormal];
        [_commentView addSubview:likeBtn];
        _likeBtn = likeBtn;
        
        [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self->_commentView);
            make.width.equalTo(@0);
        }];

        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor whiteColor];
        [_commentView addSubview:lineView];
        _commentLineView = lineView;

        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@0);
            make.centerY.centerX.equalTo(self->_commentView);
        }];
        
        UIButton *commentBtn = [[UIButton alloc] init];
        [commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_commentView addSubview:commentBtn];
        _actualcommentBtn = commentBtn;
        
        [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self->_commentView);
            make.width.equalTo(@0);
        }];
    }
    return _commentView;
}

- (void)setCellModel:(FriendCircleModel *)cellModel{
    
    _cellModel = cellModel;
    self.nameLbl.text = cellModel.name;
    self.avatarImageView.image = [UIImage imageNamed:cellModel.avatarString];
    self.timeLbl.text = cellModel.createdTime;
    self.contentLbl.textLayout = cellModel.contentLayout;
    
    [self.contentLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.contentLbl.textLayout.textBoundingSize.height));
    }];
    
    for (UIImageView *imageView in self.contentView.subviews) {
        if (imageView.tag >=5000) {
            [imageView removeFromSuperview];
        }
    }
    [imageViews removeAllObjects];
    
    //重置label的约束条件，考虑cell复用的情况
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLbl.mas_bottom).offset(10);
        make.left.equalTo(self.contentLbl).offset(0);
    }];
    
    if (cellModel.images.count>0) {
        
        UIImageView *lastImageView;
        
        if (cellModel.images.count>1) {
            
            for (UIImage *image in cellModel.images) {
                NSInteger index = [cellModel.images indexOfObject:image];
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
                imageView.tag = 5000+index;//view.tag默认为0，防止根据tag获取imageView的时候获取到别的视图
                imageView.userInteractionEnabled = YES;
                [self addTapGestureForImageView:imageView];
                [self.contentView addSubview:imageView];
                [imageViews addObject:imageView];
                
                if (!lastImageView) {
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.contentLbl.mas_bottom).offset(10);
                        make.left.equalTo(self.contentLbl);
                        make.width.height.equalTo(@(cellModel.imageHeight));
                    }];
                }
                else
                {
                    if (index%3 == 0){
                        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(lastImageView.mas_bottom).offset(10);
                            make.left.equalTo(self.contentLbl).offset(0);
                            make.width.height.equalTo(@(cellModel.imageHeight));
                        }];
                    }
                    else{
                        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(lastImageView.mas_top).offset(0);
                            make.left.equalTo(lastImageView.mas_right).offset(10);
                            make.width.height.equalTo(@(cellModel.imageHeight));
                        }];
                    }
                }
                
                lastImageView = imageView;
                
            }
            
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:cellModel.images[0]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = 5000+0;
            imageView.userInteractionEnabled = YES;
            [self addTapGestureForImageView:imageView];
            [self.contentView addSubview:imageView];
            [imageViews addObject:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLbl.mas_bottom).offset(10);
                make.left.equalTo(self.contentLbl);
                make.width.height.equalTo(@(cellModel.imageHeight));
            }];
            
            lastImageView = imageView;
        }
        
        [self.timeLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastImageView.mas_bottom).offset(10);
            make.left.equalTo(self.contentLbl).offset(0);
        }];
    }
    
    [self.commentTblView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(cellModel.commentTblViewHeight));
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *trangleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 10, 10)];
    trangleImgView.image = [UIImage imageNamed:@"triangle"];
    trangleImgView.contentMode = UIViewContentModeBottom;
    [headerView addSubview:trangleImgView];
    
    _commentTblView.tableHeaderView = headerView;
    
    [self.commentTblView reloadData];
   
}

- (void)addTapGestureForImageView:(UIImageView *)imageView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [imageView addGestureRecognizer:tap];
}

- (void)tapImage:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.tapImageHandler) {
        self.tapImageHandler(imageView.tag-5000,imageViews);
    }
}

- (void)commentAction:(UIButton *)button{
    self.isCommentOpen = !self.isCommentOpen;
}

- (void)setIsCommentOpen:(BOOL)isCommentOpen{
    if (_isCommentOpen != isCommentOpen) {
        _isCommentOpen = isCommentOpen;
        [self animateCommentWithOpen:isCommentOpen];
    }
}

- (void)animateCommentWithOpen:(BOOL)isOpen{
    [self.contentView bringSubviewToFront:self.commentView];
    if (isOpen) {
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentBtn);
            make.width.equalTo(@150);
            make.height.equalTo(@50);
            make.right.equalTo(self.commentBtn.mas_left).offset(-5);
        }];
        
        [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self->_commentView);
            make.width.equalTo(self.commentView).dividedBy(2).offset(-1);
        }];
        
        [self.commentLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.height.equalTo(@20);
        }];
        
        [self.actualcommentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self->_commentView);
            make.width.equalTo(self.commentView).dividedBy(2).offset(-1);
        }];
    }
    else
    {
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentBtn);
            make.width.equalTo(@0);
            make.height.equalTo(@50);
            make.right.equalTo(self.commentBtn.mas_left).offset(-5);
        }];
        
        [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self->_commentView);
            make.width.equalTo(@0);
        }];
        
        [self.commentLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
            make.height.equalTo(@0);
        }];
        
        [self.actualcommentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self->_commentView);
            make.width.equalTo(@0);
        }];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.cellModel.likeImages.count>0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.cellModel.likeImages.count>0) {
        if (section == 0) {
            return 1;
        }
    }
    return self.cellModel.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellModel.likeImages.count>0) {
        if (indexPath.section == 0) {
            return 50;
        }
    }
    return [self.cellModel commentCellHeightForRow:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellModel.likeImages.count>0) {
        if (indexPath.section == 0) {
            LikeTableViewCell *cell = (LikeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LikeTableViewCell class])];
            cell.likeImages = self.cellModel.likeImages;
            return cell;
        }
    }
    CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentTableViewCell class])];
    cell.cellModel = self.cellModel.commentArray[indexPath.row];
    cell.leftImageView.hidden = indexPath.row != 0;
    return cell;
}

- (UIColor *)commentViewColor{
    return [UIColor colorWithRed:75/255.f green:81/255.f blue:84/255.f alpha:1];
}

- (UIColor *)nameColor{
    return [UIColor colorWithRed:64/255.f green:92/255.f  blue:148/255.f  alpha:1];
}

- (UIColor *)contentColor{
    return [UIColor colorWithRed:62/255.f green:62/255.f  blue:62/255.f  alpha:1];
}

- (UIColor *)timeColor{
    return [UIColor colorWithRed:208/255.f green:208/255.f  blue:208/255.f  alpha:1];
}

- (UIColor *)commentColor{
    return [UIColor colorWithRed:239/255.f green:239/255.f  blue:241/255.f  alpha:1];
}

@end
