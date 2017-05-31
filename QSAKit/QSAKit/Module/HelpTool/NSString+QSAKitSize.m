//
//  NSString+QSAKitSize.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/4.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "NSString+QSAKitSize.h"

@implementation NSString (QSAKitSize)

- (CGSize)calculatedSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    if (self == nil) {
        return CGSizeMake(0.0, 0.0);
    }
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
