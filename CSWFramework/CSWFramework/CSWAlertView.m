//
//  CSWAlertView.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWAlertView.h"
#import "CSWScreenShot.h"
#import "UIImage+CSWBlur.h"

@implementation CSWAlertView

+ (instancetype)shareCSWAlertView {
    static CSWAlertView *shareCSWAlertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCSWAlertView = [[CSWAlertView alloc] init];
        shareCSWAlertView.backColor = [UIColor whiteColor];
        shareCSWAlertView.isBlur = YES;
        shareCSWAlertView.title = nil;
        shareCSWAlertView.message = nil;
        shareCSWAlertView.cancelButton = nil;
        shareCSWAlertView.otherButton = nil;
    });
    return shareCSWAlertView;
}

+ (instancetype)initWithBackColor:(UIColor *)backColor title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle isBlur:(BOOL)isBlur {
    CSWAlertView *shareCSWAlertView = [CSWAlertView shareCSWAlertView];
    if (title == nil && message == nil) {
        return shareCSWAlertView;
    }
    if (cancelButtonTitle == nil && cancelButtonTitle == nil) {
        return shareCSWAlertView;
    }
    [shareCSWAlertView creatUIWithBackColor:backColor Title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle isBlur:isBlur];
    return shareCSWAlertView;
}

+ (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle {
    CSWAlertView *shareCSWAlertView = [CSWAlertView shareCSWAlertView];
    if (title == nil && message == nil) {
        return shareCSWAlertView;
    }
    if (cancelButtonTitle == nil && cancelButtonTitle == nil) {
        return shareCSWAlertView;
    }
    [shareCSWAlertView creatUIWithBackColor:shareCSWAlertView.backColor Title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle isBlur:shareCSWAlertView.isBlur];
    return shareCSWAlertView;
}

+ (void)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle {
    if (title == nil && message == nil) {
        return;
    }
    if (cancelButtonTitle == nil) {
        return;
    }
    CSWAlertView *shareCSWAlertView = [CSWAlertView shareCSWAlertView];
    [shareCSWAlertView creatUIWithBackColor:shareCSWAlertView.backColor Title:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:nil isBlur:shareCSWAlertView.isBlur];
}

- (void)creatUIWithBackColor:(UIColor *)backColor Title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle isBlur:(BOOL)isBlur {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIWindow *alertWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, CSWSCREEN_WIDTH, CSWSCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];

    CGFloat width;
    if (CSWSCREEN_WIDTH >320) {
        width = CSWSCREEN_WIDTH -120.0;
    } else {
        width = CSWSCREEN_WIDTH -60.0;
    }
    
    //标题和消息
    CGFloat titleHeight = 0;
    CGFloat messageHeight = 0;
    if (title != nil) {
        titleHeight = [self sizeWithFont:17.0 maxWidth:width -24.0 string:title].height;
        //titleHeight = [title sizeWithFont:15.0 maxWidth:width -24].height;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, width -24, titleHeight +2)];
        _title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        _title.numberOfLines = 0;
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = title;
        //_title.backgroundColor = [UIColor redColor];
    }
    if (message != nil) {
        messageHeight = [self sizeWithFont:14 maxWidth:width -24.0 string:message].height;
        //messageHeight = [message sizeWithFont:12.0 maxWidth:width -24].height;
        _message = [[UILabel alloc] initWithFrame:CGRectMake(12, titleHeight +24, width -24, messageHeight +2)];
        if (title == nil) {
            _message.frame = CGRectMake(12, 16, width -24, messageHeight +2);
        }
        _message.font = [UIFont systemFontOfSize:14.0];
        _message.numberOfLines = 0;
        _message.textAlignment = NSTextAlignmentCenter;
        _message.text = message;
        //_message.backgroundColor = [UIColor yellowColor];
    }
    
    //UI
    CGFloat height;
    if (message == nil || title == nil) {
        height = titleHeight +messageHeight +36.0;
    } else {
        height = titleHeight +messageHeight +40.0;
    }
    
    UIImageView *whiteView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height +42.0)];
    //whiteView.backgroundColor = [UIColor redColor];
    whiteView.layer.cornerRadius = 8.0;
    whiteView.userInteractionEnabled = YES;
    whiteView.clipsToBounds = YES;
    whiteView.center = self.center;
    UIImage *tempImage = [CSWScreenShot screenShotWithRect:whiteView.frame];
    whiteView.image = [tempImage blurWithRadius:15.0 tintColor:nil];
    
    if (backColor == nil) {
        backColor = self.backColor;
    }
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height +0.5)];
    topView.backgroundColor = backColor;
    [whiteView addSubview:topView];
    [whiteView addSubview:_title];
    [whiteView addSubview:_message];
    
    //button
    if (otherButtonTitle == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height +1, width, 41)];
    } else {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height +1, width /2.0 -0.2, 41)];
        _otherButton = [[UIButton alloc] initWithFrame:CGRectMake(width /2.0 +0.3, height +1, width /2.0 -0.3, 41)];
        [_otherButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[_otherButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
        [_otherButton setBackgroundImage:[self imageWithColor:backColor] forState:UIControlStateNormal];
        [_otherButton setBackgroundImage:[self imageWithColor:[backColor colorWithAlphaComponent:0.5]] forState:UIControlStateHighlighted];
        
        //_otherButton.backgroundColor = [UIColor blueColor];
        [_otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        [_otherButton addTarget:self action:@selector(otherAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:_otherButton];
    }
    //_cancelButton.backgroundColor = [UIColor orangeColor];
    [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [_cancelButton setBackgroundImage:[self imageWithColor:backColor] forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:[self imageWithColor:[backColor colorWithAlphaComponent:0.5]] forState:UIControlStateHighlighted];
    
    [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:_cancelButton];
    
    whiteView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [self addSubview:whiteView];
    [UIView animateWithDuration:0.15 animations:^{
        whiteView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        if (isBlur == YES) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_cancelButton setBackgroundImage:[self imageWithColor:[backColor colorWithAlphaComponent:0.7]] forState:UIControlStateNormal];
                if (otherButtonTitle != nil) {
                    [_otherButton setBackgroundImage:[self imageWithColor:[backColor colorWithAlphaComponent:0.7]] forState:UIControlStateNormal];
                }
                topView.alpha = 0.7;
            });
        }
    }];
    
    
    [alertWindow addSubview:self];
}

- (CGSize)sizeWithFont:(CGFloat)font maxWidth:(CGFloat)maxWidth string:(NSString *)string{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size =  [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

- (void)otherAction:(id)sender{
    [self removeFromSuperview];
    if (self.otherBlock) {
        self.otherBlock();
    }
}

- (void)cancelAction:(id)sender{
    [self removeFromSuperview];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
