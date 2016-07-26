//
//  CSWScreenShot.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 007. All rights reserved.
//

#import "CSWScreenShot.h"

@implementation CSWScreenShot

+ (UIImage *)screenShotWithRect:(CGRect)rect {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.frame.size, window.opaque, [[UIScreen mainScreen] scale]);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(-rect.origin.x, -rect.origin.y, window.frame.size.width, window.frame.size.height)];
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

@end
