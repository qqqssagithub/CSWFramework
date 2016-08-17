//
//  CSWProgressView.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWProgressView.h"
#import "CSWScreenShot.h"
#import "UIImage+CSWBlur.h"

@interface CSWProgressView ()

@property (nonatomic) BOOL isShow;

@end

@implementation CSWProgressView

+ (instancetype)sharedCSWProgressView {
    static CSWProgressView *sharedCSWProgressView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCSWProgressView = [[CSWProgressView alloc] init];
        sharedCSWProgressView.backColor = [UIColor whiteColor];
        sharedCSWProgressView.isBlur = YES;
        sharedCSWProgressView.activityColor = [UIColor grayColor];
        sharedCSWProgressView.promptSize = 14.0;
        sharedCSWProgressView.promptColor = [UIColor grayColor];
    });
    return sharedCSWProgressView;
}

- (void)creatUIWithPrompt:(NSString *)prompt promptSize:(CGFloat)promptSize promptColor:(UIColor *)promptColor activityColor:(UIColor *)activityColor backColor:(UIColor *)backColor isBlur:(BOOL)isBlur {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.isShow = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, CSWSCREEN_WIDTH, CSWSCREEN_HEIGHT);
    self.backgroundColor = [UIColor clearColor];
    [keyWindow addSubview:self];
    
    UIImageView *backView;
    CGFloat width = 80 -48;
    UILabel *promptLabel = nil;
    if (prompt == nil) {
        backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width +48, 80)];
    } else {
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:promptSize]};
        CGSize size =  [prompt boundingRectWithSize:CGSizeMake(180, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        if (size.width < size.height +80 +24 -48) {
            width = size.height +80 +24 -48;
        } else {
            width = size.width;
        }
        backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width +48, size.height +80 +24)];
        promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 80, width, size.height)];
        promptLabel.font = [UIFont systemFontOfSize:promptSize];
        promptLabel.numberOfLines = 0;
        promptLabel.textAlignment = NSTextAlignmentCenter;
        if (promptColor == nil) {
            promptColor = self.promptColor;
        }
        promptLabel.textColor = promptColor;
        promptLabel.text = prompt;
    }
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    backView.center = self.center;
    backView.backgroundColor = [UIColor whiteColor];
    
    if (isBlur == YES) {
        UIImage *tempImage = [CSWScreenShot screenShotWithRect:backView.frame];
        backView.image = [tempImage blurWithRadius:10.0 tintColor:nil];
    }
    
    [self addSubview:backView];
    
    if (backColor == nil) {
        backColor = self.backColor;
    }
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
    topView.backgroundColor = backColor;
    topView.alpha = 0.6;
    [backView addSubview:topView];
    
    
    UIActivityIndicatorView *AIView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    AIView.frame = CGRectMake(0, 0, width +48, 80);
    AIView.backgroundColor = [UIColor clearColor];
    if (activityColor == nil) {
        activityColor = self.activityColor;
    }
    AIView.color = activityColor;
    [backView addSubview:AIView];
    [AIView startAnimating];
    
    if (prompt != nil) {
        [backView addSubview:promptLabel];
    }
}

- (void)creatUIWithActivityColor:(UIColor *)activityColor {
    self.isShow = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, CSWSCREEN_WIDTH, CSWSCREEN_HEIGHT);
    self.backgroundColor = [UIColor clearColor];
    [keyWindow addSubview:self];
    
    CGFloat width = 120;
    UIBlurEffect *blurEffect;
    if (_systemIsBlackColor) {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    } else {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    UIVisualEffectView *backVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    backVisualEffectView.frame = CGRectMake(0, 0, width, width);
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *subVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    subVisualEffectView.frame = backVisualEffectView.frame;
    [backVisualEffectView.contentView addSubview:subVisualEffectView];
    
    backVisualEffectView.layer.cornerRadius = 5;
    backVisualEffectView.layer.masksToBounds = YES;
    backVisualEffectView.center = self.center;
    
    [self addSubview:backVisualEffectView];
    
    UIActivityIndicatorView *AIView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    AIView.frame = CGRectMake(0, 0, width, width);
    AIView.backgroundColor = [UIColor clearColor];
    if (activityColor == nil) {
        activityColor = self.activityColor;
    }
    AIView.color = activityColor;
    [subVisualEffectView.contentView addSubview:AIView];
    [AIView startAnimating];
}

+ (void)showSystem {
    CSWProgressView *showView = [CSWProgressView sharedCSWProgressView];
    [showView creatUIWithActivityColor:showView.activityColor];
}

+ (void)show {
    CSWProgressView *showView = [CSWProgressView sharedCSWProgressView];
    [showView creatUIWithPrompt:nil promptSize:0.0 promptColor:nil activityColor:showView.activityColor backColor:showView.backColor isBlur:showView.isBlur];
}

+ (void)showWithPrompt:(NSString *)prompt {
    CSWProgressView *showView = [CSWProgressView sharedCSWProgressView];
    [showView creatUIWithPrompt:prompt promptSize:showView.promptSize promptColor:showView.promptColor activityColor:showView.activityColor backColor:showView.backColor isBlur:showView.isBlur];
}

+ (void)showWithPrompt:(NSString *)prompt promptSize:(CGFloat)promptSize promptColor:(UIColor *)promptColor activityColor:(UIColor *)activityColor backColor:(UIColor *)backColor isBlur:(BOOL)isBlur {
    CSWProgressView *showView = [CSWProgressView sharedCSWProgressView];
    [showView creatUIWithPrompt:prompt promptSize:promptSize promptColor:promptColor activityColor:activityColor backColor:backColor isBlur:isBlur];
}

+ (void)disappear {
    CSWProgressView *showView = [CSWProgressView sharedCSWProgressView];
    if (showView.isShow == YES) {
        [showView removeFromSuperview];
        showView = nil;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
