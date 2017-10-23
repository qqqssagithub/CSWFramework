//
//  UIImage+QSAKitStretching.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/3.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "UIImage+QSAKitStretching.h"

@implementation UIImage (QSAKitStretching)

+ (UIImage *)resizableImage0:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2 + 1, image.size.width/2 + 1);
    return [image resizableImageWithCapInsets:insets];
}

+ (UIImage *)resizableImage1:(UIImage *)image {
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2 + 1, image.size.width/2 + 1);
    return [image resizableImageWithCapInsets:insets];
}

@end
