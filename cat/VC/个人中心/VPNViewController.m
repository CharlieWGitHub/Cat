//
//  VPNViewController.m
//  cat
//
//  Created by 王成龙 on 2019/9/27.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "VPNViewController.h"
#import <NetworkExtension/NetworkExtension.h>
#import "VPNManager.h"
#import "VPNManagerModel.h"

@interface VPNViewController ()<VPNManagerDelegate>
@property (nonatomic, strong)VPNManager   *vpnManager;
@end

@implementation VPNViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationTitleLabel.text = @"关于我们";
    [self setNavigationTitleLabel];
    
    VPNManagerModel * model = [[VPNManagerModel alloc]init];
/**
 BundleId:
 serverAddress:
 serverPort:端口号
 mtu:最大传输单元字节数
 ip:ip地址
 subnet:子网掩码
 dns:
 */
    [model configureInfoWithTunnelBundleId:@"com.duotePet.cat.catVpn"
                             serverAddress:@"cat"
                                serverPort:@"5434"
                                       mtu:@"1400"
                                        ip:@"10.8.0.2"
                                    subnet:@"255.255.255.0" dns:@"255.255.255.0"];
    self.vpnManager = [[VPNManager alloc]init];
    [self.vpnManager configMangerWithModel:model];
    self.vpnManager.delegate = self;
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(vpnDidChange:) name:NEVPNStatusDidChangeNotification object:nil];
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

- (void)creatUI{
    UIButton * one = [UIButton buttonWithType:UIButtonTypeCustom];
    [one setTitle:@"开始" forState:UIControlStateNormal];
    [one setTitleColor:lRGBACOLOR(153, 0, 77, 1) forState:UIControlStateNormal];
    [one addTarget:self action:@selector(openVpn) forControlEvents:UIControlEventTouchUpInside];
    [one setBackgroundColor:lRGBACOLOR(210, 96, 145, 1)];
    [self.view addSubview:one];
    
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
    UIButton * two = [UIButton buttonWithType:UIButtonTypeCustom];
    [two setTitle:@"关闭" forState:UIControlStateNormal];
    [two setTitleColor:lRGBACOLOR(111, 249, 193, 1) forState:UIControlStateNormal];
    [two addTarget:self action:@selector(closeVpn) forControlEvents:UIControlEventTouchUpInside];
    [two setBackgroundColor:lRGBACOLOR(255, 176, 97, 1)];
    [self.view addSubview:two];
    
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(150);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
}
//开始
- (void)openVpn{
    [self.vpnManager startVPN];
}
//关闭
- (void)closeVpn{
    [self.vpnManager stopVPN];
}

#pragma mark - Notification
- (void)vpnDidChange:(NSNotification *)notification {
   NEVPNStatus status = self.vpnManager.vpnManager.connection.status;
    switch (status) {
        case NEVPNStatusConnecting:
        {
            CCLog(@"Connecting...");
            [SVProgressHUD showSuccessWithStatus:@"正在连接。。。"];
        }
            break;
        case NEVPNStatusConnected:
        {
            CCLog(@"Connected...");
            [SVProgressHUD showSuccessWithStatus:@"已经连接。。。"];
        }
            break;
        case NEVPNStatusDisconnecting:
        {
            CCLog(@"Disconnecting...");
            [SVProgressHUD showSuccessWithStatus:@"连接中断。。。"];
        }
            break;
        case NEVPNStatusDisconnected:
        {
            CCLog(@"Disconnected...");
            [SVProgressHUD showSuccessWithStatus:@"连接已中断。。。"];
        }
            break;
        case NEVPNStatusInvalid:
            CCLog(@"Invliad");
            [SVProgressHUD showSuccessWithStatus:@"无效。。。"];

            break;
        case NEVPNStatusReasserting:
            CCLog(@"Reasserting...");
            [SVProgressHUD showSuccessWithStatus:@"恢复连接。。。"];
            break;
    }
}

#pragma mark - Delegate
- (void)loadFromPreferencesComplete {
    [self vpnDidChange:nil];
}

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
