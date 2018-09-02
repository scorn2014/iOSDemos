//
//  FriendCircleModel.m
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/26.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "FriendCircleModel.h"
#import "UIImage+extension.h"

@implementation FriendCircleModel

@synthesize imageHeight = _imageHeight;

- (YYTextLayout *)contentLayout{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.content];
    text.yy_font = [UIFont systemFontOfSize:17];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 3;
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize size = CGSizeMake(screenWidth-70, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    return layout;
}

- (CGFloat)commentTblViewHeight{
    NSInteger commentCount = self.commentArray.count;
    CGFloat totalHeight = 0;
    
    if (self.likeImages.count>0 || self.commentArray.count>0) {
        totalHeight = totalHeight + 10;
    }
    
    if (self.likeImages.count>0) {
        totalHeight = totalHeight + 50;
    }
    if (self.commentArray.count) {
        totalHeight = totalHeight + 10;
        for (int i=0; i<commentCount; i++) {
            CGFloat cellHeight = [self commentCellHeightForRow:i];
            totalHeight += cellHeight;
        }
    }
    return totalHeight;
}

- (CGFloat)commentCellHeightForRow:(NSInteger)row{
    
    CGFloat height = 0;
    
    if (self.commentArray.count>0) {
        CommentModel *comment = self.commentArray[row];
        height = 10 + 20+ 10 + comment.contentLayout.textBoundingSize.height + 10;
    }
    return height;
}

- (CGFloat)imagesHeight{
    CGFloat height = 0;
    if (self.images.count>0) {
        if (self.images.count>1) {
            
            _imageHeight = 60;
            CGFloat imgWidth = _imageHeight;
            NSInteger lineCount = self.images.count/3;
            if (self.images.count%3 !=0) {
                lineCount++;
            }
            height = lineCount * imgWidth + (lineCount-1)*10;
        }
        else{
            _imageHeight = 80;
            UIImage *image = self.images[0];
            UIImage *compressedImage = [UIImage imageCompressForWidth:image targetWidth:_imageHeight];
            height = compressedImage.size.height;
        }
    }
    return height;
}

- (CGFloat)imageHeight{
    
    if (self.images.count>1) {
        _imageHeight = 60;
    }
    else
    {
        _imageHeight = 80;
    }
    return _imageHeight;
}

@end

@implementation CommentModel

- (YYTextLayout *)contentLayout{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.content];
    text.yy_font = [UIFont systemFontOfSize:17];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 3;
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize size = CGSizeMake(screenWidth-95, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    return layout;
}

@end
