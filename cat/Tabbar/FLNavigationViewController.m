//
//  FLNavigationViewController.m
//  FireLife
//
//  Created by 王成龙 on 2018/6/28.
//  Copyright © 2018年 charlie. All rights reserved.
//

#import "FLNavigationViewController.h"

@interface FLNavigationViewController ()

@end

@implementation FLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景色
    self.navigationBar.barTintColor = NAVIGATIONBAR_COLOR;
    //修改UIBarButtonItem 图片 title颜色
//    self.navigationBar.tintColor = [UIColor greenColor];
    //是否半透明 当为YES时 设置的导航栏背景颜色会和实际rgb值有误差
    self.navigationBar.translucent = NO;
    UIColor * color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes= dict;
    
    // Do any additional setup after loading the view.
}

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
