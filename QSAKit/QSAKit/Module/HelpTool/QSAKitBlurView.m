//
//  QSAKitBlurView.m
//  QSAKit
//
//  Created by 陈少文 on 17/5/2.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "QSAKitBlurView.h"

@interface QSAKitBlurView ()

@property (nonatomic) UIVisualEffectView *backVisualEffectView;
@property (nonatomic) UIVisualEffectView *subVisualEffectView;

@end

@implementation QSAKitBlurView

- (instancetype)initWithFrame:(CGRect)rect type:(QSAKitBlurViewType)type {
    if ([super initWithFrame:rect]) {
        UIBlurEffect *blurEffect;
        if (type == Blur_whiteColor) {
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        } else {
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }
        _backVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _backVisualEffectView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        [self addSubview:_backVisualEffectView];
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        _subVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        _subVisualEffectView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        [_backVisualEffectView.contentView addSubview:_subVisualEffectView];
    }
    return self;
}

- (void)contentViewAddSubview:(UIView *)view {
    [_subVisualEffectView.contentView addSubview:view];
    view.center = _subVisualEffectView.center;
}

@end
