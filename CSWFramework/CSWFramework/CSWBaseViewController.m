//
//  CSWBaseViewController.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWBaseViewController.h"

@interface CSWBaseViewController ()

@end

@implementation CSWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//设置导航栏左侧按钮(自定义图片或文字和触发方法)
-(void)setLeftButtonWithImage:(UIImage *)image Action:(SEL)action{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)setLeftButtonWithTitle:(NSString *)title Action:(SEL)action{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//配置导航栏左侧按钮文字样式
//-(void)setLeftTitleConfigureWithFont:(UIFont *)textFont TextNormalColor:(UIColor *)normalColor TextSelectColor:(UIColor *)selectColor{
//
//}

//设置导航栏右侧按钮(自定义图片或文字和触发方法)
-(void)setRightButtonWithImage:(UIImage *)image Action:(SEL)action{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

-(void)setRightButtonWithTitle:(NSString *)title Action:(SEL)action{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//配置导航栏右侧按钮文字样式
//-(void)setRightTitleConfigureWithFont:(UIFont *)textFont TextNormalColor:(UIColor *)normalColor TextSelectColor:(UIColor *)selectColor{
//
//}

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
