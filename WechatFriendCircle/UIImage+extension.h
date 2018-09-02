//
//  UIImage+extension.h
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/25.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extension)

+ (UIImage *)imageWithColor:(UIColor *)color;
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
