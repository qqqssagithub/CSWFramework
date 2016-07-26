//
//  CSWScreenShot.h
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSWScreenShot : NSObject

/**
 *参数 rect 截图的rect
 */
+ (UIImage *)screenShotWithRect:(CGRect)rect;

@end
