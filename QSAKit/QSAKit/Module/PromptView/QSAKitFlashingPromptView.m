//
//  QSAKitFlashingPromptView.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/3.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "QSAKitFlashingPromptView.h"
#import "NSString+QSAKitSize.h"

@interface QSAKitFlashingPromptView ()

@end

@implementation QSAKitFlashingPromptView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedInstance {
    static QSAKitFlashingPromptView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QSAKitFlashingPromptView alloc] initWithFrame:QSAKit_SCREEN_RECT];
        sharedInstance.defaultMaxWidth = 250.f;
        sharedInstance.defaultMinWidth = 60.f;
        sharedInstance.defaultFont = [UIFont systemFontOfSize:14.0f];
        sharedInstance.defaultSecond = 2.0f;
        sharedInstance.defaultBackgroundTransparency = 0.0;
        sharedInstance.defaultBlurEffectStyle = BlurEffectStyleDark;
        sharedInstance.backgroundColor = [UIColor colorWithWhite:0.0 alpha:sharedInstance.defaultBackgroundTransparency];
    });
    return sharedInstance;
}

+ (void)showWithMessage:(NSString *)message {
    QSAKitFlashingPromptView *view = [QSAKitFlashingPromptView sharedInstance];
    [view creatUIWithMessage:message messageFont:view.defaultFont blurEffectStyle:view.defaultBlurEffectStyle backgroundTransparency:view.defaultBackgroundTransparency];
}

- (void)creatUIWithMessage:(NSString *)message messageFont:(UIFont *)font blurEffectStyle:(BlurEffectStyle)blurEffectStyle backgroundTransparency:(CGFloat)backgroundTransparency {
    self.userInteractionEnabled = NO;
    if ([message isKindOfClass:[NSNull class]] || message.length == 0) {
        message = @"发生未知错误";
    }
    
    CGFloat width = [message calculatedSizeWithFont:_defaultFont maxWidth:_defaultMaxWidth - 24.0].width < _defaultMinWidth ? _defaultMinWidth : [message calculatedSizeWithFont:_defaultFont maxWidth:_defaultMaxWidth - 24.0].width;
    CGFloat height = [message calculatedSizeWithFont:_defaultFont maxWidth:_defaultMaxWidth - 24.0].height;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width + 24, height + 24)];
    
    backView.layer.cornerRadius = 8.0f;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor clearColor];
    backView.center = self.center;
    [self addSubview:backView];
    
    UIBlurEffect *blurEffect;
    if (blurEffectStyle == BlurEffectStyleLight) {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    } else  {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    UIVisualEffectView *backVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    backVisualEffectView.frame = CGRectMake(0, 0, width + 24, height + 24);
    [backView addSubview:backVisualEffectView];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *subVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    subVisualEffectView.frame = CGRectMake(0, 0, width + 24, height + 24);
    [backVisualEffectView.contentView addSubview:subVisualEffectView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, width, height)];
    messageLabel.textAlignment = 1;
    messageLabel.numberOfLines = 0;
    [messageLabel setFont:_defaultFont];
    messageLabel.text = message;
    [subVisualEffectView.contentView addSubview:messageLabel];
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:backgroundTransparency];
    
    [KEYWINDOW addSubview:self];
    
    backView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.15 animations:^{
        backView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_defaultSecond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.15 animations:^{
                backView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
            } completion:^(BOOL finished) {
                [self disappear];
            }];
        });
    }];
}


- (void)disappear {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
