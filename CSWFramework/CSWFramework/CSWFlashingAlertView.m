//
//  CSWFlashingAlertView.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWFlashingAlertView.h"
#import "CSWScreenShot.h"
#import "UIImage+CSWBlur.h"

@implementation CSWFlashingAlertView

+ (instancetype)shareCSWFlashingAlertView {
    static CSWFlashingAlertView *shareCSWFlashingAlertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCSWFlashingAlertView = [[CSWFlashingAlertView alloc] init];
        shareCSWFlashingAlertView.backColor = [UIColor whiteColor];
        shareCSWFlashingAlertView.isBlur = YES;
        shareCSWFlashingAlertView.textColor = [UIColor blackColor];
        shareCSWFlashingAlertView.textSize = 14.0;
        shareCSWFlashingAlertView.lostTime = 2;
    });
    return shareCSWFlashingAlertView;
}

+ (void)initWithMessage:(NSString *)message {
    CSWFlashingAlertView *shareCSWFlashingAlertView = [CSWFlashingAlertView shareCSWFlashingAlertView];
    [shareCSWFlashingAlertView creatUIWithMessage:message backColor:shareCSWFlashingAlertView.backColor textColor:shareCSWFlashingAlertView.textColor textSize:shareCSWFlashingAlertView.textSize lostTime:shareCSWFlashingAlertView.lostTime isBlur:shareCSWFlashingAlertView.isBlur];
}

+ (void)initWithMessage:(NSString *)message backColor:(UIColor *)backColor textColor:(UIColor *)textColor textSize:(CGFloat)textSize lostTime:(NSInteger)lostTime isBlur:(BOOL)isBlur {
    CSWFlashingAlertView *shareCSWFlashingAlertView = [CSWFlashingAlertView shareCSWFlashingAlertView];
    [shareCSWFlashingAlertView creatUIWithMessage:message backColor:backColor textColor:textColor textSize:textSize lostTime:lostTime isBlur:isBlur];
}

- (void)creatUIWithMessage:(NSString *)message backColor:(UIColor *)backColor textColor:(UIColor *)textColor textSize:(CGFloat)textSize lostTime:(NSInteger)lostTime isBlur:(BOOL)isBlur {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.frame = CGRectMake(0, 0, CSWSCREEN_WIDTH, CSWSCREEN_HEIGHT);
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:textSize]};
    CGSize size =  [message boundingRectWithSize:CGSizeMake(CSWSCREEN_WIDTH -48 -24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 0, size.width +24, size.height +24)];
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
    [backView addSubview:topView];
    
    UILabel *netLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, size.width, size.height)];
    netLabel.numberOfLines = 0;
    [netLabel setFont:[UIFont systemFontOfSize:textSize]];
    netLabel.text = message;
    netLabel.textAlignment = NSTextAlignmentCenter;

    if (textColor == nil) {
        textColor = self.textColor;
    }
    netLabel.textColor = textColor;
    [backView addSubview:netLabel];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    backView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.15 animations:^{
        backView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        if (isBlur == YES) {
            topView.alpha = 0.6;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(lostTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.15 animations:^{
                backView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        });
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
