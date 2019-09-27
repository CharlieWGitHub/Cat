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
    [one setTitleColor:HEXColor(@"0xff0") forState:UIControlStateNormal];
    [one addTarget:self action:@selector(openVpn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:one];
    
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
    UIButton * two = [UIButton buttonWithType:UIButtonTypeCustom];
    [two setTitle:@"开始" forState:UIControlStateNormal];
    [two setTitleColor:HEXColor(@"0xff0") forState:UIControlStateNormal];
    [two addTarget:self action:@selector(openVpn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:two];
    
    [two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(150);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
}

- (void)openVpn{
    [self.vpnManager startVPN];
}

- (void)closeVpn{
    [self.vpnManager stopVPN];
}

#pragma mark - Notification
- (void)vpnDidChange:(NSNotification *)notification {
    OSStatus status = self.vpnManager.vpnManager.connection.status;
    
    switch (status) {
        case NEVPNStatusConnecting:
        {
            CCLog(@"Connecting...");
//            [self.connectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
        }
            break;
        case NEVPNStatusConnected:
        {
            CCLog(@"Connected...");
//            [self.connectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
            
        }
            break;
        case NEVPNStatusDisconnecting:
        {
            CCLog(@"Disconnecting...");
            
        }
            break;
        case NEVPNStatusDisconnected:
        {
            CCLog(@"Disconnected...");
//            [self.connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
            
        }
            break;
        case NEVPNStatusInvalid:
            
            CCLog(@"Invliad");
            //             [self.connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
            break;
        case NEVPNStatusReasserting:
            CCLog(@"Reasserting...");
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
