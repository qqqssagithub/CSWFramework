//
//  QSAKitBaseViewController.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/3.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "QSAKitBaseViewController.h"

@interface QSAKitBaseViewController ()

@end

@implementation QSAKitBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 左侧按钮
-(void)setLeftButtonWithImage:(UIImage *)image Action:(SEL)action{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)setLeftButtonWithTitle:(NSString *)title Action:(SEL)action{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 右侧按钮
-(void)setRightButtonWithImage:(UIImage *)image Action:(SEL)action{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

-(void)setRightButtonWithTitle:(NSString *)title Action:(SEL)action{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
