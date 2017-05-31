//
//  QSAKitBaseTabBarController.m
//  QSAKit
//
//  Created by 陈少文 on 17/2/3.
//  Copyright © 2017年 qqqssa. All rights reserved.
//

#import "QSAKitBaseTabBarController.h"
#import "QSAKitBaseViewController.h"

@interface QSAKitBaseTabBarController ()

@end

@implementation QSAKitBaseTabBarController

- (instancetype)init{
    if (self = [super init]) {
        _navigationTitleFont  = [UIFont systemFontOfSize:15.0];
        _navigationTitleColor = [UIColor blackColor];
        _navigationBackImage  = nil;
        _navigationTintColor  = [UIColor blackColor];
        _aotuTitle = YES;
        _normalColor = [UIColor blackColor];
        _selectColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 初始化所有子视图
- (void)initSubViewController {
    NSMutableArray *NCArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < _subVCArray.count; i++) {
        QSAKitBaseViewController *oneVC = [_subVCArray objectAtIndex:i];
        if (_aotuTitle == YES) {
            oneVC.title = [_titleArray objectAtIndex:i];
        }
        oneVC.tabBarItem.title = [_titleArray objectAtIndex:i];
        oneVC.tabBarItem.image = [[UIImage imageNamed:[_normalImageArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [oneVC.tabBarItem setSelectedImage:[[UIImage imageNamed:[_selectImageArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_normalColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        UIEdgeInsets insets;
        insets.bottom = -5;
        insets.left = 0;
        insets.right = 0;
        insets.top = 5;
        oneVC.tabBarItem.imageInsets = insets;
        UINavigationController *oneNC = [[UINavigationController alloc] initWithRootViewController:oneVC];
        [NCArray addObject:oneNC];
    }
    [UINavigationBar appearance].barStyle = _navigationBarStyle;
    if (_navigationTitleFont != nil) {
        [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:_navigationTitleFont};
    }
    if (_navigationTitleColor != nil) {
        [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:_navigationTitleColor};
    }
    if (_navigationTintColor != nil) {
        [[UINavigationBar appearance] setTintColor:_navigationTintColor];
    }
    if (_navigationBackImage != nil) {
        [[UINavigationBar appearance] setBackgroundImage:_navigationBackImage forBarMetrics:UIBarMetricsDefault];
    }
    self.viewControllers = NCArray;
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
