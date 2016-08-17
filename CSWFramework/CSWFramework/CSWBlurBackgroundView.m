//
//  CSWBlurBackgroundView.m
//  CSWFramework
//
//  Created by 陈少文 on 16/8/15.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWBlurBackgroundView.h"

@interface CSWBlurBackgroundView ()

@property (nonatomic) UIVisualEffectView *backVisualEffectView;
@property (nonatomic) UIVisualEffectView *subVisualEffectView;

@end

@implementation CSWBlurBackgroundView

- (instancetype)initWithFrame:(CGRect)rect color:(CSWBlurBackgroundViewBackgroundColor)color {
    if ([super initWithFrame:rect]) {
        UIBlurEffect *blurEffect;
        if (color == whiteColor) {
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

- (void)addEffectView:(UIView *)view {
    [_subVisualEffectView.contentView addSubview:view];
    view.center = _backVisualEffectView.center;
}

@end
