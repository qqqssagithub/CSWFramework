//
//  QSAKitAlertView.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/3.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "QSAKitAlertView.h"
#import "NSString+QSAKitSize.h"

@interface QSAKitAlertView ()

@property (nonatomic) UIView *cancelButtonbackView;
@property (nonatomic) UIView *otherButtonbackView;

@end

@implementation QSAKitAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedInstance {
    static QSAKitAlertView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QSAKitAlertView alloc] initWithFrame:QSAKit_SCREEN_RECT];
        sharedInstance.defaultWidth = 250.f;
        sharedInstance.defaultTitleFont = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        sharedInstance.defaultMessageFont = [UIFont systemFontOfSize:12.0f];
        sharedInstance.defaultBlurEffectStyle = BlurEffectStyleLight;
        sharedInstance.defaultBackgroundTransparency = 0.3f;
    });
    return sharedInstance;
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    [[QSAKitAlertView sharedInstance] showWithTitle:title message:message additionalView:nil cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message additionalView:(UIView *)additionalView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    [[QSAKitAlertView sharedInstance] showWithTitle:title message:message additionalView:additionalView cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
}

- (void)showWithTitle:(NSString *)title message:(NSString *)message additionalView:(UIView *)additionalView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:_defaultBackgroundTransparency];
    
    CGFloat height0 = [title calculatedSizeWithFont:_defaultTitleFont maxWidth:_defaultWidth - 24].height;
    CGFloat height1 = [message calculatedSizeWithFont:_defaultMessageFont maxWidth:_defaultWidth - 24].height;
    CGFloat height2 = additionalView.frame.size.height;
    
    UIBlurEffect *blurEffect;
    if (_defaultBlurEffectStyle == BlurEffectStyleLight) {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    } else  {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    
    UIVisualEffectView *backView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (height0 != 0 && height1 != 0) {
        backView.frame = CGRectMake(0, 0, _defaultWidth, height0 + height1 + 12 * 3 + 1 + 40);
    } else {
        backView.frame = CGRectMake(0, 0, _defaultWidth, height0 + height1 + 12 * 2 + 1 + 40);
    }
    
    if (height2 != 0) {
        backView.frame = CGRectMake(0, 0, _defaultWidth, backView.frame.size.height + height2);
    }
    
    backView.layer.cornerRadius = 14.0f;
    backView.layer.masksToBounds = YES;
    backView.center = self.center;
    [self addSubview:backView];
        
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    topView.frame = CGRectMake(0, 0, _defaultWidth, backView.frame.size.height - 41);
    [backView addSubview:topView];
    
    if (height0 != 0) {
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, _defaultWidth - 24, height0)];
        titleL.text = title;
        [titleL setFont:_defaultTitleFont];
        titleL.textAlignment = 1;
        titleL.numberOfLines = 0;
        [topView addSubview:titleL];
    }
    
    if (height1 != 0) {
        CGFloat y;
        if (title != nil) {
            y = 12 + 12 + height0;
        } else {
            y = 12;
        }
        UILabel *messageL = [[UILabel alloc] initWithFrame:CGRectMake(12, y, _defaultWidth - 24, height1)];
        messageL.text = message;
        [messageL setFont:_defaultMessageFont];
        messageL.textAlignment = 1;
        messageL.numberOfLines = 0;
        [topView addSubview:messageL];
    }
    
    if (height2 != 0) {
        additionalView.frame = CGRectMake(0, topView.frame.size.height - height2, additionalView.frame.size.width, additionalView.frame.size.height);
        [topView addSubview:additionalView];
    }
    
    if (otherButtonTitle == nil) {
        _cancelButtonbackView = [[UIView alloc] init];
        _cancelButtonbackView.frame = CGRectMake(0, backView.frame.size.height - 40, _defaultWidth, 40);
        _cancelButton = [[UIButton alloc] initWithFrame:_cancelButtonbackView.frame];
        [backView addSubview:_cancelButtonbackView];
        [backView addSubview:_cancelButton];
    } else {
        _cancelButtonbackView = [[UIView alloc] init];
        _cancelButtonbackView.frame = CGRectMake(0, backView.frame.size.height - 40, _defaultWidth / 2 - 0.5, 40);
        _cancelButton = [[UIButton alloc] initWithFrame:_cancelButtonbackView.frame];
        [backView addSubview:_cancelButtonbackView];
        [backView addSubview:_cancelButton];
        
        _otherButtonbackView = [[UIView alloc] init];
        _otherButtonbackView.backgroundColor = [UIColor whiteColor];
        _otherButtonbackView.alpha = 0.6;
        _otherButtonbackView.frame = CGRectMake(_defaultWidth / 2 + 0.5, backView.frame.size.height - 40, _defaultWidth / 2 - 0.5, 40);
        _otherButton = [[UIButton alloc] initWithFrame:_otherButtonbackView.frame];
        [backView addSubview:_otherButtonbackView];
        [backView addSubview:_otherButton];
        [_otherButton.titleLabel setFont:[UIFont systemFontOfSize:_defaultTitleFont.pointSize]];
        [_otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        [_otherButton addTarget:self action:@selector(otherAction:) forControlEvents:UIControlEventTouchUpInside];
        [_otherButton addTarget:self action:@selector(otherActionDown:) forControlEvents:UIControlEventTouchDown];
    }
    
    _cancelButtonbackView.backgroundColor = [UIColor whiteColor];
    _cancelButtonbackView.alpha = 0.6;
    
    [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:_defaultTitleFont.pointSize]];
    [_cancelButton setTitleColor:[UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton addTarget:self action:@selector(cancelActionDown:) forControlEvents:UIControlEventTouchDown];
    
    [KEYWINDOW addSubview:self];
    
    backView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.2 animations:^{
        backView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            backView.backgroundColor = [UIColor clearColor];
        });
    }];
}

- (void)otherActionDown:(id)sender{ //other按钮按下时的方法
    _otherButtonbackView.alpha = 0.4;
}

- (void)otherAction:(id)sender{ //在other按钮内部弹起的方法
    _otherButtonbackView.alpha = 0.6;
    [self removeSub];
    if (self.otherBlock) {
        self.otherBlock();
        self.otherBlock = nil;
    }
}

- (void)cancelActionDown:(id)sender{ //cancel按钮按下时的方法
    _cancelButtonbackView.alpha = 0.4;
}

- (void)cancelAction:(id)sender{ //在cancel按钮内部弹起的方法
    _cancelButtonbackView.alpha = 0.6;
    [self removeSub];
    if (self.cancelBlock) {
        self.cancelBlock();
        self.cancelBlock = nil;
    }
}

- (void)removeSub {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
