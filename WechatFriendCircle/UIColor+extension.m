//
//  UIColor+extension.m
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/26.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "UIColor+extension.h"

@implementation UIColor (extension)

+ (UIColor *)nameColor{
    return [UIColor colorWithRed:64/255.f green:92/255.f  blue:148/255.f  alpha:1];
}

+ (UIColor *)contentColor{
    return [UIColor colorWithRed:62/255.f green:62/255.f  blue:62/255.f  alpha:1];
}

+ (UIColor *)timeColor{
    return [UIColor colorWithRed:208/255.f green:208/255.f  blue:208/255.f  alpha:1];
}

+ (UIColor *)commentColor{
    return [UIColor colorWithRed:239/255.f green:239/255.f  blue:241/255.f  alpha:1];
}

@end
