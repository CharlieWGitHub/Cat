//
//  GestureLockView.m
//  cat
//
//  Created by 王成龙 on 2019/9/11.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "GestureLockView.h"
#import "CLLockVC.h"
#import "FLTabBarViewController.h"

#import "SSGestureLockView.h"
#import "KeychainManager.h"

@interface GestureLockView ()<SSGestureLockViewDelegate>

@property (nonatomic ,strong) SSGestureLockView *gestureLockView;
@property (nonatomic ,copy  ) NSString *password;
@property (nonatomic ,copy  ) NSString *verifyPassword;
@property (nonatomic ,strong) UILabel * infoLable;//提示文字
@property (nonatomic ,strong) UIImageView * headImage;//头像
@property (nonatomic ,strong) UIView * smallView;//头像
@property (nonatomic ,strong) NSMutableArray * smallViewArray;//头像


@end

@implementation GestureLockView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatGessture];
    self.navigationTitleLabel.text = @"设置手势密码";
    [self setNavigationTitleLabel];
    [self setBackButton];
    [self makeNineBox];
}

//- (void)makeGessture{
//    BOOL hasPwd = [CLLockVC hasPwd];
//    if (hasPwd) {
//        CCLog(@"【走到这里了】---%@",hasPwd?@"yes":@"no");
//        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
//            CCLog(@"忘记密码");
//        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
//            CCLog(@"密码正确");
//            FLTabBarViewController *main = [[FLTabBarViewController alloc] init];
//            [UIApplication sharedApplication].keyWindow.rootViewController = main;
//            [lockVC dismiss:1.0f];
//        }];
//    }else{
//        CCLog(@"【走到这里了✌️✌️✌️】---%@",hasPwd?@"yes":@"no");
//    }
//}

- (void)makeNineBox{
    
    //每个Item宽高
    CGFloat W = 10;
    CGFloat H = 10;
    //每行列数
    NSInteger rank = 3;
    //每列间距
    CGFloat rankMargin = 5;
//    (self.view.frame.size.width - rank * W) / (rank - 1);
    //每行间距
    CGFloat rowMargin = 5;
    //Item索引 ->根据需求改变索引
    NSUInteger index = 9;
    
    for (int i = 0 ; i< index; i++) {
        //Item X轴
        CGFloat X = (i % rank) * (W + rankMargin)+5;
        //Item Y轴
        NSUInteger Y = (i / rank) * (H +rowMargin);
        //Item top
        CGFloat top = 5;
        UIView *speedView = [[UIView alloc] init];
        speedView.backgroundColor = [UIColor colorWithHexString:@"0xfff"];
        speedView.frame = CGRectMake(X, Y+top, W, H);
        speedView.layer.cornerRadius = 5;
        speedView.layer.masksToBounds = YES;
        speedView.layer.borderWidth = 1;
        speedView.layer.borderColor = [UIColor colorWithHexString:@"0xD3D3D3"].CGColor;
        speedView.tag = i+1;
        [self.smallViewArray addObject:speedView];
        [self.smallView addSubview:speedView];
    }
}
- (void)updateSmallView:(NSString *)numberStr{

    NSMutableArray *arr = [NSMutableArray array];
    NSData *data = [numberStr dataUsingEncoding:NSUTF8StringEncoding];
    Byte *byte = (Byte *)[data bytes];
    for (NSInteger i = 0; i < [data length]; i++) {
        //在Ascll中48~57代表的就是数字0~9
        [arr addObject:[NSString stringWithFormat:@"%d",byte[i] - 48]];
    }
    for (NSInteger i=0; i<arr.count; i++) {
        CCLog(@"i=%@",arr[i]);
        for (UIView * view in self.smallViewArray) {
            CCLog(@"j=%ld",(long)view.tag);
            if ([arr[i] isEqualToString:[NSString stringWithFormat:@"%ld",(long)view.tag]]) {
                view.backgroundColor = [UIColor colorWithHexString:@"0x1E90FF"];
                break;
            }
        }
    }
    CCLog(@"[arr=]%@",arr);
}
- (void)creatGessture{
    WEAK_SELF;
    [self.view addSubview:self.gestureLockView];
    [self.gestureLockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(240*kWScale, 240*kWScale));
    }];
    [self.view addSubview:self.infoLable];
    [self.infoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.gestureLockView.mas_top).offset(-5);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(lSCREEN_WIDTH, 25));
    }];
    [self.view addSubview:self.smallView];
    [self.smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.infoLable.mas_top).offset(-5);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

#pragma mark 解锁图案delegate
- (void)didSelectedGestureLockView:(SSGestureLockView *)gestureLockView keyNumStr:(NSString *)keyNumStr{
    CCLog(@"[KeyNumber]:%@",keyNumStr);
    switch (self.gestureType) {
        case 0:
//         设置
            if (keyNumStr.length<4) {
                self.infoLable.text = @"至少连接4个点，请重新输入";
            }else{
                //第一次设置
                if (self.password.length<=0) {
                    self.password = keyNumStr;
                    self.infoLable.text = @"再次输入密码";
                    [self updateSmallView:keyNumStr];
                }else{
                //第二次设置
                    self.verifyPassword = keyNumStr;
//                  两次设置的一样--》设置成功
                    if ([self.password isEqualToString:self.verifyPassword]) {
                        self.infoLable.text = @"密码设置成功";
//                        保存密码
                        [KeychainManager keyChainSaveData:self.verifyPassword withIdentifier:@"pass"];
//                        是否需要上报后台？？？？？
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else{
//                       两次不一致，设置失败
                        self.infoLable.text = @"与上次绘制不一致，请重新绘制";
                        gestureLockView.showErrorStatus = YES;

                    }
                }
            }
            break;
        case 1:
//         验证
            if (keyNumStr.length>=4) {
                NSString * passStr = [KeychainManager keyChainReadData:@"pass"];
                [self updateSmallView:keyNumStr];

                if ([passStr isEqualToString:keyNumStr]) {
                    [SVProgressHUD showSuccessWithStatus:@"验证通过"];
                    FLTabBarViewController *main = [[FLTabBarViewController alloc] init];
                    [[UIApplication sharedApplication] keyWindow].rootViewController = main;
                }else{
                    self.infoLable.text = @"密码错误，请确认后在输入";                    gestureLockView.showErrorStatus = YES;
                }
            }else{
                 self.infoLable.text = @"至少连接4个点，请重新输入";
                gestureLockView.showErrorStatus = YES;
            }
            break;
        case 2:
//         重置
            break;
            //删除本地存储的
            
        default:
            break;
    }
    
}

-(UILabel *)infoLable{
    if (!_infoLable) {
        _infoLable = [[UILabel alloc]init];
        _infoLable.text = @"请输入密码";
        _infoLable.textColor = [UIColor redColor];
        _infoLable.font = [UIFont systemFontOfSize:14.0];
        _infoLable.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLable;
}

-(SSGestureLockView *)gestureLockView{
    if (!_gestureLockView) {
        _gestureLockView = [[SSGestureLockView alloc]initWithFrame:CGRectZero];
        _gestureLockView.delegate = self;
    }
    return _gestureLockView;
}
-(UIView *)smallView{
    if (!_smallView) {
        _smallView = [[UIView alloc]init];
//        _smallView.backgroundColor = [UIColor colorWithHexString: @"0xFFF5EE"];
    }
    return _smallView;
}

-(NSMutableArray *)smallViewArray{
    if (!_smallViewArray) {
        _smallViewArray = [NSMutableArray array];
    }
    return _smallViewArray;
}
@end
