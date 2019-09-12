//
//  AboutUsViewController.m
//  cat
//
//  Created by 王成龙 on 2019/8/9.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "AboutUsViewController.h"
//#import <objc/message.h>"
//#import "CCProxy.h"
#import "CLLockVC.h"

@interface AboutUsViewController ()
//@property (nonatomic,copy) NSString * mStr;
//@property (nonatomic,copy) dispatch_block_t block;
//@property (nonatomic,strong) NSTimer * timer;
//@property (nonatomic,strong) id target;
//@property (nonatomic ,strong)CCProxy *ccProxy;


@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationTitleLabel.text = @"关于我们";
    [self setNavigationTitleLabel];
    [self setBackButton];
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

- (void)creatUI{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 64, 100, 40);
    [button setTitle:@"设置密码" forState:UIControlStateNormal];
    [button setTitleColor:lRGBACOLOR(200, 100, 100, 1) forState:UIControlStateNormal];
    button.tag =100;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame =CGRectMake(0, 164, 100, 40);
    button1.tag =101;
    [button1 setTitle:@"验证密码" forState:UIControlStateNormal];
    [button1 setTitleColor:lRGBACOLOR(200, 100, 100, 1) forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame =CGRectMake(0, 264, 100, 40);
    button2.tag = 102;
    [button2 setTitle:@"修改密码" forState:UIControlStateNormal];
    [button2 setTitleColor:lRGBACOLOR(200, 100, 100, 1) forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    
//   _target = [NSObject new];
//   消息转发机制
//   class_addMethod([_target class],@selector(fire),(IMP)fireIMP,"v@:");
    
//    _ccProxy = [CCProxy alloc];
//    _ccProxy.target = self;
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:_ccProxy selector:@selector(fire) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}
-(void)buttonClicked:(UIButton*)sender{
    if (sender.tag==100) {
//      设置密码
        BOOL hasPwd = [CLLockVC hasPwd];
        hasPwd = NO;
        if(hasPwd){
            
            NSLog(@"已经设置过密码了，你可以验证或者修改密码");
        }else{
            
            [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                CCLog(@"%@",pwd);
                NSLog(@"密码设置成功");
                [lockVC dismiss:1.0f];
            }];
        }
    }else if (sender.tag ==101){
//    验证
        BOOL hasPwd = [CLLockVC hasPwd];
        
        if(!hasPwd){
            
            NSLog(@"你还没有设置密码，请先设置密码");
        }else {
            
            [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
                NSLog(@"忘记密码");
            } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                NSLog(@"密码正确");
                [lockVC dismiss:1.0f];
            }];
        }
    }else {
//        修改密码
        BOOL hasPwd = [CLLockVC hasPwd];
        
        if(!hasPwd){
            
            NSLog(@"你还没有设置密码，请先设置密码");
            
        }else {
            
            [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                
                [lockVC dismiss:.5f];
            }];
        }
    }
    
}
//
//void fireIMP(id self,SEL _cmd){
//    CCLog(@" fireIMP=-----=fire-------");
//}
//
//- (void)fire{
//    CCLog(@"fire-------");
//}

//#pragma mark no1;
//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    if (parent==nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}
#pragma mark no2

-(void)dealloc{
    
    CCLog(@"__dealloc__");
//    [self.timer invalidate];
//    self.timer = nil;
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
