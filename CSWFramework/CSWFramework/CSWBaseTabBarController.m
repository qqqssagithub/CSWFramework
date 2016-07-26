//
//  CSWBaseTabBarController.m
//  CSWFramework
//
//  Created by 007 on 16/5/23.
//  Copyright © 2016年 陈少文. All rights reserved.
//

#import "CSWBaseTabBarController.h"
#import "CSWBaseViewController.h"
#import "CSWBaseNavigationController.h"

@interface CSWBaseTabBarController ()

@end

@implementation CSWBaseTabBarController

- (id)init{
    if (self = [super init]) {
        _navigationTitleFont = nil;
        _navigationTitleColor = nil;
        _navigationBackImage =nil;
        _navigationTintColor = nil;
        _aotuTitle = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initSubViewController{
    NSMutableArray *NCArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < _subVCArray.count; i++) {
        CSWBaseViewController *oneVC = [_subVCArray objectAtIndex:i];
        if (_aotuTitle == YES) {
            oneVC.title = [_titleArray objectAtIndex:i];
        }
        oneVC.tabBarItem.title = [_titleArray objectAtIndex:i];
        oneVC.tabBarItem.image = [[UIImage imageNamed:[_normalImageArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [oneVC.tabBarItem setSelectedImage:[[UIImage imageNamed:[_selectImageArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:244.0/255.0 green:213.0/255.0 blue:39.0/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        UIEdgeInsets insets;
        insets.bottom = -5;
        insets.left = 0;
        insets.right = 0;
        insets.top = 5;
        oneVC.tabBarItem.imageInsets = insets;
        CSWBaseNavigationController *oneNC = [[CSWBaseNavigationController alloc] initWithRootViewController:oneVC];
        [NCArray addObject:oneNC];
    }
    if (_navigationTitleFont != nil) {
        [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:_navigationTitleFont};
    }
    if (_navigationTitleColor != nil) {
        [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:_navigationTitleColor};
    }
    if (_navigationTintColor != nil) {
        [[UINavigationBar appearance] setTintColor:_navigationTintColor];
    }
    [[UINavigationBar appearance] setBackgroundImage:_navigationBackImage forBarMetrics:UIBarMetricsDefault];
    self.viewControllers = NCArray;
}

//-(void)createTabBarItem
//{
//    //按钮的宽度
//    CGFloat width = CSWSCREEN_WIDTH /[_titleArray count];
//    for (int i  = 0; i < _titleArray.count; i ++) {
//        //正常选中的图片
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_normalImageArray objectAtIndex:i]]];
//        //选中状态的图片
//        UIImage *select = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_normalImageArray objectAtIndex:i]]];
//
//        UIButton *item = [self createButtonWithTitle:[_titleArray objectAtIndex:i] frame:CGRectMake(i *width, 0,width, 49) image:image selcetedImage:select target:self action:@selector(buttonDidClicked:)];
//        item.tag = 100 + i;
//        if (i == 0) {
//            item.selected = YES;
//        }
//        [self.tabBar addSubview:item];
//    }
//    //设置选中的ViewController
//    self.selectedIndex = 0;
//
//}

//-(void)buttonDidClicked:(UIButton *)button
//{
//    //之前选中的按钮关闭
//    UIButton *old = (UIButton *)[self.tabBar viewWithTag:100 + self.selectedIndex];
//    old.selected = NO;
//    //将新按钮打开
//    button.selected = YES;
//    self.selectedIndex = button.tag - 100;
//}

//用工厂来创建一个tabBar的自定义按钮
//- (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame image:(UIImage *)image selcetedImage:(UIImage *)selectedImage target:(id)target action:(SEL)selector {
//    //用类方法创建button
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    //设置frame
//    button.frame = frame;
//    //改小字体
//    button.titleLabel.font = [UIFont systemFontOfSize:12.f];
//    //设置title，正常展示状态
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    //设置高亮的title字体颜色
//    //[button setTitleColor:RGB(10,172,183) forState:UIControlStateHighlighted];
//    //设置选中的title字体颜色
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    //正常状态的图片
//    [button setImage:image forState:UIControlStateNormal];
//    //选中状态的图片
//    [button setImage:selectedImage forState:UIControlStateSelected];
//    //高亮状态的图片
//    [button setImage:selectedImage forState:UIControlStateHighlighted];
//    //添加事件
//    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
//    //设置标题的展示位置
//    //UIEdgeInsetsMake(top, left, bottom, right)
//    //参考自己原位置进行增加和减少
//    //    [button setTitleEdgeInsets:UIEdgeInsetsMake(25, -20, 2, 25)];
//    //    [button setTitleEdgeInsets:UIEdgeInsetsMake(29, -40, -1, 20)];
//    //    //设置图片的展示位置
//    //    //参考父视图的位置移动
//    //    [button setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 17, 18)];
//    //将创建的button抛上去
//    return button;
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
