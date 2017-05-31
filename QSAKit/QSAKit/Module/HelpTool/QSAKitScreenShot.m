//
//  QSAKitScreenShot.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/3.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "QSAKitScreenShot.h"

@implementation QSAKitScreenShot

+ (UIImage *)screenShotWithView:(UIView *)view rect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, view.opaque, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(-rect.origin.x, -rect.origin.y, view.frame.size.width, view.frame.size.height)];
    imageV.image = image;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [backView addSubview:imageV];
    [backView setClipsToBounds:YES];
    
    UIGraphicsBeginImageContextWithOptions(backView.frame.size, backView.opaque, [[UIScreen mainScreen] scale]);
    [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image0 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image0;
}

+ (UIImage *)screenShotWithRect:(CGRect)rect {
    return [self screenShotWithView:KEYWINDOW rect:rect];
}

@end
