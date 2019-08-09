//
//  AboutUsViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationTitleLabel.text = @"关于我们";
    [self setNavigationTitleLabel];
    [self setBackButton];
    // Do any additional setup after loading the view.
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
