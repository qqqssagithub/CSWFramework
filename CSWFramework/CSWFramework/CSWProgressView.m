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

+ (instancetype)shareCSWProgressView {
    static CSWProgressView *shareCSWProgressView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCSWProgressView = [[CSWProgressView alloc] init];
        shareCSWProgressView.backColor = [UIColor whiteColor];
        shareCSWProgressView.isBlur = YES;
        shareCSWProgressView.activityColor = [UIColor grayColor];
        shareCSWProgressView.promptSize = 14.0;
        shareCSWProgressView.promptColor = [UIColor grayColor];
    });
    return shareCSWProgressView;
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
    UIImage *tempImage = [CSWScreenShot screenShotWithRect:backView.frame];
    backView.image = [tempImage blurWithRadius:10.0 tintColor:nil];
    [self addSubview:backView];
    
    if (backColor == nil) {
        backColor = self.backColor;
    }
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
    topView.backgroundColor = backColor;
    if (isBlur == YES) {
        topView.alpha = 0.6;
    }
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

+ (void)show {
    CSWProgressView *showView = [CSWProgressView shareCSWProgressView];
    [showView creatUIWithPrompt:nil promptSize:0.0 promptColor:nil activityColor:showView.activityColor backColor:showView.backColor isBlur:showView.isBlur];
}

+ (void)showWithPrompt:(NSString *)prompt {
    CSWProgressView *showView = [CSWProgressView shareCSWProgressView];
    [showView creatUIWithPrompt:prompt promptSize:showView.promptSize promptColor:showView.promptColor activityColor:showView.activityColor backColor:showView.backColor isBlur:showView.isBlur];
}

+ (void)showWithPrompt:(NSString *)prompt promptSize:(CGFloat)promptSize promptColor:(UIColor *)promptColor activityColor:(UIColor *)activityColor backColor:(UIColor *)backColor isBlur:(BOOL)isBlur {
    CSWProgressView *showView = [CSWProgressView shareCSWProgressView];
    [showView creatUIWithPrompt:prompt promptSize:promptSize promptColor:promptColor activityColor:activityColor backColor:backColor isBlur:isBlur];
}

+ (void)disappear {
    CSWProgressView *showView = [CSWProgressView shareCSWProgressView];
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
