//
//  GesturesPasswordViewController.m
//  cat
//
//  Created by 王成龙 on 2019/9/11.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "GesturesPasswordViewController.h"
#import "SSGestureLockView.h"

@interface GesturesPasswordViewController ()<SSGestureLockViewDelegate>

@property (nonatomic ,copy) NSString * password;
@property (nonatomic ,strong) SSGestureLockView *gestureLockView;

@end

@implementation GesturesPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置手势密码";
    
    _password = @"14789";

    [self.view addSubview:self.gestureLockView];
    __weak typeof(self) weakSelf = self;
    [self.gestureLockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(lSCREEN_WIDTH-50, lSCREEN_WIDTH-50));
    }];
    
    // Do any additional setup after loading the view.
}
#pragma mark 手势密码的代理方法
- (void)didSelectedGestureLockView:(SSGestureLockView *)gestureLockView keyNumStr:(NSString *)keyNumStr{
   
    NSLog(@"[key]:%@",keyNumStr);
    CCLog(@"[lenth]:%lu",(unsigned long)keyNumStr.length);
    if (![keyNumStr isEqualToString:_password]) {
        gestureLockView.showErrorStatus = YES;
    }else{
        NSLog(@"密码正确");
    }
    
}

-(SSGestureLockView *)gestureLockView{
    if (!_gestureLockView) {
        _gestureLockView = [[SSGestureLockView alloc]initWithFrame:CGRectZero];
        _gestureLockView.delegate = self;
    }
    return _gestureLockView;
    
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
